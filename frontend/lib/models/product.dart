class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final List<String> images;
  final String category;
  final String? id;
  final String? userId;

  //<editor-fold desc="Data Methods">
  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.images,
    required this.category,
    this.id,
    this.userId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          quantity == other.quantity &&
          images == other.images &&
          category == other.category &&
          id == other.id &&
          userId == other.userId);

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      images.hashCode ^
      category.hashCode ^
      id.hashCode ^
      userId.hashCode;

  @override
  String toString() {
    return 'Product{' +
        ' name: $name,' +
        ' description: $description,' +
        ' price: $price,' +
        ' quantity: $quantity,' +
        ' images: $images,' +
        ' category: $category,' +
        ' id: $id,' +
        ' userId: $userId,' +
        '}';
  }

  Product copyWith({
    String? name,
    String? description,
    double? price,
    double? quantity,
    List<String>? images,
    String? category,
    String? id,
    String? userId,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      category: category ?? this.category,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'quantity': this.quantity,
      'images': this.images,
      'category': this.category,
      'id': this.id,
      'userId': this.userId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as double,
      images: map['images'] as List<String>,
      category: map['category'] as String,
      id: map['_id'] as String,
      userId: map['userId'] as String,
    );
  }

  //</editor-fold>
}
