import 'package:flutter/material.dart';
import 'package:crystal_code/common/widgets/custom_image_widget.dart';
import 'package:crystal_code/features/sell/providers/sell_provider.dart';
import 'package:crystal_code/features/splash/providers/splash_provider.dart';
import 'package:crystal_code/helper/responsive_helper.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:crystal_code/utill/images.dart';
import 'package:provider/provider.dart';

class ItemImageViewWidget extends StatefulWidget {
  final List<String?>? imageList;
  final bool border;
  const ItemImageViewWidget(
      {Key? key, required this.imageList, this.border = true})
      : super(key: key);

  @override
  State<ItemImageViewWidget> createState() => _ItemImageViewWidgetState();
}

class _ItemImageViewWidgetState extends State<ItemImageViewWidget> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SellProvider>(builder: (context, sellprovider, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(children: [
            SizedBox(
              height: ResponsiveHelper.isDesktop(context)
                  ? 350
                  : MediaQuery.of(context).size.width * 0.5,
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.imageList?.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: widget.border
                        ? BorderRadius.circular(10)
                        : BorderRadius.circular(0),
                    child: CustomImageWidget(
                      image:
                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls?.getUserListingImageUrl}/${widget.imageList?[index]}',
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      placeholder: Images.placeholderLight,
                    ),
                  );
                },
                onPageChanged: (index) {
                  sellprovider.setImageSliderIndex(index);
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      _indicators(context, sellprovider, widget.imageList),
                ),
              ),
            ),
          ]),
        ],
      );
    });
  }

  List<Widget> _indicators(BuildContext context, SellProvider sellprovider,
      List<String?>? imageList) {
    List<Widget> indicators = [];
    if (imageList != null) {
      for (int index = 0; index < imageList.length; index++) {
        indicators.add(TabPageSelectorIndicator(
          backgroundColor: index == sellprovider.imageSliderIndex
              ? Theme.of(context).primaryColor
              : Colors.white,
          borderColor: Colors.white,
          size: 10,
        ));
      }
    }
    return indicators;
  }
}
