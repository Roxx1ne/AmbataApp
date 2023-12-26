class Pastry {
  final int id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final PastryCategory category;

  Pastry(
    this.id,
    this.name,
    this.price,
    this.description,
    this.imageUrl,
    this.category,
  );

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Pastry && other.id == id;
}

enum PastryCategory {
  none,
  bread,
  cake,
  donut,
  local,
}
