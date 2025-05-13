import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    // Automatically focus the text field when the page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary; // Your green color
    
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: isDarkMode ? const Color(0xFF121212) : theme.colorScheme.surface,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => context.go('/apartments'), // Return to apartments page
      //   ),
      //   title: Text(
      //     'Search',
      //     style: TextStyle(
      //       color: isDarkMode ? primaryColor : theme.colorScheme.onSurface,
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Search for apartments, houses...',
                prefixIcon: Icon(Icons.search, color: primaryColor),
                suffixIcon: IconButton(
                  icon: Icon(Icons.tune, color: primaryColor),
                  onPressed: () {
                    // Show filters
                    print('Filter button pressed');
                  },
                ),
                filled: true,
                fillColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
                  ),
                ),
              ),
              onChanged: (value) {
                // Handle search as user types
                setState(() {});
              },
              onSubmitted: (value) {
                // Handle search submission
                print('Search submitted: $value');
              },
            ),
          ),
          
          // Recent searches section
          if (_searchController.text.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildRecentSearch(context, 'Two bedroom apartment'),
                  _buildRecentSearch(context, 'Houses with garden'),
                  _buildRecentSearch(context, 'Studio apartments'),
                ],
              ),
            )
          else
            // Search results (simulated)
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        index % 2 == 0 ? Icons.apartment : Icons.home,
                        color: primaryColor,
                      ),
                    ),
                    title: Text('Search Result ${index + 1}'),
                    subtitle: Text(
                      index % 2 == 0 
                          ? '2 bed • 1 bath • 75m²' 
                          : '3 bed • 2 bath • 120m²'
                    ),
                    trailing: Text(
                      index % 2 == 0 ? '\$1,200/mo' : '\$1,800/mo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    onTap: () {
                      // Navigate to apartment details
                      print('Navigating to apartment $index');
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildRecentSearch(BuildContext context, String searchText) {
    return InkWell(
      onTap: () {
        _searchController.text = searchText;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            const Icon(Icons.history, size: 18, color: Colors.grey),
            const SizedBox(width: 12),
            Text(searchText),
            const Spacer(),
            const Icon(Icons.north_west, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
