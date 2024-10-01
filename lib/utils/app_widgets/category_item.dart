
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_apps/utils/extensions/app_extension.dart';

import '../colors/app_colors.dart';



class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.onItemTap,
      required this.categoryName,
      required this.categoryImage,
      this.width,
      this.height,
      this.fontSize,
      });

  final VoidCallback onItemTap;
  final String categoryName;
  final String categoryImage;
  final double? width;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onItemTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: width ?? 100,
                height: height ?? 100,
                decoration: BoxDecoration(
                    color: green.withOpacity(0.07),
                    borderRadius: 15.borderRadius),
                child: categoryImage.isEmpty
                    ? Icon(CupertinoIcons.gift)
                    : Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ClipRRect(
                          borderRadius: 10.borderRadius,
                          child: CachedNetworkImage(
                            imageUrl: categoryImage,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
              ),
            ),
            Container(width:width ?? 100,child: Text(categoryName,style: TextStyle(fontSize: fontSize ?? 14,overflow: TextOverflow.ellipsis),))
          ],
        ),
      ),
    );
  }
}
