import 'package:crystal_code/common/widgets/custom_image_widget.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:crystal_code/features/splash/providers/splash_provider.dart';
import 'package:crystal_code/utill/images.dart';
import 'package:crystal_code/utill/routes.dart';
import 'package:crystal_code/common/widgets/menu_bar.dart';
import 'package:provider/provider.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Theme.of(context).cardColor,
          width: Dimensions.webScreenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.getMainRoute()),
                  child: Consumer<SplashProvider>(
                    builder: (context, splash, child) => splash
                                .configModel!.appLogo !=
                            null
                        ? CustomImageWidget(
                            placeholder: Images.placeholder(context),
                            image:
                                '${splash.baseUrls!.ecommerceImageUrl}/${splash.configModel!.appLogo}',
                            width: 70,
                            height: 50)
                        : const SizedBox(),
                  ),
                ),
              ),
              const MenuBarWidget(),
            ],
          )),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
