import 'package:flutter/material.dart';
import 'package:leaf_disease_identification_app/Pages/home.dart';
import 'package:leaf_disease_identification_app/Pages/results.dart';
import 'package:leaf_disease_identification_app/Pages/scan.dart';

import '../Models/results_class.dart';
import '../services/services.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Services services = Services();
  late Result result;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchResults();
  }

  Future<void> _fetchResults() async {
    try {
      result = await services.getResultsServices();
    } catch (error) {
      debugPrint(error.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("CropDetecter"),
            accountEmail: const Text("Leaf Disease Identification App"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black54,
              child: Image.asset("images/app_logo.png"),
            ),
            decoration: const BoxDecoration(
              color: Colors.black87,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            selectedColor: Colors.black,
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: const Icon(
              Icons.camera_alt,
              color: Colors.black,
            ),
            title: const Text(
              'Scan',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScanPage()),
              );
            },
            selectedColor: Colors.black,
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: const Icon(
              Icons.assessment,
              color: Colors.black,
            ),
            title: const Text(
              'Result',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    result: result,
                  ),
                ),
              );
            },
            selectedColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
