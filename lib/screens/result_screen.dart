import 'dart:io';
import 'package:flutter/material.dart';
import 'package:organic_inorganic_detection/models/result_model.dart';
import 'package:organic_inorganic_detection/utils/colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.result,
    required this.path,
  }) : super(key: key);

  final ResultModel result;
  final String path;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isOrganik = result.label == 'Organik';
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: MyColors.backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_sharp,
            color: MyColors.primary,
          ),
        ),
        title: const Text(
          "Hasil Klasifikasi",
          style:
              TextStyle(fontWeight: FontWeight.w700, color: MyColors.primary),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.123),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: size.height - 450,
                  child: Image.file(
                    File(path),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Card(
                color: MyColors.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: 'Prediksi: ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: result.label,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isOrganik
                                        ? MyColors.primary
                                        : Colors.blue))
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                text: 'Persentase: ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: '${(result.confidence * 100)} %',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isOrganik
                                        ? MyColors.primary
                                        : Colors.blue))
                          ],
                        ),
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
