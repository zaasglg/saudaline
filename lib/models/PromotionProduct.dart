class PromotionProduct {
  final int id;
  final String title;
  final String description;
  final String brandName;
  final String brandLogoUrl;
  final String mainPhotoUrl;
  final double price;
  final String categoryName;
  final String providerName;
  final String providerLogoUrl;
  final double balance;
  final double discount;
  final double discountPrice;
  final String article;

  PromotionProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.brandName,
    required this.brandLogoUrl,
    required this.mainPhotoUrl,
    required this.price,
    required this.categoryName,
    required this.providerName,
    required this.providerLogoUrl,
    required this.balance,
    required this.discount,
    required this.discountPrice,
    required this.article,
  });

  factory PromotionProduct.fromJson(Map<String, dynamic> json) {
    return PromotionProduct(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      brandName: json['brand']['name'],
      brandLogoUrl: json['brand']['logo'][0]['url'],
      mainPhotoUrl: json['mainPhoto']['url'],
      price: json['price'].toDouble(),
      categoryName: json['category']['title'],
      providerName: json['provider']['name'],
      providerLogoUrl: json['provider']['logotype'][0]['url'],
      balance: json['provider']['balance'].toDouble(),
      discount: json['discount'].toDouble(),
      discountPrice: json['discountprice'].toDouble(),
      article: json['article'],
    );
  }
}