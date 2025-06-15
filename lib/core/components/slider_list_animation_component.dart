import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/features/animations/presentation/screens/animation_one.dart';

class SlideAnimatedListComponent extends StatefulWidget {
  final List<Widget> items;

  const SlideAnimatedListComponent({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<SlideAnimatedListComponent> createState() => _SlideAnimatedListComponentState();
}

class _SlideAnimatedListComponentState extends State<SlideAnimatedListComponent> with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late List<Animation<Offset>> _slideListAnimations;

  @override
  void initState() {
    int itemsCount = widget.items.length;
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200 * itemsCount));
    _slideListAnimations = List.generate(itemsCount, (index) {
      return Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            index / itemsCount,
            (index + 1) / itemsCount,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
    _animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) => SlideTransition(
            key: ValueKey(index),
            position: _slideListAnimations[index],
            child: widget.items[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AnimationOne());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
