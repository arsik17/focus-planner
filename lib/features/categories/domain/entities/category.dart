class Category {
  final String id;
  final String userId;
  final String name;
  final String color;
  final String icon;
  final bool isDefault;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.color,
    required this.icon,
    required this.isDefault,
    required this.createdAt,
  });
}
