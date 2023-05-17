import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leaf_disease_identification_app/Models/results_class.dart';
import 'package:leaf_disease_identification_app/Pages/navbar.dart';
import 'package:leaf_disease_identification_app/Pages/results.dart';
import 'package:leaf_disease_identification_app/services/services.dart';
import 'package:quickalert/quickalert.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({
    super.key,
  });

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late Result result;
  bool isLoding = false;
  final ImagePicker _picker =
      ImagePicker(); //to save image picker type (gallery/camera)
  String? imgFileName = "";
  XFile? imageFile;

  void showAlert(String text) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      backgroundColor: Colors.white,
      textColor: Colors.black,
      titleColor: Colors.black,
      text: '${text.toString()} !!',
      autoCloseDuration: const Duration(seconds: 5),
      confirmBtnColor: Colors.black,
      onConfirmBtnTap: () {
        setState(() {
          imageFile = null;
          Navigator.pop(context);
        });
      },
    );
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
          title: Text('Scan'),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Scan For Image",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: ((builder) => bottomImageDrawer()),
                    );
                  },
                  radius: (MediaQuery.of(context).size.width) * 0.15,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 25.0,
                    ),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: (imageFile == null)
                            ? const AssetImage('images/brinjel_leaf.png')
                            : FileImage(File(imageFile!.path)) as ImageProvider,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.black87,
                          size: 45,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    minimumSize: const Size(250, 50)),
                onPressed: () {
                  if (imageFile != null) {
                    setState(() {
                      isLoding = true;
                    });
                    Services().imageUploadService(imageFile).then((val) async {
                      if (val.data != null) {
                        if (val.data["status"] == 'null') {
                          showAlert(
                              "Identification Failed, Please uplod another image");
                          setState(() {
                            imageFile = null;
                          });
                        } else {
                          result = Result.fromJson(val.data);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(
                                result: result,
                              ),
                            ),
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg:
                              "Backend falir or No response. plese check the backend",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      setState(() {
                        isLoding =
                            false; // set the boolean flag back to false to hide the progress indicator
                      });
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: "Please select an image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: const Text('Upload'),
              ),
              const SizedBox(
                height: 20,
              ),
              isLoding
                  ? const CircularProgressIndicator(
                      color: Colors.black54,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  //Bottom drawer widget when uploading image
  Widget bottomImageDrawer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 190,
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 30.0,
              ),
              child: Text(
                'Add a Disease Photo',
                style: TextStyle(
                  fontSize: 23.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  //--Camera Button--
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                  ),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  label: const Text(
                    'Camera',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40.0,
                ),
                ElevatedButton.icon(
                  //---Gallery button--
                  icon: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                  ),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: const Text(
                    'Gallery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void takePhoto(ImageSource sourceATR) async {
    try {
      final pickedFile =
          await _picker.pickImage(source: sourceATR, imageQuality: 50);

      setState(() {
        imageFile = pickedFile!;
        Navigator.pop(context);
        //imgFileName = imageFile!.path;
        //String ImgfileName = _imageFile!.path.split('/').last;
      });

      // Getting the path of the image from deivce
      //imgFileName = imageFile!.path;
      debugPrint(imgFileName);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Please select an image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red[900],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
