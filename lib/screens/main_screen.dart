import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic_inorganic_detection/screens/widget/pick_image_alert.dart';
import 'package:organic_inorganic_detection/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

import '../providers/main_provider.dart';

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
    debugPrint(res);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, data, _) {
      return Scaffold(
        body: data.screens[data.index],
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.primary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
          onPressed: () {
            showAlertDialog(context);
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
                      onPressed: () => data.selectDestionation(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: data.index == 0
                                ? MyColors.primary
                                : Colors.black,
                          ),
                          Text(
                            "Beranda",
                            style: TextStyle(
                              color: data.index == 0
                                  ? MyColors.primary
                                  : Colors.black,
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
                      onPressed: () => data.selectDestionation(1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            color: data.index == 1
                                ? MyColors.primary
                                : Colors.black,
                          ),
                          Text(
                            "Info",
                            style: TextStyle(
                              color: data.index == 1
                                  ? MyColors.primary
                                  : Colors.black,
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
    });
  }
}
