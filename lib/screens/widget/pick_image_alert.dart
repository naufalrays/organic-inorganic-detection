import 'package:flutter/material.dart';
import 'package:organic_inorganic_detection/screens/widget/full_button.dart';
import 'package:organic_inorganic_detection/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../providers/classification_provider.dart';

void showAlertDialog(BuildContext context) {
  final prov = Provider.of<ClassificationProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) {
      final size = MediaQuery.of(context).size;
      return AlertDialog(
        titlePadding: const EdgeInsets.only(left: 10, top: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: MyColors.backgroundColor,
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
              onPressed: () async {
                await prov.logicButtonPickImage(
                    isCamera: true, context: context);
              },
              text: "Kamera",
            ),
            FullButton(
              marginTop: 10,
              marginBottom: 0,
              width: size.width * 0.58,
              height: 40,
              secondaryColor: true,
              onPressed: () async {
                await prov.logicButtonPickImage(
                    isCamera: false, context: context);
              },
              text: "Galeri",
            ),
          ],
        ),
      );
    },
  );
}
