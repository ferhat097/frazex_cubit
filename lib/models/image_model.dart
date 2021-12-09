class ImageModel {
  String imageUrl;
  String photographer;

  ImageModel({
    required this.imageUrl,
    required this.photographer,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
        imageUrl: json["src"]["medium"], photographer: json["photographer"]);
  }
}
