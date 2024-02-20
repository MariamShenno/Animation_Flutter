import 'package:flutter/material.dart';

class AnimatedCrossFadeValueNotifierExample extends StatefulWidget {
  const AnimatedCrossFadeValueNotifierExample({super.key});

  @override
  State<AnimatedCrossFadeValueNotifierExample> createState() =>
      _AnimatedCrossFadeValueNotifierExampleState();
}

class _AnimatedCrossFadeValueNotifierExampleState
    extends State<AnimatedCrossFadeValueNotifierExample> {
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<double> valueListener = ValueNotifier<double>(0.0);

  void onScroll() {
    valueListener.value = scrollController.offset;
  }

  void scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    valueListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ValueListenableBuilder<double>(
            valueListenable: valueListener,
            builder: (_, value, __) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: AnimatedCrossFade(
                  alignment: Alignment.center,
                  firstChild: const Icon(Icons.qr_code_scanner_sharp),
                  secondChild: const Icon(Icons.search),
                  crossFadeState: value >= kToolbarHeight
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Item $index"),
          );
        },
      ),
      floatingActionButton: ValueListenableBuilder<double>(
        valueListenable: valueListener,
        builder: (_, value, child) {
          //print("inside builder");
          return AnimatedOpacity(
            opacity: value >= 200 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: child,
          );
        },
        child: FloatingActionButton(
          onPressed: scrollToTop,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}
