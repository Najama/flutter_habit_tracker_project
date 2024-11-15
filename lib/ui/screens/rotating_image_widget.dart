import 'package:flutter/material.dart';

class RotatingImageWidget extends StatefulWidget {
  const RotatingImageWidget({ super.key,this.imagepath ='images/pokeball.png' });
  final String imagepath;

  @override
 State <RotatingImageWidget> createState() => _RotatingImageWidgetState();
}

class _RotatingImageWidgetState extends State<RotatingImageWidget>  with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,
    duration: Duration(seconds: 2),
    ) 
  ..repeat();
  }

  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation:_animationController ,
    builder: (context,child){
      return Transform.rotate(angle: _animationController.value * 3 * 3.14,
      child: Image.asset('images/pokeball.png',width: 250,));
    },
      
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();

    super.dispose();
  }
}