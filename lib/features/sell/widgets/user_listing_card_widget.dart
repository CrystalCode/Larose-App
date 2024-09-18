import 'package:crystal_code/features/sell/domain/models/paginated_user_listing_model.dart';
import 'package:crystal_code/features/sell/providers/sell_provider.dart';
import 'package:crystal_code/features/sell/screens/listing_details_screen.dart';
import 'package:crystal_code/localization/language_constrants.dart';
import 'package:crystal_code/features/splash/providers/splash_provider.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:crystal_code/utill/images.dart';
import 'package:crystal_code/utill/styles.dart';
import 'package:crystal_code/common/widgets/custom_image_widget.dart';
import 'package:crystal_code/common/widgets/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListingCard extends StatelessWidget {
  final Data userListingModel;
  const UserListingCard({Key? key, required this.userListingModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SellProvider>(builder: (context, sellProvider, _) {
      return OnHover(
          isItem: true,
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    ListingDetailsScreen(userListingModel: userListingModel))),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeDefault),
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                      width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.05),
                      blurRadius: 30,
                      offset: const Offset(2, 10),
                    )
                  ]),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                  flex: 3,
                  child: ProductImageView(
                    image: userListingModel.images != null &&
                            userListingModel.images!.isNotEmpty
                        ? userListingModel.images!.first.image
                        : null,
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Expanded(
                    flex: 4,
                    child: _ProductDescriptionView(
                        id: userListingModel.id,
                        user:
                            '${userListingModel.customer?.fName} ${userListingModel.customer?.lName}',
                        karat: userListingModel.karat,
                        weight: userListingModel.weight)),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall),
                        margin: const EdgeInsets.only(right: 2),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeDefault),
                            border: Border.all(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.05),
                                width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.05),
                                blurRadius: 30,
                                offset: const Offset(2, 10),
                              )
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                    getTranslated(
                                        '${userListingModel.status}', context),
                                    overflow: TextOverflow.ellipsis,
                                    style: rubikRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall))),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                    color: userListingModel.status == 'canceled'
                                        ? Colors.red
                                        : userListingModel.status == 'pending'
                                            ? Colors.yellow
                                            : Colors.green,
                                    shape: BoxShape.circle,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ));
    });
  }
}

class _ProductDescriptionView extends StatelessWidget {
  const _ProductDescriptionView({
    Key? key,
    this.karat,
    this.weight,
    this.user,
    this.id,
  }) : super(key: key);

  final int? id;
  final String? user;
  final double? karat;
  final double? weight;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${getTranslated('listing_id', context)} #${id.toString()}',
            overflow: TextOverflow.ellipsis,
            style: rubikBold.copyWith(fontSize: Dimensions.fontSizeSmall),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            user ?? '',
            overflow: TextOverflow.ellipsis,
            style: rubikBold.copyWith(fontSize: Dimensions.fontSizeSmall),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Row(children: [
            Icon(
              Icons.diamond_outlined,
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text(
              karat.toString(),
              overflow: TextOverflow.ellipsis,
              style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text(
              'karat',
              overflow: TextOverflow.ellipsis,
              style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
            ),
          ]),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              Text(
                weight.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              Text(
                'g',
                overflow: TextOverflow.ellipsis,
                style:
                    rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
            ],
          )
        ]);
  }
}

class ProductImageView extends StatelessWidget {
  const ProductImageView({Key? key, required this.image}) : super(key: key);
  final String? image;

  @override
  Widget build(BuildContext context) {
    final SplashProvider splashProvider =
        Provider.of<SplashProvider>(context, listen: false);

    return Container(
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.05), width: 1),
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  BorderRadius.circular(Dimensions.paddingSizeDefault),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.05),
                  blurRadius: 30,
                  offset: const Offset(15, 15),
                )
              ]),
          child: Stack(children: [
            CustomImageWidget(
              image:
                  '${splashProvider.baseUrls!.getUserListingImageUrl}/$image',
              height: 160,
              width: 160,
              fit: BoxFit.fill,
              placeholder: Images.placeholderLight,
            ),
          ]),
        ),
      ),
    );
  }
}
