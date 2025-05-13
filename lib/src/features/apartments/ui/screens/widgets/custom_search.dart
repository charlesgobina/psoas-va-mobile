import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onFilterTap;
  final String hintText;
  final String? subHintText;
  
  const CustomSearchBar({
    super.key,
    required this.onTap,
    required this.onFilterTap,
    this.hintText = 'Find Your New',
    this.subHintText = 'apartment, house, lands and more',
  });

  @override
  Widget build(BuildContext context) {
    // Get colors from theme
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary; // Your green color
    final surfaceColor = isDarkMode 
        ? const Color(0xFF1E1E1E) // Slightly lighter than dark background for elevation
        : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final iconColor = isDarkMode ? primaryColor : Colors.grey[700];
    final dividerColor = isDarkMode ? Colors.grey[700] : Colors.grey[300];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
                blurRadius: 4.0,
                spreadRadius: isDarkMode ? 0 : 1.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(
                Icons.search,
                color: iconColor,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hintText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    if (subHintText != null)
                      Text(
                        subHintText!,
                        style: TextStyle(
                          fontSize: 12,
                          color: subTextColor,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                height: 36,
                width: 1,
                color: dividerColor,
              ),
              IconButton(
                icon: Icon(
                  Icons.tune,  // Filter icon
                  color: iconColor,
                  size: 20,
                ),
                onPressed: onFilterTap,
                splashRadius: 20, // Smaller splash for better UX
              ),
            ],
          ),
        ),
      ),
    );
  }
}
