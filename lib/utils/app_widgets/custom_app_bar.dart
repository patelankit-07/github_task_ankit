import 'package:flutter/material.dart';
import 'package:grocery_apps/utils/extensions/app_extension.dart';


import '../colors/app_colors.dart';

AppBar customAppBar({
  required BuildContext context,
  required Widget title,
   double? height,
  bool? centerTitle,

}) {
  return AppBar(
    backgroundColor: green,
    toolbarHeight: height,
    titleSpacing: 5,
    title: title,
    centerTitle: centerTitle ?? false,
    leading: height == null ? Padding(
      padding: const EdgeInsets.only(left: 5),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ):null ,
    bottom: PreferredSize(

        preferredSize: Size(context.screenWidth, 30),
        child: Container(
          height: 20,
          decoration: BoxDecoration(
              color: appBg,
              borderRadius:
                  BorderRadius.only(topRight: 40.radius, topLeft: 40.radius)),
        )),
  );
}
