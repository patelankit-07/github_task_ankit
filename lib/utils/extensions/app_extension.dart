import 'package:flutter/material.dart';

extension Spaces on int {
  Radius get radius => Radius.circular(toDouble());

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(vertical: toDouble());

  BorderRadius get borderRadius => BorderRadius.circular(toDouble());


  RoundedRectangleBorder get shapeBorderRadius =>
      RoundedRectangleBorder(borderRadius: borderRadius);

  SizedBox get height => SizedBox(
    height: toDouble(),
  );
  SizedBox get square => SizedBox(
    height: toDouble(),
    width: toDouble(),
  );

  SizedBox get width => SizedBox(
    width: toDouble(),
  );
}


extension Responsive on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  Size get deviceSize => MediaQuery.of(this).size;

  Orientation get deviceOrientation => MediaQuery.of(this).orientation;

  void push(Widget screen){
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen,));
  }
  void pushReplace(Widget screen){
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => screen,));
  }
  void get pop {
    Navigator.pop(this);
  }
  showSnackBar(text){
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(text)));

  }
}