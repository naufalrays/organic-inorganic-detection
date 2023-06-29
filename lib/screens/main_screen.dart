import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic_inorganic_detection/screens/about_screen.dart';
import 'package:organic_inorganic_detection/screens/home_screen.dart';
import 'package:organic_inorganic_detection/utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const AboutScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        onPressed: () {},
        child: const Icon(
          CupertinoIcons.photo_fill_on_rectangle_fill,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        // surfaceTintColor: const Color(0xFFFFFFFF),
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
                    // highlightColor: Colors.transparent,
                    // hoverColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
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
                          "Home",
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
              // Column(
              //   children: [
              //     IconButton(
              //       color: Colors.grey,
              //       icon: const Icon(Icons.home),
              //       iconSize: 32,
              //       onPressed: () {},
              //     ),
              //     const Text("Home")
              //   ],
              // ),
              // Column(
              //   children: [
              //     IconButton(
              //       color: Colors.red,
              //       icon: const Icon(Icons.person),
              //       iconSize: 32,
              //       onPressed: () {},
              //     ),
              //     const Text("Info")
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
