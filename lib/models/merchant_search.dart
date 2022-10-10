class MerchantSearch {
  int id;
  String company;
  String image;
  String address;
  double lat;
  double long;
  double? distanceFrom;
  // String bannerImage;
  // String description;
  // opening hours
  // food item tags
  // price rating 1 - 5
  // cusine type
  //
  // reviews? optional

  MerchantSearch({
    required this.id,
    required this.company,
    required this.image,
    required this.lat,
    required this.long,
    required this.address,
    this.distanceFrom,
    // required this.bannerImage,
    // required this.description,
  });
}
