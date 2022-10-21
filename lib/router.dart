import 'package:flutter/material.dart';
import 'package:plantngo_frontend/screens/customer/voucherShop/voucher_checkout_screen.dart';
import 'package:plantngo_frontend/screens/login/signup_screen.dart';
import 'package:plantngo_frontend/screens/merchant/menu/category/add_category_screen.dart';
import 'package:plantngo_frontend/screens/merchant/menu/item/add_item_screen.dart';
import 'package:plantngo_frontend/screens/merchant/profile/promotion/create_promotion_screen.dart';
import 'package:plantngo_frontend/screens/merchant/profile/voucher/create_voucher_screen.dart';
import 'package:plantngo_frontend/screens/merchant/menu/merchant_menu_screen.dart';
import 'package:plantngo_frontend/screens/merchant/profile/promotion/merchant_promotion_screen.dart';
import 'package:plantngo_frontend/screens/merchant/menu/merchant_setup_menu_screen.dart';
import 'package:plantngo_frontend/screens/merchant/profile/voucher/merchant_voucher_screen.dart';
import 'screens/user_setting_screen.dart';
import 'utils/all.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginSignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginSignUpScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());

    case SignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignUpScreen());

    case ForgetPasswordScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ForgetPasswordScreen());
    case CustomerApp.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CustomerApp());
    case MerchantApp.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const MerchantApp());
    case MerchantSetupMenuScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const MerchantSetupMenuScreen());
    case MerchantMenuScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const MerchantMenuScreen());
    case AddCategoryScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddCategoryScreen());
    case AddItemScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddItemScreen());
    case MerchantVoucherScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const MerchantVoucherScreen());
    case MerchantPromotionScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const MerchantPromotionScreen());
    case CreateVoucherScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CreateVoucherScreen());
    case VoucherCheckout.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const VoucherCheckout());
    case UserSettingScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const UserSettingScreen());
    case CreatePromotionScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CreatePromotionScreen());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
