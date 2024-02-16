import 'package:flutter/material.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ServicesScreen/services_screen.dart';
import 'package:rhinoapp/Utils/routes/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => ServicesScreen(),
        );

      // case RoutesName.home:
      //   return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      // case RoutesName.login:
      //   return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      // case RoutesName.signUp:
      //   return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
        );
    }
  }
}
