class Attachment {
  final String id;
  final String taskId;
  final String imageUrl;
  final String fileName;
  final DateTime createdAt;

  Attachment({
    required this.id,
    required this.taskId,
    required this.imageUrl,
    required this.fileName,
    required this.createdAt,
  });
}
