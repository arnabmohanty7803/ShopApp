import 'package:flutter/material.dart';

class AnimatedProductTitle extends StatefulWidget {
  final String title;

  AnimatedProductTitle({required this.title});

  @override
  _AnimatedProductTitleState createState() => _AnimatedProductTitleState();
}

class _AnimatedProductTitleState extends State<AnimatedProductTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(
      begin: Colors.blueAccent,
      end: Colors.deepPurpleAccent,
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
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_colorAnimation.value!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.7],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}
