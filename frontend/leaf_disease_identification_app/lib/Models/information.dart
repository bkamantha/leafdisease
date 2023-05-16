class Information {
  final String? diseaseImages;
  final String? diseaseName;
  final String? diseaseInfomations;
  final String? preventionMethod;

  Information({
    required this.diseaseImages,
    required this.diseaseName,
    required this.diseaseInfomations,
    required this.preventionMethod,
  });

  factory Information.fromJson(Map<String, dynamic> json) => Information(
        diseaseImages: json["Disease Images"],
        diseaseName: json["Disease Name"],
        diseaseInfomations: json["Disease Infomations"],
        preventionMethod: json["Prevention Method"],
      );

  Map<String, dynamic> toJson() => {
        "Disease Images": diseaseImages,
        "Disease Name": diseaseName,
        "Disease Infomations": diseaseInfomations,
        "Prevention Method": preventionMethod,
      };

  @override
  String toString() {
    return 'Information {Disease Name: $diseaseName, Disease Infomations: $diseaseInfomations, Prevention Method: $preventionMethod, Disease Images: $diseaseImages}';
  }
}
