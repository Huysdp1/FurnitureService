
import 'package:flutter/cupertino.dart';


import '../Views/intro/intro_screen.dart';
import '../Views/login/login_screen.dart';
import '../Views/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
     Routes.homeRoute: (context) => const SplashScreen(),
     Routes.introRoute: (context) => const IntroScreen(),
     Routes.loginRoute: (context) => const LoginScreen(),
    // Routes.forgotRoute: (context) => const ForgotPassword(),
    // Routes.resetRoute: (context) => const ResetPassword(),
    // Routes.signupRoute: (context) => const SignUpScreen(),
    // Routes.selectCountryRoute: (context) => const SelectCountry(),
    // Routes.verifyRoute: (context) => const VerifyScreen(),
    // Routes.homeScreenRoute: (context) => const HomeScreen(0),
    // Routes.categoryRoute: (context) => const CategoryScreen(),
    // Routes.detailRoute: (context) => const DetailScreen(),
    // Routes.cartRoute: (context) => const CartScreen(),
    // Routes.addressRoute: (context) => const AddressScreen(),
    // Routes.dateTimeRoute: (context) => const DateTimeScreen(),
    // Routes.paymentRoute: (context) => const PaymentScreen(),
    // Routes.orderDetailRoute: (context) => const OrderDetail(),
    // Routes.profileRoute: (context) => const ProfileScreen(),
    // Routes.editProfileRoute: (context) => const EditProfileScreen(),
    // Routes.myAddressRoute: (context) => const MyAddressScreen(),
    // Routes.editAddressRoute: (context) => const EditAddressScreen(),
    // Routes.cardRoute: (context) => const CardScreen(),
    // Routes.settingRoute: (context) => const SettingScreen(),
    // Routes.notificationRoutes: (context) => const NotificationScreen(),
    // Routes.searchRoute: (context) => const SearchScreen(),
    // Routes.bookingRoute: (context) => const BookingDetail(),
    // Routes.helpRoute: (context) => const HelpScreen(),
    // Routes.privacyRoute: (context) => const PrivacyScreen(),
    // Routes.securityRoute: (context) => const SecurityScreen(),
    // Routes.termOfServiceRoute: (context) => const TermOfServiceScreen()
  };
}
