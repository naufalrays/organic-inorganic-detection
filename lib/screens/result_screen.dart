import 'package:flutter/material.dart';

import 'package:organic_inorganic_detection/models/result_model.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.result,
  }) : super(key: key);

  final ResultModel result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Label: ${result.label}"),
            Text("Confidence: ${result.confidence}"),
          ],
        ),
      ),
    );
  }
}
