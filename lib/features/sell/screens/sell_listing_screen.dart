import 'package:flutter/material.dart';
import 'package:crystal_code/common/widgets/custom_app_bar_widget.dart';
import 'package:crystal_code/common/widgets/no_data_screen.dart';
import 'package:crystal_code/common/widgets/paginated_list_view.dart';
import 'package:crystal_code/features/sell/providers/sell_provider.dart';
import 'package:crystal_code/features/sell/widgets/user_listing_card_widget.dart';
import 'package:crystal_code/features/sell/widgets/user_listing_shimmer.dart';
import 'package:crystal_code/helper/responsive_helper.dart';
import 'package:crystal_code/localization/language_constrants.dart';
import 'package:crystal_code/utill/dimensions.dart';
import 'package:crystal_code/utill/routes.dart';
import 'package:provider/provider.dart';

class SellListingScreen extends StatefulWidget {
  const SellListingScreen({Key? key}) : super(key: key);

  @override
  State<SellListingScreen> createState() => _SellListingScreenState();
}

class _SellListingScreenState extends State<SellListingScreen> {
  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  void _loadData(BuildContext context) async {
    await Provider.of<SellProvider>(context, listen: false)
        .getUserListing(1, isUpdate: false);
  }

  @override
  void initState() {
    super.initState();
    _loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: getTranslated('listing', context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(Routes.getAddListing()),
        child: Icon(
          Icons.add,
          color: Theme.of(context).cardColor,
        ),
      ),
      body: Consumer<SellProvider>(builder: (context, sellProvider, child) {
        return sellProvider.userListingModel != null
            ? sellProvider.userListingModel!.data!.isNotEmpty
                ? SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      width: Dimensions.webScreenWidth,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                ResponsiveHelper.isDesktop(context) ? 0 : 100),
                        child: PaginatedListView(
                            scrollController: _scrollController,
                            totalSize: sellProvider.userListingModel?.totalSize,
                            offset: int.tryParse(
                                sellProvider.userListingModel!.offset!),
                            onPaginate: (int? offset) async =>
                                await sellProvider.getUserListing(offset!,
                                    isUpdate: true),
                            itemView: ResponsiveHelper.isDesktop(context)
                                ? GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing:
                                          ResponsiveHelper.isDesktop(context)
                                              ? 13
                                              : 5,
                                      mainAxisSpacing:
                                          ResponsiveHelper.isDesktop(context)
                                              ? 13
                                              : 5,
                                      // childAspectRatio: ResponsiveHelper.isDesktop(context) ? (1/1.45) : 3,
                                      mainAxisExtent:
                                          ResponsiveHelper.isDesktop(context)
                                              ? 130
                                              : 120,
                                      crossAxisCount:
                                          ResponsiveHelper.isDesktop(context)
                                              ? 5
                                              : ResponsiveHelper.isTab(context)
                                                  ? 2
                                                  : 1,
                                    ),
                                    itemCount: sellProvider
                                        .userListingModel!.data?.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimensions.paddingSizeSmall),
                                    itemBuilder: (context, index) {
                                      return UserListingCard(
                                        userListingModel: sellProvider
                                            .userListingModel!.data![index],
                                      );
                                    },
                                  )
                                : GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing:
                                          ResponsiveHelper.isDesktop(context)
                                              ? 13
                                              : 5,
                                      mainAxisSpacing:
                                          ResponsiveHelper.isDesktop(context)
                                              ? 13
                                              : 5,
                                      // childAspectRatio: ResponsiveHelper.isDesktop(context) ? (1/1.45) : 3,
                                      mainAxisExtent:
                                          ResponsiveHelper.isDesktop(context)
                                              ? 130
                                              : 120,
                                      crossAxisCount:
                                          ResponsiveHelper.isDesktop(context)
                                              ? 5
                                              : ResponsiveHelper.isTab(context)
                                                  ? 2
                                                  : 1,
                                    ),
                                    itemCount: sellProvider
                                        .userListingModel!.data?.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeSmall),
                                    itemBuilder: (context, index) {
                                      return UserListingCard(
                                        userListingModel: sellProvider
                                            .userListingModel!.data![index],
                                      );
                                    },
                                  )),
                      ),
                    ),
                  )
                : const NoDataScreen()
            : GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing:
                      ResponsiveHelper.isDesktop(context) ? 13 : 5,
                  mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                  // childAspectRatio: ResponsiveHelper.isDesktop(context) ? (1/1.45) : 3,
                  mainAxisExtent:
                      ResponsiveHelper.isDesktop(context) ? 130 : 120,
                  crossAxisCount: ResponsiveHelper.isDesktop(context)
                      ? 6
                      : ResponsiveHelper.isTab(context)
                          ? 2
                          : 1,
                ),
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return UserListingShimmer(
                      isEnabled: sellProvider.userListingModel == null,
                      isWeb: ResponsiveHelper.isDesktop(context));
                },
              );
      }),
    );
  }
}
