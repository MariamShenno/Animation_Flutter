import 'package:flutter/material.dart';

class AnimateCircleAvatarExample extends StatefulWidget {
  const AnimateCircleAvatarExample({super.key});

  @override
  State<AnimateCircleAvatarExample> createState() =>
      _AnimateCircleAvatarExampleState();
}

class _AnimateCircleAvatarExampleState
    extends State<AnimateCircleAvatarExample> {
  late ScrollController scrollController;
  ValueNotifier<double> selectedNotifire = ValueNotifier<double>(0.0);
  final double expandedHieght = 250;

  onLesten() {
    selectedNotifire.value =
        (scrollController.offset / (expandedHieght - 50)).clamp(0.0, 1.0);
  }

  @override
  void initState() {
    scrollController = ScrollController()..addListener(onLesten);
    super.initState();
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onLesten)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            centerTitle: false,
            leading: const SizedBox(),
            title: const Text(
              'data',
              style: TextStyle(color: Colors.white),
            ),
            stretch: true,
            backgroundColor: Colors.black,
            expandedHeight: expandedHieght,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 3.0,
              titlePadding: const EdgeInsets.all(15),
              title: AnimateCircleAvatar(selectedNotifire: selectedNotifire),
              stretchModes: const [StretchMode.zoomBackground],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('Title $index'),
                );
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimateCircleAvatar extends StatelessWidget {
  const AnimateCircleAvatar({
    super.key,
    required this.selectedNotifire,
  });

  final ValueNotifier<double> selectedNotifire;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: selectedNotifire,
      builder: (_, value, child) {
        print(value);
        return Align(
          alignment: Alignment.lerp(
              Alignment.bottomCenter, Alignment.bottomLeft, value)!,
          child: child,
        );
      },
      child: const CircleAvatar(),
    );
  }
}
