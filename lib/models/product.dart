class Product {
  int? id;
  String? title;
  String? image;
  int? price;
  String? description;
  String? brand;
  String? model;
  String? color;
  String? category;
  int? discount;

  Product(
      {this.id,
      this.title,
      this.image,
      this.price,
      this.description,
      this.brand,
      this.model,
      this.color,
      this.category,
      this.discount});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    category = json['category'];
    discount = json['discount'];
  }

  
}
