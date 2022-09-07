class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {this.isFavourite = false,
      required this.id,
      required this.description,
      required this.title,
      required this.imageUrl,
      required this.price});
}
