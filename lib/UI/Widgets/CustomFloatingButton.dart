import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Utils/Colors.dart';

class CustomFloatingButton extends StatefulWidget{
  final VoidCallback addClickHandler;
  final VoidCallback searchClickHandler;

  const CustomFloatingButton({
    Key? key,
    required this.addClickHandler,
    required this.searchClickHandler,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomFloatingButtonState();

}

class _CustomFloatingButtonState extends State<CustomFloatingButton> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: LuckyColors.splashScreenColors,
      end: Colors.redAccent,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -8.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }
  Widget add() {
    return new Container(
      child: FloatingActionButton(
        onPressed: this.widget.addClickHandler,
        child: Icon(Icons.add_outlined,size: 24,),
      ),
    );
  }
  Widget search() {
    return new Container(
      child: FloatingActionButton(
        onPressed: this.widget.searchClickHandler,
        child: Icon(Icons.search,size: 24,),
      ),
    );
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
        size: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: search(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: add(),
        ),
        toggle(),
      ],
    );
  }
}