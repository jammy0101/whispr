import 'package:flutter/material.dart';

import '../../../core/button_navigation_bar/buttom_Navigation.dart';




class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Here i want to add the setting option '),
        centerTitle: true,

      ),
      bottomNavigationBar: const BottomNavigation(index: 2,),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
