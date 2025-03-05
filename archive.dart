// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:psoas_va_mobile/main.dart';
// import 'package:psoas_va_mobile/src/features/authentication/ui/providers/auth_states.dart';

// import '../../authentication/services/auth_service.dart';
// import '../../authentication/ui/providers/auth_provider.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final authService = AuthService();
//     final _currentIndex = 0;
//     const screens = [
//       Text('Home'),
//       Text('Apartments'),
//       Text('Settings'),
//     ];

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('vapasun'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
            
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   authService.currentUser != null
//                       ? Text((authService.currentUser!.displayName ?? 'User'))
//                       : const SizedBox.shrink(),
//                   const SizedBox(height: 10),
//                   const Center(
//                     child: Text('You have pushed the button this many times:'),
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await authProvider.signOut();
//                       Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(builder: (context) => const AuthWrapper()));
//                     },
//                     child: const Text('Sign Out'),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Add your onPressed logic here
//           },
//           tooltip: 'Increment',
//           child: const Icon(Icons.add),
//         ),
//         bottomNavigationBar: NavigationBar(
//   selectedIndex: _currentIndex,
//   onDestinationSelected: (index) => setState(() => _currentIndex = index),
//   destinations: const [
//     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
//     NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
//     NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
//   ],
// )
        
//       ),
//     );
//   }
// }


// Reserve button - contained within a SizedBox to prevent overflow
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
              //   child: apartment.reserveButton != '' ? SizedBox(
              //     height: 30.0,
              //     width: 110.0,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         final Uri apartmentUrl = Uri.parse(apartment.reserveButton);
              //         _launchUrl(apartmentUrl);
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Theme.of(context).colorScheme.primary,
              //         foregroundColor: Colors.white,
              //         // padding: const EdgeInsets.symmetric(vertical: 8.0),
              //         elevation: 2,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8.0),
              //         ),
              //       ),
              //       child: const Text(
              //         'Reserve',
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ) : SizedBox(
              //     height: 30.0,
              //     width: 110.0,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         final Uri apartmentUrl = Uri.parse(apartment.reserveButton);
              //         _launchUrl(apartmentUrl);
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Theme.of(context).copyWith(
              //           colorScheme: ColorScheme.fromSwatch(
              //             primarySwatch: Colors.grey,
              //           ),
              //         ).colorScheme.primary,
              //         foregroundColor: Colors.white,
              //         // padding: const EdgeInsets.symmetric(vertical: 8.0),
              //         elevation: 2,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8.0),
              //         ),
              //       ),
              //       child: const Text(
              //         'Reserved',
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ),
              // ),
