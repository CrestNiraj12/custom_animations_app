import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SpringSimulation simulation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );

    simulation = SpringSimulation(

      const SpringDescription(
        mass: 0.2,
        stiffness: 10,
        damping: 0.5,
      ),
      1.0, // starting point
      10.0, // ending point
      1, // velocity
    );

    _controller.animateWith(simulation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _controller.value,
                        child: child,
                      );
                    },
                    child: const Text(
                      'You',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'are on the wrong screen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
