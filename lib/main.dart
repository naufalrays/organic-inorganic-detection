import 'package:flutter/material.dart';
import 'package:organic_inorganic_detection/providers/classification_provider.dart';
import 'package:organic_inorganic_detection/providers/main_provider.dart';
import 'package:organic_inorganic_detection/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ClassificationProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MainProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Classification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}
