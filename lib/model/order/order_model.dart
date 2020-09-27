class OrderModel {
  final String id;
  final String name;
  final String categoryName;
  final double price;
  int quantity;
  final DateTime dateTime;

  OrderModel(
      {this.id,
      this.name,
      this.categoryName,
      this.price,
      this.quantity = 1,
      this.dateTime});
}
