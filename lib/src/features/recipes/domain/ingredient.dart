// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ingredient {
  const Ingredient({
    this.quantity,
    this.unit,
    required this.name,
  });

  final double? quantity;
  final String? unit;
  final String name;

  Ingredient copyWith({
    double? quantity,
    String? unit,
    String? name,
  }) {
    return Ingredient(
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      name: name ?? this.name,
    );
  }
}
