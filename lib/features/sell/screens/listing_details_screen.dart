import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crystal_code/common/widgets/custom_app_bar_widget.dart';
import 'package:crystal_code/common/widgets/no_data_screen.dart';
import 'package:crystal_code/features/sell/domain/models/paginated_user_listing_model.dart';
import 'package:crystal_code/features/sell/widgets/image_view_widget.dart';
import 'package:crystal_code/helper/responsive_helper.dart';
import 'package:crystal_code/localization/language_constrants.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:crystal_code/utill/styles.dart';

class ListingDetailsScreen extends StatelessWidget {
  final Data? userListingModel;
  const ListingDetailsScreen({Key? key, required this.userListingModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String?>? imageUrls =
        userListingModel?.images?.map((image) => image.image).toList();

    debugPrint("===================>>>>${userListingModel?.buyingPrice}");

    return Scaffold(
        appBar: CustomAppBarWidget(
          title: getTranslated('listing_details', context),
        ),
        body: SafeArea(
          child: userListingModel != null
              ? Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  ResponsiveHelper.isDesktop(context)
                                      ? Dimensions.paddingSizeExtraLarge
                                      : Dimensions.paddingSizeSmall),
                              child: ItemImageViewWidget(imageList: imageUrls),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  ResponsiveHelper.isDesktop(context)
                                      ? Dimensions.paddingSizeExtraLarge
                                      : Dimensions.paddingSizeSmall),
                              child: Container(
                                  padding: EdgeInsets.all(
                                      ResponsiveHelper.isDesktop(context)
                                          ? 0
                                          : Dimensions.paddingSizeDefault),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.isDesktop(context)
                                            ? Dimensions.radiusSizeDefault
                                            : 0),
                                    boxShadow:
                                        ResponsiveHelper.isDesktop(context)
                                            ? const [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 5,
                                                    spreadRadius: 1)
                                              ]
                                            : [],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                getTranslated(
                                                    'listing_id', context),
                                                style: rubikBold.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeDefault)),
                                            const SizedBox(
                                                width: Dimensions
                                                    .paddingSizeSmall),
                                            Text(
                                              '#${userListingModel?.id}',
                                              style: rubikBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ]),
                                      const SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${getTranslated('customer', context)} :',
                                                style: rubikRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeSmall)),
                                            Text(
                                              '${userListingModel?.customer?.fName} ${userListingModel?.customer?.lName}',
                                              style: rubikRegular.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ]),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(getTranslated('status', context),
                                              style: rubikRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeSmall)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                getTranslated(
                                                    '${userListingModel?.status}',
                                                    context),
                                                overflow: TextOverflow.ellipsis,
                                                style: rubikRegular.copyWith(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              const SizedBox(
                                                  width: Dimensions
                                                      .paddingSizeExtraSmall),
                                              Container(
                                                  height: 7,
                                                  width: 7,
                                                  decoration: BoxDecoration(
                                                    color: userListingModel
                                                                ?.status ==
                                                            'canceled'
                                                        ? Colors.red
                                                        : userListingModel
                                                                    ?.status ==
                                                                'pending'
                                                            ? Colors.yellow
                                                            : Colors.green,
                                                    shape: BoxShape.circle,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  ResponsiveHelper.isDesktop(context)
                                      ? Dimensions.paddingSizeExtraLarge
                                      : Dimensions.paddingSizeSmall),
                              child: Container(
                                  padding: EdgeInsets.all(
                                      ResponsiveHelper.isDesktop(context)
                                          ? 0
                                          : Dimensions.paddingSizeDefault),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.isDesktop(context)
                                            ? Dimensions.radiusSizeDefault
                                            : 0),
                                    boxShadow:
                                        ResponsiveHelper.isDesktop(context)
                                            ? const [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 5,
                                                    spreadRadius: 1)
                                              ]
                                            : [],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                getTranslated(
                                                    'product_details', context),
                                                style: rubikBold.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeDefault)),
                                          ]),
                                      const SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.diamond_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.3),
                                                ),
                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeExtraSmall),
                                                Text(
                                                    getTranslated(
                                                        'Karat', context),
                                                    style: rubikRegular.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeDefault)),
                                              ],
                                            ),
                                            const SizedBox(
                                                width: Dimensions
                                                    .paddingSizeSmall),
                                            Text(
                                              '${userListingModel?.karat}',
                                              style: rubikRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ]),
                                      const SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.shopping_cart,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.3),
                                                ),
                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeExtraSmall),
                                                Text(
                                                    '${getTranslated('weight', context)} :',
                                                    style: rubikRegular.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeSmall)),
                                              ],
                                            ),
                                            Text(
                                              '${userListingModel?.weight}',
                                              style: rubikRegular.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ]),
                                      const SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.currency_exchange,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.3),
                                                ),
                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeExtraSmall),
                                                Text(
                                                    '${getTranslated('proposed_price', context)} :',
                                                    style: rubikRegular.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeSmall)),
                                              ],
                                            ),
                                            Text(
                                              '${userListingModel?.proposedPrice}',
                                              style: rubikRegular.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ]),
                                      userListingModel?.buyingPrice != null &&
                                              (userListingModel!.buyingPrice! >
                                                  0)
                                          ? Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .monetization_on_outlined,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.3),
                                                          ),
                                                          const SizedBox(
                                                              width: Dimensions
                                                                  .paddingSizeExtraSmall),
                                                          Text(
                                                              getTranslated(
                                                                  'buying_price',
                                                                  context),
                                                              style: rubikRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault)),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          width: Dimensions
                                                              .paddingSizeSmall),
                                                      Text(
                                                        '${userListingModel?.buyingPrice}',
                                                        style: rubikRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeDefault),
                                                        textDirection:
                                                            TextDirection.ltr,
                                                      ),
                                                    ])
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const NoDataScreen(),
        ));
  }
}
