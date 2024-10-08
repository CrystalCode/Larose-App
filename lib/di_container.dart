import 'package:dio/dio.dart';
import 'package:crystal_code/common/reposotories/language_repo.dart';
import 'package:crystal_code/features/address/domain/reposotories/location_repo.dart';
import 'package:crystal_code/features/address/providers/location_provider.dart';
import 'package:crystal_code/features/auth/domain/reposotories/auth_repo.dart';
import 'package:crystal_code/features/auth/providers/registration_provider.dart';
import 'package:crystal_code/features/auth/providers/verification_provider.dart';
import 'package:crystal_code/features/checkout/providers/checkout_provider.dart';
import 'package:crystal_code/features/home/domain/reposotories/banner_repo.dart';
import 'package:crystal_code/features/cart/domain/reposotories/cart_repo.dart';
import 'package:crystal_code/features/category/domain/reposotories/category_repo.dart';
import 'package:crystal_code/features/chat/domain/reposotories/chat_repo.dart';
import 'package:crystal_code/features/coupon/domain/reposotories/coupon_repo.dart';
import 'package:crystal_code/common/reposotories/news_letter_repo.dart';
import 'package:crystal_code/features/notification/domain/reposotories/notification_repo.dart';
import 'package:crystal_code/features/order/domain/reposotories/order_repo.dart';
import 'package:crystal_code/common/reposotories/product_repo.dart';
import 'package:crystal_code/features/onboarding/domain/reposotories/onboarding_repo.dart';
import 'package:crystal_code/features/rate_review/providers/rate_review_provider.dart';
import 'package:crystal_code/features/search/domain/reposotories/search_repo.dart';
import 'package:crystal_code/features/profile/domain/reposotories/profile_repo.dart';
import 'package:crystal_code/features/sell/providers/sell_provider.dart';
import 'package:crystal_code/features/splash/domain/reposotories/splash_repo.dart';
import 'package:crystal_code/features/track/providers/order_map_provider.dart';
import 'package:crystal_code/features/wishlist/domain/reposotories/wishlist_repo.dart';
import 'package:crystal_code/features/auth/providers/auth_provider.dart';
import 'package:crystal_code/features/home/providers/banner_provider.dart';
import 'package:crystal_code/features/cart/providers/cart_provider.dart';
import 'package:crystal_code/features/category/providers/category_provider.dart';
import 'package:crystal_code/features/chat/providers/chat_provider.dart';
import 'package:crystal_code/features/coupon/providers/coupon_provider.dart';
import 'package:crystal_code/features/flash_sale/providers/flash_sale_provider.dart';
import 'package:crystal_code/provider/localization_provider.dart';
import 'package:crystal_code/provider/news_provider.dart';
import 'package:crystal_code/features/notification/providers/notification_provider.dart';
import 'package:crystal_code/features/order/providers/order_provider.dart';
import 'package:crystal_code/features/address/providers/address_provider.dart';
import 'package:crystal_code/features/product/providers/product_provider.dart';
import 'package:crystal_code/provider/language_provider.dart';
import 'package:crystal_code/features/onboarding/providers/onboarding_provider.dart';
import 'package:crystal_code/features/search/providers/search_provider.dart';
import 'package:crystal_code/features/profile/providers/profile_provider.dart';
import 'package:crystal_code/features/splash/providers/splash_provider.dart';
import 'package:crystal_code/provider/theme_provider.dart';
import 'package:crystal_code/features/wishlist/providers/wishlist_provider.dart';
import 'package:crystal_code/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'features/sell/domain/repositories/sell_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
      () => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BannerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => LanguageRepo());
  sl.registerLazySingleton(() => OnBoardingRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => OrderRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => ChatRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => LocationRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CouponRepo(dioClient: sl()));
  sl.registerLazySingleton(() => WishListRepo(dioClient: sl()));
  sl.registerLazySingleton(() => NewsLetterRepo(dioClient: sl()));
  sl.registerLazySingleton(() => SellRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(
      () => SplashProvider(splashRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => LocalizationProvider(sharedPreferences: sl(), dioClient: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(
      () => OnBoardingProvider(onboardingRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl()));
  sl.registerFactory(() => OrderMapProvider());
  sl.registerFactory(() => CheckoutProvider(orderRepo: sl()));
  sl.registerFactory(
      () => ChatProvider(chatRepo: sl(), notificationRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => RegistrationProvider(authRepo: sl()));
  sl.registerFactory(() => VerificationProvider(authRepo: sl()));
  sl.registerFactory(
      () => AddressProvider(sharedPreferences: sl(), locationRepo: sl()));
  sl.registerFactory(
      () => LocationProvider(sharedPreferences: sl(), locationRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => WishListProvider(wishListRepo: sl()));
  sl.registerFactory(() => CouponProvider(couponRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => NewsLetterProvider(newsLetterRepo: sl()));
  sl.registerFactory(() => FlashSaleProvider(productRepo: sl()));
  sl.registerFactory(() => RateReviewProvider(productRepo: sl()));
  sl.registerFactory(() => SellProvider(sellRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
