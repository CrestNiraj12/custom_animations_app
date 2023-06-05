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
              SizedBox(
                height: 200,
                width: 200,
                child: SvgPicture.asset(
                  'assets/icons/sad.svg',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  Transform.rotate(
                    angle: 100,
                    child: const Text(
                      'You',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text('are'),
                  const Text('on'),
                  const Text('the'),
                  const Text('wrong'),
                  const Text('screen'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
