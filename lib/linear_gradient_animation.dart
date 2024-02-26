import 'package:flutter/material.dart';

class LinearGradientAnimation extends StatefulWidget {
  const LinearGradientAnimation({Key? key}) : super(key: key);

  @override
  State<LinearGradientAnimation> createState() =>
      _LinearGradientAnimationState();
}

class _LinearGradientAnimationState extends State<LinearGradientAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController.unbounded(
      vsync: this,
    )..repeat(min: -0.5, max: 1.5, period: const Duration(seconds: 5));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 250,
          width: 250,
          color: Colors.redAccent,
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) => ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) {
                return LinearGradient(
                  transform: LinearTransform(animation: controller.value),
                  colors: const [
                    Colors.black,
                    Colors.white,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: child,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  heightFactor: 0.8,
                  child: Icon(Icons.keyboard_arrow_up_outlined, size: 50),
                ),
                Align(
                  heightFactor: 0.8,
                  child: Icon(Icons.keyboard_arrow_up_outlined, size: 50),
                ),
                Align(
                  heightFactor: 0.8,
                  child: Icon(Icons.keyboard_arrow_up_outlined, size: 50),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinearTransform extends GradientTransform {
  final double animation;
  const LinearTransform({required this.animation});
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(0.0, -animation * bounds.height, 0.0);
  }
}
