class ChatItem {
  ChatItem({
    required this.msg,
    required this.date,
    required this.isOwner
  });

  final String msg;
  final String date;
  final bool isOwner;
}