class ChatItem {
  final String name;
  final String message;
  final String time;
  final String imageUrl;
  final int unreadCount;
  final bool isSelected;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    this.unreadCount = 0,
    this.isSelected = false,
  });
}
