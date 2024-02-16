import 'package:flutter/material.dart';

class AnimatedPhysicalModelExplicitExample extends StatefulWidget {
  const AnimatedPhysicalModelExplicitExample({super.key});

  @override
  State<AnimatedPhysicalModelExplicitExample> createState() =>
      _AnimatedPhysicalModelExplicitExampleState();
}

class _AnimatedPhysicalModelExplicitExampleState
    extends State<AnimatedPhysicalModelExplicitExample>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> borderRadiusAnimation;
  late Animation<double> elevationAnimation;
  late Animation<Color?> colorAnimation;
  late Animation<Color?> iconColorAnimation;
  late Animation<Offset> iconShadwoColorAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    colorAnimation =
        ColorTween(begin: Colors.white, end: Colors.blueGrey).animate(controller);
    iconColorAnimation =
        ColorTween(begin: Colors.yellowAccent, end: Colors.orangeAccent)
            .animate(controller);
    iconShadwoColorAnimation = Tween(
      begin: const Offset(-1, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    borderRadiusAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 12.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 237, 237),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Animated Physical Model",
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return AnimatedPhysicalModel(
              duration: const Duration(milliseconds: 1000),
              shape: BoxShape.circle,
              shadowColor: colorAnimation.value ?? Colors.white,
              //const Color.fromARGB(255, 109, 16, 126),
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(borderRadiusAnimation.value),
                bottomRight: Radius.circular(borderRadiusAnimation.value),
              ),
              elevation: elevationAnimation.value,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadiusAnimation.value),
                    bottomRight: Radius.circular(borderRadiusAnimation.value),
                  ),
                ),
                child: Icon(
                  Icons.apple_outlined,
                  size: 50,
                  color: iconColorAnimation.value ?? Colors.orangeAccent,
                  shadows: [
                    Shadow(
                      offset: iconShadwoColorAnimation.value,
                      color: Colors.grey,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
