class Product {
  final int id;
  final String title;
  final String description;
  final String brandName;
  final String brandLogoUrl;
  final double price;
  final String categoryTitle;
  final String providerName;
  final String providerLogoUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.brandName,
    required this.brandLogoUrl,
    required this.price,
    required this.categoryTitle,
    required this.providerName,
    required this.providerLogoUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      brandName: json['brand']['name'],
      brandLogoUrl: json['brand']['logo'][0]['url'],
      price: json['price'].toDouble(),
      categoryTitle: json['category']['title'],
      providerName: json['provider']['name'],
      providerLogoUrl: json['provider']['logotype'][0]['url'],
    );
  }
}