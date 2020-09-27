class Product {
  final String id;
  final String name;
  final String description;
  final String categoryName;
  final String imagePath;
  final double price;
  bool isFavourite;

  Product(
      {this.id,
      this.name,
      this.description,
      this.categoryName,
      this.price,
      this.imagePath,
      this.isFavourite = false});
}
