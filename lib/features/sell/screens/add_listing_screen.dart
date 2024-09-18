import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:crystal_code/common/models/config_model.dart';
import 'package:crystal_code/common/widgets/custom_app_bar_widget.dart';
import 'package:crystal_code/common/widgets/custom_button_widget.dart';
import 'package:crystal_code/features/address/providers/address_provider.dart';
import 'package:crystal_code/features/auth/providers/auth_provider.dart';
import 'package:crystal_code/features/checkout/providers/checkout_provider.dart';
import 'package:crystal_code/features/checkout/widgets/delivery_address_widget.dart';
import 'package:crystal_code/features/sell/domain/models/store_data_model.dart';
import 'package:crystal_code/features/sell/providers/sell_provider.dart';
import 'package:crystal_code/features/sell/widgets/text_field_widget.dart';
import 'package:crystal_code/features/splash/providers/splash_provider.dart';
import 'package:crystal_code/helper/checkout_helper.dart';
import 'package:crystal_code/helper/custom_snackbar_helper.dart';
import 'package:crystal_code/helper/responsive_helper.dart';
import 'package:crystal_code/localization/language_constrants.dart';
import 'package:crystal_code/main.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:crystal_code/utill/images.dart';
import 'package:crystal_code/utill/styles.dart';
import 'package:provider/provider.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({Key? key}) : super(key: key);

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final TextEditingController _karatController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _proposedController = TextEditingController();
  final FocusNode _karatNode = FocusNode();
  final FocusNode _weightNode = FocusNode();
  final FocusNode _proposedNode = FocusNode();
  late GoogleMapController _mapController;
  List<Branches>? _branches = [];
  late bool _isLoggedIn;
  bool _loading = true;
  Set<Marker> _markers = HashSet<Marker>();

  @override
  void initState() {
    super.initState();
    _branches = Provider.of<SplashProvider>(context, listen: false)
        .configModel!
        .branches;
    _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (_isLoggedIn) {
      Provider.of<AddressProvider>(context, listen: false)
          .initAddressList()
          .then((value) {
        CheckOutHelper.selectDeliveryAddressAuto(
            orderType: 'delivery', isLoggedIn: _isLoggedIn, lastAddress: null);
      });
      Provider.of<SellProvider>(context, listen: false).clearPrevData();
    }
  }

  @override
  void dispose() {
    _karatController.dispose();
    _weightController.dispose();
    _proposedController.dispose();
    _karatNode.dispose();
    _weightNode.dispose();
    _proposedNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            CustomAppBarWidget(title: getTranslated('add_listing', context)),
        body: SafeArea(
          child: Consumer<SellProvider>(
            builder: (context, sellProvider, child) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFieldWidget(
                                  hintText: 'Karat',
                                  controller: _karatController,
                                  focusNode: _karatNode,
                                  nextFocus: _weightNode,
                                  isNumber: true,
                                  title: false,
                                ),
                              ),
                              const SizedBox(
                                  width: Dimensions.paddingSizeSmall),
                              Expanded(
                                child: TextFieldWidget(
                                  hintText: 'weight (kg)',
                                  controller: _weightController,
                                  focusNode: _weightNode,
                                  nextFocus: _proposedNode,
                                  isAmount: true,
                                  title: false,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeLarge),

                          TextFieldWidget(
                            hintText: getTranslated('proposed_price', context),
                            controller: _proposedController,
                            focusNode: _proposedNode,
                            isNumber: true,
                            title: false,
                          ),
                          const SizedBox(height: Dimensions.paddingSizeLarge),

                          ///Branch Select
                          Column(
                            children: [
                              _branches!.length > 1
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            child: Text(
                                                getTranslated(
                                                    'select_branch', context),
                                                style: rubikMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeLarge)),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              padding: const EdgeInsets.all(
                                                  Dimensions.paddingSizeSmall),
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: _branches!.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      right: Dimensions
                                                          .paddingSizeSmall),
                                                  child: InkWell(
                                                    onTap: () {
                                                      sellProvider
                                                          .setBranchIndex(
                                                              index);
                                                      _setMarkers(index);
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: Dimensions
                                                            .paddingSizeExtraSmall,
                                                        horizontal: Dimensions
                                                            .paddingSizeDefault,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: index ==
                                                                sellProvider
                                                                    .branchIndex
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Theme.of(context)
                                                                .dividerColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32),
                                                      ),
                                                      child: Text(
                                                          _branches![index]
                                                              .name!,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: rubikMedium
                                                              .copyWith(
                                                            color: index ==
                                                                    sellProvider
                                                                        .branchIndex
                                                                ? Colors.white
                                                                : Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .color,
                                                          )),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: 200,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeSmall),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusSizeDefault),
                                                color:
                                                    Theme.of(context).cardColor,
                                                border: Border.all(
                                                    width: 1,
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.5))),
                                            child: Stack(children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusSizeDefault),
                                                child: GoogleMap(
                                                  minMaxZoomPreference:
                                                      const MinMaxZoomPreference(
                                                          0, 16),
                                                  mapType: MapType.normal,
                                                  initialCameraPosition:
                                                      CameraPosition(
                                                          target: LatLng(
                                                            double.parse(
                                                                _branches![0]
                                                                    .latitude!),
                                                            double.parse(
                                                                _branches![0]
                                                                    .longitude!),
                                                          ),
                                                          zoom: 16),
                                                  zoomControlsEnabled: true,
                                                  markers: _markers,
                                                  onMapCreated:
                                                      (GoogleMapController
                                                          controller) async {
                                                    await Geolocator
                                                        .requestPermission();
                                                    _mapController = controller;
                                                    _loading = false;
                                                    _setMarkers(0);
                                                  },
                                                ),
                                              ),
                                              _loading
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ))
                                                  : const SizedBox(),
                                            ]),
                                          ),
                                        ])
                                  : const SizedBox(),
                              const DeliveryAddressWidget(
                                selfPickup: false,
                                listing: true,
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  getTranslated('item_images', context),
                                  style: rubikBold.copyWith(
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeDefault),
                                GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: (1 / 1),
                                      mainAxisSpacing:
                                          Dimensions.paddingSizeSmall,
                                      crossAxisSpacing:
                                          Dimensions.paddingSizeSmall,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        sellProvider.rawImages!.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          (sellProvider.rawImages?.length)) {
                                        return InkWell(
                                          onTap: () {
                                            sellProvider.pickImages();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .radiusSizeSmall),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.all(
                                                  Dimensions
                                                      .paddingSizeDefault),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.camera_alt,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 2),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radiusSizeSmall),
                                          ),
                                          child: Stack(children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusSizeSmall),
                                                child: Image.file(
                                                  File(sellProvider
                                                      .rawImages![index].path),
                                                  width: 150,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                )),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  sellProvider
                                                      .removeImage(index);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.all(
                                                      Dimensions
                                                          .paddingSizeSmall),
                                                  child: Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  !sellProvider.isLoading
                      ? CustomButtonWidget(
                          btnTxt: getTranslated('submit', context),
                          height: 50,
                          margin:
                              const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          onTap: () {
                            String karat = _karatController.text.trim();
                            String weight = _weightController.text.trim();
                            String proposedPrice =
                                _proposedController.text.trim();

                            if (karat.isEmpty) {
                              showCustomSnackBar(
                                  getTranslated('enter_karat', context),
                                  context);
                            } else if (weight.isEmpty) {
                              showCustomSnackBar(
                                  getTranslated(
                                      'enter_product_weight', context),
                                  context);
                            } else if (proposedPrice.isEmpty) {
                              showCustomSnackBar(
                                  getTranslated(
                                      'enter_proposed_price', context),
                                  context);
                            } else if (sellProvider.rawImages == null ||
                                sellProvider.rawImages!.isEmpty) {
                              showCustomSnackBar(
                                  getTranslated(
                                      'add_at_least_one_image_of_your_product',
                                      context),
                                  context);
                            } else if ((Provider.of<AddressProvider>(context,
                                            listen: false)
                                        .addressList ==
                                    null ||
                                Provider.of<AddressProvider>(context,
                                        listen: false)
                                    .addressList!
                                    .isEmpty ||
                                Provider.of<CheckoutProvider>(context,
                                            listen: false)
                                        .orderAddressIndex <
                                    0)) {
                              showCustomSnackBar(
                                  getTranslated('select_an_address', context),
                                  context);
                            } else {
                              StoreDataModel storeDataModel = StoreDataModel(
                                  karat,
                                  weight,
                                  proposedPrice,
                                  _branches?[sellProvider.branchIndex]
                                      .id
                                      .toString(),
                                  Provider.of<AddressProvider>(context,
                                          listen: false)
                                      .addressList![
                                          Provider.of<CheckoutProvider>(context,
                                                  listen: false)
                                              .orderAddressIndex]
                                      .id
                                      .toString());
                              sellProvider
                                  .storeUserListing(
                                      storeDataModel,
                                      sellProvider.rawImages,
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .getUserToken())
                                  .then((value) {
                                if (value.isSuccess) {
                                  Provider.of<SellProvider>(context,
                                          listen: false)
                                      .getUserListing(
                                    1,
                                  );
                                  Navigator.pop(context);
                                  showCustomSnackBar(value.message, context,
                                      isError: false);
                                } else {
                                  showCustomSnackBar(value.message, context);
                                }
                              });
                            }
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ));
  }

  void _setMarkers(int selectedIndex) async {
    late BitmapDescriptor bitmapDescriptor;
    late BitmapDescriptor bitmapDescriptorUnSelect;
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(30, 50)),
            Images.restaurantMarker)
        .then((marker) {
      bitmapDescriptor = marker;
    });
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(20, 20)),
            Images.unselectedRestaurantMarker)
        .then((marker) {
      bitmapDescriptorUnSelect = marker;
    });

    // Marker
    _markers = HashSet<Marker>();
    for (int index = 0; index < _branches!.length; index++) {
      _markers.add(Marker(
        markerId: MarkerId('branch_$index'),
        position: LatLng(double.parse(_branches![index].latitude!),
            double.parse(_branches![index].longitude!)),
        infoWindow: InfoWindow(
            title: _branches![index].name, snippet: _branches![index].address),
        icon: selectedIndex == index
            ? bitmapDescriptor
            : bitmapDescriptorUnSelect,
      ));
    }

    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          double.parse(_branches![selectedIndex].latitude!),
          double.parse(_branches![selectedIndex].longitude!),
        ),
        zoom: ResponsiveHelper.isMobile(Get.context!) ? 12 : 16)));

    setState(() {});
  }
}
