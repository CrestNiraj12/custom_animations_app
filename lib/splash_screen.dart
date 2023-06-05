import 'package:custom_animation_app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const maxSize = 200;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _tapped = false;
  bool _longPress = false;
  double _width = 100;
  double _height = 100;
  double _angle = 0;
  double? _top;

  void increaseSize() async {
    if (_width >= maxSize) {
      await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MyHomePage(title: 'haha'),
            transitionDuration: const Duration(milliseconds: 50),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ));
      setState(() {
        _width = 100;
        _height = 100;
        _angle = 0;
        _top = MediaQuery.of(context).size.height / 2 - 50;
      });

      return;
    }
    await Future.delayed(const Duration(milliseconds: 10));
    setState(() {
      _width += 2;
      _height += 2;
      _angle += 0.45;
      _top = _top == null
          ? MediaQuery.of(context).size.height / 2 - 55
          : _top! - 5;
    });

    if (_longPress) {
      increaseSize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _tapped = !_tapped;
            });
          },
          onLongPress: () {
            setState(() {
              _longPress = true;
            });

            increaseSize();
          },
          onLongPressEnd: (_) {
            setState(() {
              _longPress = false;
            });
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  width: _width,
                  height: _height,
                  top: _top ?? MediaQuery.of(context).size.height / 2 - 50,
                  key: ValueKey<int>(_tapped ? 0 : 1),
                  curve: Curves.bounceOut,
                  duration: const Duration(milliseconds: 10),
                  child: Transform.rotate(
                    angle: _angle,
                    child: SvgPicture.asset(
                      'assets/icons/${_tapped ? 'smile' : 'sad'}.svg',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
