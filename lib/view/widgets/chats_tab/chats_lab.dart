import 'package:flutter/material.dart';

class ChatsTab extends StatelessWidget {
  final List<Map<String, dynamic>> chats;

  const ChatsTab({super.key, required this.chats});

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: chats.length,
  //     itemBuilder: (context, index) {
  //       final chat = chats[index];
  //       final hasImage = chat['imageUrl']?.isNotEmpty ?? false;
  //       return Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  //         padding: const EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             color: chat['isSelected'] == true ? Colors.blue : Colors.purple,
  //             width: 2,
  //           ),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         child: Row(
  //           children: [
  //             CircleAvatar(
  //               radius: 30,
  //               backgroundColor: Colors.purple.shade100,
  //               backgroundImage: hasImage ? NetworkImage(chat['imageUrl']) : null,
  //               child: !hasImage
  //                   ? Text(
  //                 chat['name'][0],
  //                 style: const TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white,
  //                 ),
  //               )
  //                   : null,
  //             ),
  //             const SizedBox(width: 12),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(chat['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
  //                   const SizedBox(height: 4),
  //                   Text(
  //                     chat['message'],
  //                     style: TextStyle(color: Colors.grey.shade700),
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Column(
  //               children: [
  //                 Text(chat['time'], style: TextStyle(color: Colors.grey.shade600)),
  //                 const SizedBox(height: 6),
  //                 if ((chat['unreadCount'] ?? 0) > 0)
  //                   Container(
  //                     padding: const EdgeInsets.all(6),
  //                     decoration: const BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       color: Colors.purple,
  //                     ),
  //                     child: Text(
  //                       chat['unreadCount'].toString(),
  //                       style: const TextStyle(color: Colors.white, fontSize: 12),
  //                     ),
  //                   ),
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) {
      return const Center(
        child: Text("No chats found"),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        final hasImage = chat['imageUrl']?.isNotEmpty ?? false;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: chat['isSelected'] == true ? Colors.blue : Colors.purple,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.purple.shade100,
                backgroundImage: hasImage ? NetworkImage(chat['imageUrl']) : null,
                child: !hasImage
                    ? Text(
                  chat['name'][0],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chat['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      chat['message'],
                      style: TextStyle(color: Colors.grey.shade700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(chat['time'],
                      style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 6),
                  if ((chat['unreadCount'] ?? 0) > 0)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      child: Text(
                        chat['unreadCount'].toString(),
                        style:
                        const TextStyle(color: Colors.white, fontSize: 12),
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

}
