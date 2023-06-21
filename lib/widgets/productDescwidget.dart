import 'package:flutter/material.dart';

class AnimatedDescriptionContainer extends StatefulWidget {
  final String description;

  AnimatedDescriptionContainer({required this.description});

  @override
  _AnimatedDescriptionContainerState createState() =>
      _AnimatedDescriptionContainerState();
}

class _AnimatedDescriptionContainerState
    extends State<AnimatedDescriptionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(
      begin: Colors.cyanAccent,
      end: Colors.lightGreen,
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_colorAnimation.value!, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.7],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.description,
              textAlign: TextAlign.justify,
              softWrap: true,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
