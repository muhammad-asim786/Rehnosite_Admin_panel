import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/calendar_view_model.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ChatScreen/chat_viewmodel.dart';
import 'package:rhinoapp/UI/Screens/Providers/side_bar_provider.dart';

import 'UI/Screens/DashBoard/MainMenu/BookService/book_service_viewmodel.dart';
import 'UI/Screens/DashBoard/MainMenu/ContactScreen/contactScreen_viewmodel.dart';
import 'UI/Screens/DashBoard/MainMenu/Notifications/notification_viewmodel.dart';
import 'UI/Screens/DashBoard/MainMenu/ProductsScreen/product_viewmodel.dart';
import 'UI/Screens/DashBoard/MainMenu/ReportFaults/report_fault_viewmodel.dart';
import 'UI/Screens/DashBoard/MainMenu/ServicesScreen/service_viewmodel.dart';
import 'UI/Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';
import 'UI/Screens/DashBoard/MainMenu/siteRequest/site_request_viewmodel.dart';
import 'UI/Screens/DashBoard/dashboard.dart';
import 'UI/Screens/LoginScreen/login_viewmodel.dart';

ContactViewModel obj = ContactViewModel();
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "rhsite-web",
    options: FirebaseOptions(
      apiKey: "AIzaSyDzgyWH5tbxKOTpCeWDo4qh8UbLuD_H9mA",
      authDomain: "rhsite-web.firebaseapp.com",
      projectId: "rhsite-web",
      storageBucket: "rhsite-web.appspot.com",
      messagingSenderId: "86044674098",
      appId: "1:86044674098:web:39e9af8d0152b426d5542b",
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SideBarCount>(create: (_) => SideBarCount()),
        ChangeNotifierProvider<OrdersProvider>(create: (_) => OrdersProvider()),
        ChangeNotifierProvider<CalendarProvider>(
            create: (_) => CalendarProvider()),
        ChangeNotifierProvider(create: (_) => ContactViewModel()),
        ChangeNotifierProvider(create: (_) => ServiceViewModel()),
        ChangeNotifierProvider(create: (_) => SiteViewmodel()),
        ChangeNotifierProvider(create: (_) => LoginViewmodel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => ReportFaultViewModel()),
        ChangeNotifierProvider(create: (_) => SiteRequestViewModel()),
        ChangeNotifierProvider(create: (_) => CalendarViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => BookServiceViewModel()),
      ],
      child: MyApp(),
    ),
  );
  obj.getAllContacts();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1665, 1355),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //  home: CustomAlrtDialog(),
            // home: const CustomAlrtDialog(),
            //  home: LoginScreen(),
            home: DashBoardScreen()
            // initialRoute: RoutesName.login,
            // onGenerateRoute: Routes.generateRoute,
            );
      },
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, RoutesName.home);
//       },
//       child: Container(),
//     );
//   }
// }

