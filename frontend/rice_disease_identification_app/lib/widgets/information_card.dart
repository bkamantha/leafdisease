import 'package:flutter/material.dart';
import 'package:rice_disease_identification_app/api_constant.dart';

// if gives error in future convert to stful
class InformationCard extends StatelessWidget {
  final String? diseaseName;
  final String? diseaseInfomations;
  final String? preventionMethod;

  final String? diseaseImage;
  const InformationCard({
    super.key,
    required this.diseaseName,
    required this.diseaseInfomations,
    required this.preventionMethod,
    required this.diseaseImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
      child: Card(
        shadowColor: Colors.black,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(
                    "${ApiConstants.bASEURL}images/F/${diseaseImage!}",
                  ),
                  height: 240,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Text(
                    diseaseName!,
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                //top: 10.0,
                left: 20.0,
                right: 20.0,
                bottom: 10.0,
              ),
              child: SizedBox(
                height: 120,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Disease Information",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        diseaseInfomations!,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Prevention Methoed",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        preventionMethod!,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
