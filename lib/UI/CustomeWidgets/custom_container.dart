// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/helper_widgets.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double width;
  final Widget? widget;
  final Color color;
  bool choseshadow;
  final double boarderRadius;
  final double? borderwidth;
  final Color? borderColor;
  CustomContainer({
    this.width = 20.0,
    this.height = 20.0,
    this.boarderRadius = 0,
    this.choseshadow = false,
    this.color = secondaryColor,
    this.widget,
    this.borderwidth,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: choseshadow == true ? shadow : null,
        border: Border.all(
          width: borderwidth ?? 1,
          color: borderColor ?? whiteColor,
        ),
        color: color,
        borderRadius: BorderRadius.circular(boarderRadius),
      ),
      child: widget,
    );
  }
}
