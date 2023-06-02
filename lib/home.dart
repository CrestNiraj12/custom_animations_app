import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: 'image',
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: SvgPicture.asset(
                    'assets/icons/sad.svg',
                  ),
                ),
              ),
              const Text("HAHAHAHAs"),
            ],
          ),
        ),
      ),
    );
  }
}
