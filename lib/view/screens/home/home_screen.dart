import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/button_navigation_bar/buttom_Navigation.dart';
import '../../../core/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
final FirebaseAuth auth = FirebaseAuth.instance;

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          TextButton(
            onPressed: ()async{
              await auth.signOut();
              Get.offAllNamed(RoutesName.loginScreen);
            },
            child: Icon(Icons.logout,size: 30,),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigation(index: 0,),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
