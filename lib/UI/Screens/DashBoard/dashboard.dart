import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Calender/calender.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ChatScreen/chat_screen.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ContactScreen/contact_screen.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Notifications/notifications.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ProductsScreen/product_screen.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/Profile/profile_screen.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/ServicesScreen/services_screen.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/SiteScreen/sites_screen.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/MainMenu/numbersScreen/numberScreen.dart';
import 'package:rhinoapp/UI/Screens/DashBoard/SideBarNavigator/side_bar_navigation.dart';
import 'package:rhinoapp/UI/Screens/Providers/side_bar_provider.dart';
import 'package:rhinoapp/Utils/helper_widgets.dart';

import 'MainMenu/BookService/book_service.dart';
import 'MainMenu/ReportFaults/report_fault_screen.dart';
import 'MainMenu/siteRequest/site_request_Screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  /////////// list of screens ///////////

  @override
  Widget build(BuildContext context) {
    final sidebarProvider = Provider.of<SideBarCount>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SideBar(),
            ),
            Expanded(
              flex: 9,
              child: sidebarProvider.index == 1
                  ? SitesScreen()
                  : sidebarProvider.index == 2
                      ? ContactScreen()
                      : sidebarProvider.index == 3
                          ? ServicesScreen()
                          : sidebarProvider.index == 4
                              ? ProductScreen()
                              : sidebarProvider.index == 5
                                  ? ChatScreen()
                                  : sidebarProvider.index == 6
                                      ? NotificationScreen()
                                      : sidebarProvider.index == 7
                                          ? CalenderScreen()
                                          : sidebarProvider.index == 8
                                              ? ProfileScreen()
                                              : sidebarProvider.index == 9
                                                  ? ReportFaultScreen()
                                                  : sidebarProvider.index == 10
                                                      ? SiteRequestScreen()
                                                      : sidebarProvider.index ==
                                                              11
                                                          ? BookServiceScreen() : sidebarProvider.index == 12
                                                          ?NumberScreen()
                                                          : ProfileScreen(),
            ),
            addHorizontalSpace(30)
          ],
        ),
      ),
    );
  }
}

//customRow



// rhenosite-admin-46c21