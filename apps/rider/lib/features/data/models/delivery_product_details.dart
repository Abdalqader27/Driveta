class DeliveryProductDetails {
  final dynamic productId;
  final dynamic offerId;
  final dynamic quantity;

  DeliveryProductDetails(
      {this.productId, this.offerId, required this.quantity});

  factory DeliveryProductDetails.fromJson(Map<String, dynamic> json) {
    return DeliveryProductDetails(
      productId: json['productId'] as String,
      offerId: json['offerId'] as String,
      quantity: json['quantity'] as num,
    );
  }

  toJson() {
    return {
      'productId': productId,
      'offerId': offerId,
      'quantity': quantity,
    };
  }
}
