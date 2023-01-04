import 'package:customer_app/app/view/address/edit_address_screen.dart';
import 'package:customer_app/app/view/address/add_address_screen.dart';
import 'package:customer_app/app/view/bookings/edit_booking.dart';

import 'package:flutter/cupertino.dart';

import '../view/address/my_address_screen.dart';
import '../view/bookings/booking_detail.dart';
import '../view/card/card_screen.dart';
import '../view/home/address_screen.dart';
import '../view/home/cart_screen.dart';
import '../view/home/category_screen.dart';
import '../view/home/date_time_screen.dart';
import '../view/home/detail_screen.dart';
import '../view/home/home_screen.dart';
import '../view/home/order_detail.dart';
import '../view/home/payment_screen.dart';
import '../view/intro/intro_screen.dart';
import '../view/login/forgot_password.dart';
import '../view/login/login_screen.dart';
import '../view/login/reset_password.dart';
import '../view/notification_screen.dart';
import '../view/profile/edit_profile_screen.dart';
import '../view/profile/profile_screen.dart';
import '../view/search/search_screen.dart';
import '../view/setting/security_screen.dart';
import '../view/setting/setting_screen.dart';
import '../view/setting/term_of_service_screen.dart';
import '../view/signup/select_country.dart';
import '../view/signup/signup_screen.dart';
import '../view/signup/verify_screen.dart';
import '../view/splash_screen.dart';

import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.introRoute: (context) => const IntroScreen(),
    Routes.loginRoute: (context) => const LoginScreen(),
    Routes.forgotRoute: (context) => const ForgotPassword(),
    Routes.resetRoute: (context) => const ResetPassword(),
    Routes.signupRoute: (context) => const SignUpScreen(),
    Routes.selectCountryRoute: (context) => const SelectCountry(),
    Routes.verifyRoute: (context) => const VerifyScreen(),
    Routes.homeScreenRoute: (context) => const HomeScreen(0),
    Routes.categoryRoute: (context) => const CategoryScreen(),
    Routes.detailRoute: (context) => const DetailScreen(),
    Routes.cartRoute: (context) => const CartScreen(),
    Routes.addressRoute: (context) => const AddressScreen(),
    Routes.dateTimeRoute: (context) => const DateTimeScreen(),
    Routes.paymentRoute: (context) => const PaymentScreen(),
    Routes.orderDetailRoute: (context) => const OrderDetail(),
    Routes.profileRoute: (context) => const ProfileScreen(),
    Routes.editProfileRoute: (context) => const EditProfileScreen(),
    Routes.myAddressRoute: (context) => const MyAddressScreen(),
    Routes.editAddressRoute: (context) =>  const EditAddressScreen(),
    Routes.cardRoute: (context) => const CardScreen(),
    Routes.settingRoute: (context) => const SettingScreen(),
    Routes.notificationRoutes: (context) => const NotificationScreen(),
    Routes.searchRoute: (context) => const SearchScreen(),
    Routes.bookingRoute: (context) => const BookingDetail(),
    Routes.securityRoute: (context) => const SecurityScreen(),
    Routes.termOfServiceRoute: (context) => const TermOfServiceScreen(),
    Routes.addAddressScreenRoute: (context) => const AddAddressScreen(),
    Routes.editBookingScreen: (context) => const EditBookingScreen(),
  };
}
