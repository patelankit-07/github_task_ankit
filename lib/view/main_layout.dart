import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_apps/controller/provider/product_provider.dart';
import 'package:grocery_apps/utils/extensions/app_extension.dart';
import 'package:grocery_apps/view/Screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../utils/colors/app_colors.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key, required this.appBar, required this.body,
  });
  final AppBar appBar;
  final Widget body;
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  var iconList = [
    CupertinoIcons.square_grid_2x2,
    CupertinoIcons.archivebox,
    CupertinoIcons.gift,
    CupertinoIcons.slider_horizontal_3
  ];
  var labelList = ["Home", "Order", "Offer", "More"];
  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      appBar: widget.appBar,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: Badge(
            label: Consumer<ProductProvider>(
              builder: (context,provider,child) {
                return Text("${provider.cartItemsCount}");
              }
            ),
            backgroundColor: CupertinoColors.activeOrange,
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: 100.borderRadius,
                  side: const BorderSide(
                      color: CupertinoColors.activeGreen, width: 5)),
              backgroundColor: Colors.white,
              splashColor: Colors.green.withOpacity(0.5),
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.cart,
                color: CupertinoColors.activeGreen,
              ),
              //params
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        gapLocation: GapLocation.center,
        backgroundColor: CupertinoColors.activeGreen,
       elevation: 0,
        itemCount: 4,
        height: 60,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 25,
        rightCornerRadius: 25,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
              ),
              Text(
                labelList[index],
                style: TextStyle(
                    color: isActive
                        ? Colors.white
                        : Colors.white.withOpacity(0.5)),
              )
            ],
          );
        },
        activeIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
      body: widget.body,
    );
  }


}