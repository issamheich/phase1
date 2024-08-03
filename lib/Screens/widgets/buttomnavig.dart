import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<dynamic> myList;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.red,
      backgroundColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library),
          label: 'Coming Soon',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_download),
          label: 'Downloads',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            // Add navigation for 'Coming Soon' if necessary
            break;
          case 2:
            Navigator.pushNamed(context, '/mylist', arguments: myList);
            break;
        }
      },
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Colors.white),
    );
  }
}
