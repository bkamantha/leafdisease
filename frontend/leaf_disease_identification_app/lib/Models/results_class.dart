class Result {
  final DiseaseImages diseaseImages;
  final String? resultInfo;
  final String? diseaseName;
  final String? diseaseInformations;
  final String? preventionMethod;
  final List<String>? comments;

  Result({
    required this.comments,
    required this.diseaseImages,
    required this.resultInfo,
    required this.diseaseName,
    required this.diseaseInformations,
    required this.preventionMethod,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      diseaseImages: DiseaseImages.fromJson(json["Disease Images"]),
      resultInfo: json["ResultInfo"],
      diseaseName: json["Disease Name"],
      diseaseInformations: json["Disease Infomations"],
      preventionMethod: json["Prevention Method"],
      comments: json["Comments"] != null
          ? List<String>.from(json["Comments"].map((x) => x))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Disease Images": diseaseImages.toJson(),
      "ResultInfo": resultInfo,
      "Disease Name": diseaseName,
      "Disease Informations": diseaseInformations,
      "Prevention Method": preventionMethod,
      "Comments":
          comments != null ? List<dynamic>.from(comments!.map((x) => x)) : null,
    };
  }
}

class DiseaseImages {
  List<int> d;
  List<int> i;
  List<int> a;

  DiseaseImages({
    required this.d,
    required this.i,
    required this.a,
  });

  factory DiseaseImages.fromJson(Map<String, dynamic> json) => DiseaseImages(
        d: List<int>.from(json["D"].map((x) => x)),
        i: List<int>.from(json["I"].map((x) => x)),
        a: List<int>.from(json["A"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "D": List<dynamic>.from(d.map((x) => x)),
        "I": List<dynamic>.from(i.map((x) => x)),
        "A": List<dynamic>.from(a.map((x) => x)),
      };
}
