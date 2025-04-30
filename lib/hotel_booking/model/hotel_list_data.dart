class HotelListData {
  final String imagePath;
  final String titleTxt;
  final String subTxt;
  final double dist;
  final int reviews;
  final double rating;
  final int perNight;

  HotelListData({
    required this.imagePath,
    required this.titleTxt,
    required this.subTxt,
    required this.dist,
    required this.reviews,
    required this.rating,
    required this.perNight,
  });

  factory HotelListData.fromJson(Map<String, dynamic> json) {
    return HotelListData(
      imagePath: json['imagePath'],
      titleTxt: json['titleTxt'],
      subTxt: json['subTxt'],
      dist: (json['dist'] as num).toDouble(),
      reviews: json['reviews'],
      rating: (json['rating'] as num).toDouble(),
      perNight: json['perNight'],
    );
  }
}
