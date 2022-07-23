import 'package:flutter/material.dart';

class TransitionWidget extends StatefulWidget {
  const TransitionWidget({
    Key? key,
    required this.child,
    this.durationInMilliSecs = 500,
  }) : super(key: key);
  final Widget child;
  final int durationInMilliSecs;
  @override
  _TransitionWidgetState createState() => _TransitionWidgetState();
}

class _TransitionWidgetState extends State<TransitionWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller1;
  late Animation<Offset> _animation;
  late Animation<double> _animation1;
  bool show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.durationInMilliSecs))
        .then((value) {
      setState(() {
        show = true;
      });
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0.0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1, curve: Curves.easeIn),
    ));

    _animation1 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: show ? 1 : 0,
      child: FadeTransition(
        opacity: _animation1,
        child: SlideTransition(
          position: _animation,
          child: widget.child,
        ),
      ),
    );
  }
}
