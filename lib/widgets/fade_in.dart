import 'dart:async';
import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;
  final int index;

  const FadeIn({super.key, required this.child, this.index = 0});

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    final stagger = widget.index * 50;
    _opacity = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0, 0.7, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0, 0.7, curve: Curves.easeOutCubic),
    ));
    _timer = Timer(Duration(milliseconds: stagger), _ctrl.forward);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
