import 'package:crystal_code/features/cart/widgets/button_view_widget.dart';
import 'package:crystal_code/features/cart/widgets/cart_coupon_widget.dart';
import 'package:crystal_code/features/cart/widgets/select_delivery_type_widget.dart';
import 'package:crystal_code/features/coupon/providers/coupon_provider.dart';
import 'package:crystal_code/helper/price_converter_helper.dart';
import 'package:crystal_code/helper/responsive_helper.dart';
import 'package:crystal_code/localization/language_constrants.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:crystal_code/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item_widget.dart';

class CartDetailsWidget extends StatelessWidget {
  final bool isSelfPickupActive;
  final bool kmWiseCharge;
  final double itemPrice;
  final double tax;
  final double discount;
  final double deliveryCharge;
  final double total;
  final TextEditingController couponController;

  const CartDetailsWidget({
    Key? key,
    required this.isSelfPickupActive,
    required this.kmWiseCharge,
    required this.itemPrice,
    required this.tax,
    required this.discount,
    required this.deliveryCharge,
    required this.total,
    required this.couponController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isSelfPickupActive
            ? Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).shadowColor, blurRadius: 10)
                  ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTranslated('delivery_option', context),
                          style: rubikMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge)),
                      SelectDeliveryTypeWidget(
                          value: 'delivery',
                          title: getTranslated('delivery', context),
                          kmWiseFee: kmWiseCharge),
                      SelectDeliveryTypeWidget(
                          value: 'self_pickup',
                          title: getTranslated('self_pickup', context),
                          kmWiseFee: kmWiseCharge),
                    ]),
              )
            : const SizedBox(),
        SizedBox(
            height: isSelfPickupActive ? Dimensions.paddingSizeDefault : 0),
        Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 10)
            ],
          ),
          child: Column(
            children: [
              CartCouponWidget(
                  couponTextController: couponController, totalAmount: total),

              const SizedBox(height: Dimensions.paddingSizeDefault),

              // Total
              CartItemWidget(
                title: getTranslated('items_price', context),
                subTitle: PriceConverterHelper.convertPrice(itemPrice),
              ),
              const SizedBox(height: 10),

              CartItemWidget(
                title: getTranslated('tax', context),
                subTitle: PriceConverterHelper.convertPrice(tax),
              ),
              const SizedBox(height: 10),

              CartItemWidget(
                title: getTranslated('discount', context),
                subTitle: '- ${PriceConverterHelper.convertPrice(discount)}',
              ),
              const SizedBox(height: 10),

              CartItemWidget(
                title: getTranslated('coupon_discount', context),
                subTitle:
                    '- ${PriceConverterHelper.convertPrice(Provider.of<CouponProvider>(context).discount)}',
              ),
              const SizedBox(height: 10),

              kmWiseCharge
                  ? const SizedBox()
                  : CartItemWidget(
                      title: getTranslated('delivery_fee', context),
                      subTitle:
                          PriceConverterHelper.convertPrice(deliveryCharge),
                    ),

              const Divider(height: 20),

              CartItemWidget(
                title: getTranslated(
                    kmWiseCharge ? 'subtotal' : 'total_amount', context),
                subTitle: PriceConverterHelper.convertPrice(total),
                style: rubikMedium.copyWith(
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
              ),

              SizedBox(height: ResponsiveHelper.isDesktop(context) ? 10 : 0),
              if (ResponsiveHelper.isDesktop(context))
                ButtonViewWidget(
                  itemPrice: itemPrice,
                  total: total,
                  deliveryCharge: deliveryCharge,
                  discount: discount,
                ),
            ],
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
      ],
    );
  }
}
