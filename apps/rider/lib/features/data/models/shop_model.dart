class ShopModel {
  final String name;
  final String? image;
  final String id;
  String? long;
  String? lat;

  ShopModel({
    required this.name,
    this.image,
    required this.id,
    this.long,
    this.lat,
  });
}

class TabsContentCount {
  final int imageCount;
  final int notificationsCount;
  final int offersCount;

  TabsContentCount({
    required this.imageCount,
    required this.notificationsCount,
    required this.offersCount,
  });
}
