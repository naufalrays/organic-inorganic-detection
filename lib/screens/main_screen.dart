import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organic_inorganic_detection/models/result_model.dart';
import 'package:organic_inorganic_detection/screens/about_screen.dart';
import 'package:organic_inorganic_detection/screens/home_screen.dart';
import 'package:organic_inorganic_detection/screens/result_screen.dart';
import 'package:organic_inorganic_detection/screens/widget/full_button.dart';
import 'package:organic_inorganic_detection/utils/colors.dart';
import 'package:tflite/tflite.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    loadModel();
    super.initState();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
      model: "assets/klasifikasi_model.tflite",
      labels: "assets/labels.txt",
    ))!;
    print(res);
  }

  List<Widget> screens = [
    const HomeScreen(),
    const AboutScreen(),
  ];

  int index = 0;

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          titlePadding: const EdgeInsets.only(left: 10, top: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          backgroundColor: Colors.white,
          title: Align(
            alignment: AlignmentDirectional.centerStart,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close),
            ),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
          contentPadding: const EdgeInsets.only(top: 0, bottom: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Ambil Gambar Dengan: "),
              FullButton(
                marginTop: 5,
                marginBottom: 0,
                width: size.width * 0.58,
                height: 40,
                onPressed: () {
                  logicButtonPickImage(isCamera: true);
                },
                text: "Kamera",
              ),
              FullButton(
                marginTop: 10,
                marginBottom: 0,
                width: size.width * 0.58,
                height: 40,
                secondaryColor: true,
                onPressed: () {
                  logicButtonPickImage(isCamera: false);
                },
                text: "Galeri",
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        onPressed: () {
          showAlertDialog();
        },
        child: const Icon(
          size: 40,
          CupertinoIcons.camera_viewfinder,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  MaterialButton(
                    splashColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: index == 0 ? MyColors.primary : Colors.black,
                        ),
                        Text(
                          "Beranda",
                          style: TextStyle(
                            color: index == 0 ? MyColors.primary : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    splashColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: index == 1 ? MyColors.primary : Colors.black,
                        ),
                        Text(
                          "Info",
                          style: TextStyle(
                            color: index == 1 ? MyColors.primary : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logicButtonPickImage({required bool isCamera}) async {
    final picker = ImagePicker();

    String path = '';

    try {
      final getImage = await picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (getImage != null) {
        path = getImage.path;
      } else {
        path = '';
      }
    } catch (e) {
      e.toString();
    }
    if (path != '') {
      ResultModel result = await imageClassification(path);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            result: result,
            path: path,
          ),
        ),
      );
    }
  }

  Future<ResultModel> imageClassification(String path) async {
    List recognitions;
    recognitions = (await Tflite.runModelOnImage(
        path: path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 224.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        ))!;
    ResultModel result = ResultModel(
        label: recognitions[0]['label'],
        confidence: recognitions[0]['confidence']);
    return result;
  }
}
