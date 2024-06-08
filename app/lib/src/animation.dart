import 'package:flutter/material.dart';

class TheAnimation extends StatefulWidget {
  const TheAnimation({super.key});

  static const redColors = [
    Color(0xff9A4559),
    Color(0xffB0445E),
    Color(0xffC1405F),
    Color(0xffD74165),
    Color(0xFFEF476F),
  ];

  static const greenColors = [
    Color(0xff5C9083),
    Color(0xff58A08E),
    Color(0xff4AAD93),
    Color(0xff28C99F),
    Color(0xff06D6A0),
  ];

  @override
  State<TheAnimation> createState() => _TheAnimationState();
}

class _TheAnimationState extends State<TheAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  bool state = false;

  List<Color> get colors =>
      state ? TheAnimation.greenColors : TheAnimation.redColors;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      reverseDuration: const Duration(milliseconds: 400),
      vsync: this,
    )..addListener(() async {
        if (controller.value > 0.3) {
          setState(() {
            state = !state;
          });
          await controller.reverse();
          controller.reset();
        }
      });

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.bounceInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTapDown: (_) {
        controller.forward();
      },
      onTapUp: (_) {
        controller.reverse();
      },
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final aap = 2 - animation.value;

          final one = size.height * 0.1 * aap;
          final two = one * 0.8 * aap;
          final three = two * 0.8 * aap;
          final four = three * 0.8 * aap;

          return Stack(
            alignment: Alignment.center,
            children: [
              // Background
              Positioned(
                height: size.height,
                child: Container(
                  color: colors[0],
                  height: size.height,
                  width: size.width,
                ),
              ),
              Positioned(
                height: four,
                child: Container(
                  height: four,
                  width: four,
                  decoration: BoxDecoration(
                    color: colors[1],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                height: three,
                child: Container(
                  height: three,
                  width: three,
                  decoration: BoxDecoration(
                    color: colors[2],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                height: two,
                child: Container(
                  height: two,
                  width: two,
                  decoration: BoxDecoration(
                    color: colors[3],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                height: one,
                child: Container(
                  height: one,
                  width: one,
                  decoration: BoxDecoration(
                    color: colors[4],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
