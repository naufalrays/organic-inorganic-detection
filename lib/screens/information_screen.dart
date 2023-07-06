import 'package:flutter/material.dart';

import 'package:organic_inorganic_detection/utils/colors.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({
    Key? key,
    required this.isOrganic,
  }) : super(key: key);
  final bool isOrganic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_sharp,
            color: MyColors.primary,
          ),
        ),
        title: Text(
          isOrganic ? "Sampah Organik" : "Sampah Anorganik",
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: MyColors.primary),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: isOrganic
                    ? const AssetImage("assets/images/sampah_organik.jpg")
                    : const AssetImage("assets/images/sampah_anorganik.jpg"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: MyColors.secondary,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: isOrganic
                    ? const Text(
                        "Sampah Organik adalah sampah yang berasal dari sisa makhluk hidup (alam) seperti hewan, manusia, tumbuhan, dan benda hasil olahannya yang dapat mengalami pembusukan atau pelapukan. \n\nProses pembusukan atau pelapukan sampah organik berlangsung secara alami dengan bantuan mikroorganisme tanpa tambahan bahan kimia dalam waktu yang singkat.",
                        textAlign: TextAlign.justify,
                      )
                    : const Text(
                        "Sampah Anorganik adalah sampah yang tidak dapat diuraikan oleh mikroorganisme di dalam tanah hingga menyebabkan proses penghancuran yang berlangsung sangat lama. \n\nSampah Anorganik berasal dari sumber daya alam tak terbaharui seperti mineral dan minyak bumi, atau dari proses industri.",
                        textAlign: TextAlign.justify,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
