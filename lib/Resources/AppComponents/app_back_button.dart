import 'package:edgewaterhealth/Resources/AppColor/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const CustomBackButton({
    Key? key,
    this.onTap,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => Get.back(),
      icon: CircleAvatar(
        radius: 20,
        backgroundColor: backgroundColor ?? AppColor.boxColor,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: AppColor.textColor,
          size: 15,
        ),
      ),
    );
  }
}
