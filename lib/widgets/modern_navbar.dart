import 'package:flutter/material.dart';

class ModernNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ModernNavbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130, // Adjusted height for the container
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 19,
      ), // Add padding on left and right
      padding: EdgeInsets.fromLTRB(
        5,
        10,
        5,
        5,
      ), // Add padding to lift it above the bottom line
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home'); // Navigate to Home page
          } else {
            onTap(index);
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        iconSize: 30,
        selectedItemColor: Colors.green, // Set selected item color to green
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: List.generate(4, (index) {
          final isSelected = currentIndex == index;
          return BottomNavigationBarItem(
            icon: Align(
              alignment:
                  Alignment
                      .center, // Center the icons vertically and horizontally
              child: Container(
                decoration:
                    isSelected
                        ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.withOpacity(0.2),
                        )
                        : null,
                padding: EdgeInsets.all(8),
                child: Icon(
                  [
                    Icons.home_outlined,
                    Icons.chat_bubble_rounded,
                    Icons.notifications_outlined,
                    Icons.person_outline,
                  ][index],
                  color: isSelected ? Colors.green : Colors.grey, // Icon color
                ),
              ),
            ),
            label: ["Home", "Search", "Notifications", "Profile"][index],
          );
        }),
      ),
    );
  }
}
