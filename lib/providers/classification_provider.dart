import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organic_inorganic_detection/models/result_model.dart';
import 'package:organic_inorganic_detection/screens/result_screen.dart';
import 'package:tflite/tflite.dart';

class ClassificationProvider extends ChangeNotifier {
  Future<void> logicButtonPickImage(
      {required bool isCamera, required BuildContext context}) async {
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
      await imageClassification(path).then((value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              result: value,
              path: path,
            ),
          ),
        );
      });
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
