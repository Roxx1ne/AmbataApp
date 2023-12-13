
class Pastry {
  final int id;
  final String name;
  final double price;
  final List<Flavour> flavours;
  final PastryCategory category;

  Pastry(this.id, this.name, this.price, this.category) : flavours = List.empty();

  Pastry.flavourful(this.id, this.name, this.price, this.flavours, this.category);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Pastry && other.id == id;
}

class Flavour {
  final String name;

  Flavour(this.name);
}

enum PastryCategory {
  none,
  bread,
  cake,
  donut,
  local,
}
