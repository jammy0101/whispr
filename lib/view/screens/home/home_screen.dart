// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/button_navigation_bar/buttom_Navigation.dart';
// import '../../../core/routes/routes_name.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
// final FirebaseAuth auth = FirebaseAuth.instance;
//
// class _HomeScreenState extends State<HomeScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomeScreen'),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//         actions: [
//           TextButton(
//             onPressed: ()async{
//               await auth.signOut();
//               Get.offAllNamed(RoutesName.loginScreen);
//             },
//             child: Icon(Icons.logout,size: 30,),
//           )
//         ],
//       ),
//       bottomNavigationBar: const BottomNavigation(index: 0,),
//       body: Column(
//         children: [
//
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/button_navigation_bar/buttom_Navigation.dart';
import '../../../core/routes/routes_name.dart';
import '../../../models/chatModel/chatModel.dart';
import '../../widgets/chats_tab/chats_lab.dart';
import '../callsTab/callTab.dart';
import '../friend/friends.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
final FirebaseAuth auth = FirebaseAuth.instance;

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    _filteredChats = _chatData;
    _searchController.addListener(_filterChats);
  }

  void _filterChats() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredChats = _chatData.where((chat) {
        final name = chat['name'].toString().toLowerCase();
        final message = chat['message'].toString().toLowerCase();
        return name.contains(query) || message.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }



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
      // body: Column(
      //   children: [
      //     const SizedBox(height: 20),
      //
      //     // 🔍 Search Bar
      //     TextField(
      //       controller: _searchController,
      //       decoration: InputDecoration(
      //         hintText: "Search Chat",
      //         prefixIcon: Icon(Icons.search),
      //         suffixIcon: Icon(Icons.qr_code_scanner),
      //         filled: true,
      //         fillColor: Colors.grey.shade200,
      //         border: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(20),
      //           borderSide: BorderSide.none,
      //         ),
      //       ),
      //     ),
      //
      //
      //     const SizedBox(height: 10),
      //
      //     // 🔄 Tab Bar (Chats | Friends | Calls)
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 20),
      //       child: DefaultTabController(
      //         length: 3,
      //         child: Column(
      //           children: [
      //             TabBar(
      //               labelColor: Colors.purple,
      //               unselectedLabelColor: Colors.black,
      //               indicatorColor: Colors.purple,
      //               tabs: [
      //                 Tab(
      //                     text: 'Chats',
      //                   icon: Icon(Icons.people),
      //                 ),
      //                 Tab(
      //                     text: 'Friends',
      //                   icon: Icon(Icons.person),
      //                 ),
      //                 Tab(
      //                     text: 'Calls',
      //                   icon: Icon(Icons.call),
      //                 ),
      //               ],
      //             ),
      //             Expanded(
      //               child: TabBarView(
      //                 children: [
      //                   ChatsTab(chats: _filteredChats),
      //                   const FriendsTab(),
      //                   const CallsTab(),
      //                 ],
      //               ),
      //             )
      //
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [

              const SizedBox(height: 10),

              // 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search Chat",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.qr_code_scanner),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 📌 Tabs
              TabBar(
                labelColor: Colors.purple,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.purple,
                tabs: const [
                  Tab(text: 'Chats', icon: Icon(Icons.people)),
                  Tab(text: 'Friends', icon: Icon(Icons.person)),
                  Tab(text: 'Calls', icon: Icon(Icons.call)),
                ],
              ),

              // 📱 Tab Views
              Expanded(
                child: TabBarView(
                  children: [
                    ChatsTab(chats: _filteredChats),
                    const FriendsTab(),
                    const CallsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }

  Widget _buildChatList() {
    final chats = [
      ChatItem(name: 'Robert Fox', message: "Hey, let’s play basketball", time: "15.43", imageUrl: 'https://i.pravatar.cc/100?img=1'),
      ChatItem(name: 'Esther Howard', message: "Perfect, see you later", time: "15.29", imageUrl: 'https://i.pravatar.cc/100?img=2', isSelected: true),
      ChatItem(name: 'Jacob Jones', message: "Oh you’re right lmao", time: "14.53", imageUrl: 'https://i.pravatar.cc/100?img=3', unreadCount: 2),
      ChatItem(name: 'Bessie Cooper', message: "Don’t forget abt tonight babe", time: "12.27", imageUrl: 'https://i.pravatar.cc/100?img=4'),
      ChatItem(name: 'Albert Flores', message: "Bro wanna play basketball...", time: "12.20", imageUrl: 'https://i.pravatar.cc/100?img=5', unreadCount: 3),
      ChatItem(name: 'Floyd Miles', message: "Haven’t seen you in a while", time: "11.40", imageUrl: 'https://i.pravatar.cc/100?img=6'),
    ];

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: chat.isSelected ? Colors.blue : Colors.purple,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(chat.imageUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chat.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      chat.message,
                      style: TextStyle(color: Colors.grey.shade700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(chat.time, style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 6),
                  if (chat.unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      child: Text(
                        chat.unreadCount.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  final List<Map<String, dynamic>> _chatData = [
    {
      'name': 'Robert Fox',
      'message': 'Hey, let’s play basketball',
      'time': '15:43',
      'imageUrl': '',
      'isSelected': false,
      'unreadCount': 0,
    },
    {
      'name': 'Esther Howard',
      'message': 'Perfect, see you later',
      'time': '15:29',
      'imageUrl': 'https://i.pravatar.cc/100?img=2',
      'isSelected': true,
      'unreadCount': 0,
    },
    {
      'name': 'Jacob Jones',
      'message': 'Can you send me the file?',
      'time': '14:50',
      'imageUrl': 'https://i.pravatar.cc/100?img=3',
      'isSelected': false,
      'unreadCount': 2,
    },
    {
      'name': 'Bessie Cooper',
      'message': 'Let’s catch up tonight!',
      'time': '13:15',
      'imageUrl': 'https://i.pravatar.cc/100?img=4',
      'isSelected': false,
      'unreadCount': 1,
    },
    {
      'name': 'Wade Warren',
      'message': 'I’ve sent the invoice',
      'time': '12:40',
      'imageUrl': 'https://i.pravatar.cc/100?img=5',
      'isSelected': false,
      'unreadCount': 0,
    },
    {
      'name': 'Devon Lane',
      'message': 'That was hilarious!',
      'time': '11:20',
      'imageUrl': 'https://i.pravatar.cc/100?img=6',
      'isSelected': false,
      'unreadCount': 4,
    },
  ];
// After when connect to the firebase
  // Future<void> _loadChatsFromFirestore() async {
  //   final snapshot = await FirebaseFirestore.instance.collection('chats').get();
  //   final data = snapshot.docs.map((doc) => doc.data()).toList();
  //
  //   setState(() {
  //     _chatData = List<Map<String, dynamic>>.from(data);
  //     _filteredChats = _chatData;
  //   });
  // }



}
