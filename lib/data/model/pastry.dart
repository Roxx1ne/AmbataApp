import 'flavour.dart';

class Pastry {
  final int id;
  final String name;
  final double price;
  final List<Flavour> flavours;

  Pastry(this.id, this.name, this.price) : flavours = List.empty();

  Pastry.flavourful(this.id, this.name, this.price, this.flavours);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Pastry && other.id == id;
}
