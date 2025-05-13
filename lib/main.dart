import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/firebase_options.dart';
import 'package:psoas_va_mobile/src/common/app_preferences.dart';
import 'package:psoas_va_mobile/src/config/themes/app_theme.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/data_source/apartment_data_source.dart';
import 'package:psoas_va_mobile/src/features/apartments/data/models/apartment_hive_model.dart';
import 'src/features/apartments/data/models/apartment_model.dart';
import 'src/features/apartments/data/repo/apartment_repo.dart';
import 'src/features/apartments/domain/providers/apartment_provider.dart';
import 'src/features/apartments/domain/providers/dream_apartment_provider.dart';
import 'src/router/app_router.dart';
import 'src/common/providers/screen_switch_provider.dart';
import 'src/common/providers/theme_provider.dart';
import 'src/features/authentication/ui/providers/auth_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  AppPreferences().init();

  // definitions of variables
  ApartmentDataSource apartmentDataSource = ApartmentDataSource();
  ApartmentRepo apartmentRepo = ApartmentRepo(apartmentDataSource);

  

  // hive initialization
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // register adapter
  Hive.registerAdapter(ApartmentHiveModelAdapter());

  // Open the Hive Apartment box
  // await Hive.openBox<ApartmentModel>('apartmentsBox');
  // use hive box with the correct type
  await Hive.openBox<ApartmentHiveModel>('apartmentsHiveBox');

  // delete hive box
  // await Hive.deleteBoxFromDisk('apartmentsHiveBox');



  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
  OneSignal.Notifications.requestPermission(true);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ScreenSwitchProvider()),
    ChangeNotifierProvider(create: (_) => ApartmentProvider(repository: apartmentRepo)),
    ChangeNotifierProvider(create: (_) => DreamApartmentProvider(repository: apartmentRepo)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      
      debugShowCheckedModeBanner: false,
      title: 'Vapasun',
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

     // Use GoRouter to navigate based on authentication state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authProvider.user != null) {
        context.go('/apartments');
      } else {
        context.go('/signin');
      }
    });

    // reroute using gorouter
    return const SizedBox.shrink();

  }
}
