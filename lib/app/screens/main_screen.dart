// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: Avoid using 'late' keyword.

import 'dart:math';

import 'package:best_app_ever/app/blocs/bloc/main_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main screen
class MainScreen extends StatefulWidget {
  /// Initializes [key] for subclasses.
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;

  late Animation<Color?> _animationBackgroundColor;
  late TweenSequence<Color?> _tweenSequence;

  final MainScreenBloc _bloc = MainScreenBloc();

  final int colorAmount = 3;
  final double percentageDuration = 40.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOutQuad);

    _tweenSequence = TweenSequence<Color?>(
      List<TweenSequenceItem<Color?>>.generate(
        colorAmount,
        (index) => TweenSequenceItem(
          tween: ColorTween(begin: _getColor(), end: _getColor()),
          weight: percentageDuration,
        ),
      ),
    );

    _animationBackgroundColor = _tweenSequence.animate(_curvedAnimation);

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _bloc.add(MainScreenEnd());
      }
    });
  }

  Color _getColor() {
    final Random random = Random();
    const int max = 256;

    return Color.fromARGB(
      random.nextInt(max),
      random.nextInt(max),
      random.nextInt(max),
      random.nextInt(max),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_bloc.state is MainScreenEndState || _bloc.state is MainScreenInitialState) {
            _bloc.add(MainScreenTap());
          }
        },
        child: BlocConsumer<MainScreenBloc, MainScreenState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is MainScreenEndState) {
              _animationController.reset();
              _tweenSequence = TweenSequence<Color?>(
                List<TweenSequenceItem<Color?>>.generate(
                  colorAmount,
                  (index) => TweenSequenceItem(
                    tween: ColorTween(begin: _getColor(), end: _getColor()),
                    weight: percentageDuration,
                  ),
                ),
              );

              _animationBackgroundColor = _tweenSequence.animate(_curvedAnimation);
            }
            if (state is MainScreenStartState) {
              _animationController.forward();
            }
          },
          builder: (context, state) {
            return AnimatedBuilder(
              animation: _animationBackgroundColor,
              builder: (BuildContext context, Widget? child) {
                return Container(
                  color: _animationBackgroundColor.value,
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: const [Colors.black, Colors.white],
                          stops: [
                            if (_animationController.isAnimating) _animationController.value else _animationController.upperBound,
                            _animationController.upperBound,
                          ],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: Text(
                        'Hello there',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _curvedAnimation.dispose();
    _bloc.close();

    super.dispose();
  }
}
