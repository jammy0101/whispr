import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes_name.dart';

class BottomNavigation extends StatefulWidget {
  final int index;
  const BottomNavigation({super.key, required this.index});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int myIndex = widget.index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == myIndex) return; // Prevents reloading the same screen

        setState(() {
          myIndex = index;
        });

        switch (index) {
          case 0:
            Get.offAllNamed(RoutesName.homeScreen);
            break;
          case 1:
            Get.offAllNamed(RoutesName.addUser);
            break;
          case 2:
            Get.offAllNamed(RoutesName.setting);
        }
      },
      currentIndex: myIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: '',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
            backgroundColor: Colors.white),

      ],
    );
  }
}
