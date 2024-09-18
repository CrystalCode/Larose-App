import 'package:crystal_code/helper/responsive_helper.dart';
import 'package:crystal_code/localization/language_constrants.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:crystal_code/utill/images.dart';
import 'package:crystal_code/utill/styles.dart';
import 'package:flutter/material.dart';

class SignUpLogoWidget extends StatelessWidget {
  const SignUpLogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Image.asset(
          Images.logo,
          height: ResponsiveHelper.isDesktop(context) ? 100.0 : 80,
          fit: BoxFit.scaleDown,
          matchTextDirection: true,
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Text(getTranslated('signup', context),
            style: rubikMedium.copyWith(
              fontSize: Dimensions.fontSizeOverLarge,
            )),
        const SizedBox(height: Dimensions.paddingSizeLarge),
      ]),
    );
  }
}
