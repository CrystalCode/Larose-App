import 'package:crystal_code/helper/responsive_helper.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:crystal_code/utill/styles.dart';
import 'package:flutter/material.dart';

class CustomWebTitleWidget extends StatelessWidget {
  final String title;
  const CustomWebTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)
        ? Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault),
            child: Center(
                child: Text(title,
                    style: rubikBold.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge))),
          )
        : const SizedBox();
  }
}
