class PlacePredictions {
  final String secondaryText;
  final String mainText;
  final String placeId;

  PlacePredictions(
      {required this.secondaryText,
      required this.mainText,
      required this.placeId});

  factory PlacePredictions.fromJson(Map<String, dynamic> json) {
    return PlacePredictions(
        secondaryText: json["structured_formatting"]["secondary_text"],
        placeId: json["place_id"],
        mainText: json["structured_formatting"]["main_text"]);
  }
}
