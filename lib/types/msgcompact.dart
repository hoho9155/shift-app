class MsgCompact {
  MsgCompact({
    required this.name,
    required this.lastMsg,
    required this.dayAgo,
    required this.otherID,
  });

  final int otherID;
  final String name;
  final String lastMsg;
  final String dayAgo;
}