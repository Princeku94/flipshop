import 'package:flipshop/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../screens/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProductHomeScreen());
      case RoutesName.productDetailScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProductDetailsScreen());
      case RoutesName.musicScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AudioPlayerScreen());
      case RoutesName.profileScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileScreen());

      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(body: Center(child: Text('Not exit route')));
        });
    }
  }
}
