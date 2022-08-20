class Store {
  final String? id;
  final String? userName;
  final String? description;
  final String? email;
  final String? lat;
  final String? long;
  final String? name;
  final String? personalImage;
  final String? storeOwnerName;
  final String? streetId;

  Store(
      {this.id,
      this.userName,
      this.description,
      this.email,
      this.lat,
      this.long,
      this.name,
      this.personalImage,
      this.storeOwnerName,
      this.streetId});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        userName: json["userName"],
        lat: json["lat"],
        long: json["long"],
        email: json["email"],
        personalImage: json["personalImage"],
        storeOwnerName: json["storeOwnerName"],
        streetId: json["streetId"],
      );
}

class StoreDetails {
  final String? id;
  final String? userName;
  final String? description;
  final String? email;
  final String? lat;
  final String? long;
  final String? name;
  final String? personalImage;
  final String? storeOwnerName;
  final String? streetId;
  final List<Product>? products;

  StoreDetails(
      {this.id,
      this.userName,
      this.description,
      this.email,
      this.lat,
      this.long,
      this.name,
      this.personalImage,
      this.storeOwnerName,
      this.products,
      this.streetId});

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        userName: json["userName"],
        lat: json["lat"],
        products: List.from((json["products"]).map((i) => Product.fromJson(i))),
        long: json["long"],
        email: json["email"],
        personalImage: json["personalImage"],
        storeOwnerName: json["storeOwnerName"],
        streetId: json["streetId"],
      );
}

class Product {
  final String? id;
  final String? name;
  final String? description;
  final num? defaultPrice;

  Product({
    this.id,
    this.description,
    this.defaultPrice,
    this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        defaultPrice: json["defaultPrice"],
      );
}
