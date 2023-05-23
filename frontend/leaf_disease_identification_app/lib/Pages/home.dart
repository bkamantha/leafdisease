import 'package:flutter/material.dart';
import 'package:leaf_disease_identification_app/Pages/navbar.dart';
import 'package:leaf_disease_identification_app/services/services.dart';
import 'package:leaf_disease_identification_app/widgets/information_card.dart';
import '../Models/information.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Services _services = Services();
  List<Information> _informationList = [];
  bool isLoding = true;

  @override
  void initState() {
    super.initState();
    _fetchInformationList();
  }

  Future<void> _fetchInformationList() async {
    try {
      List<Information> informationList = await _services.getInfoServices();
      setState(() {
        _informationList = informationList;
        isLoding = false;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
    //debugPrint(_informationList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text(
            'Information',
          ),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: isLoding
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _informationList.length,
                  itemBuilder: (context, index) {
                    return InformationCard(
                      diseaseName: _informationList[index].diseaseName,
                      diseaseInfomations:
                          _informationList[index].diseaseInfomations,
                      preventionMethod:
                          _informationList[index].preventionMethod,
                      diseaseImage: _informationList[index].diseaseImages,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
