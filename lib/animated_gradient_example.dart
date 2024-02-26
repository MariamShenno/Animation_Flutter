import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';



class AnimatedGradientExample extends StatelessWidget {
  const AnimatedGradientExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.pink,
          Colors.pinkAccent,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.white,
          Colors.blueAccent,
          Colors.blue,
        ],
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return const Scaffold();
              }));
            },
            child: const Text(
              'Animated Gradient',
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}