class MerchantSearch {
  int id;
  String company;
  String logoUrl;
  String bannerUrl;
  String address;
  double lat;
  double long;
  String cusineType;
  int priceRating;
  String operatingHours;
  String description;
  double? distanceFrom;

  // reviews? optional

  MerchantSearch({
    required this.id,
    required this.company,
    required this.logoUrl,
    required this.bannerUrl,
    required this.address,
    required this.lat,
    required this.long,
    required this.cusineType,
    required this.priceRating,
    required this.operatingHours,
    required this.description,
    this.distanceFrom,
  });
}
