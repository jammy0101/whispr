import 'package:flutter/material.dart';

import '../../../core/button_navigation_bar/buttom_Navigation.dart';



class Adduser extends StatefulWidget {
  const Adduser({super.key});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      bottomNavigationBar: const BottomNavigation(index: 1,),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
