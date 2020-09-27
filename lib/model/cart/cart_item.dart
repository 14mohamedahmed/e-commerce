class CartItem {
  final String id;
  final String name;
  final String categoryName;
  final double price;
  final String imagePath;
  int quantity;
  CartItem(
      {this.id,
      this.name,
      this.categoryName,
      this.price,
      this.imagePath,
      this.quantity = 1});
}
