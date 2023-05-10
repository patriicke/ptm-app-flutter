import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/home/screen/home_screen.dart';
import 'package:meetings/comms/screen/comms_tab.dart';
import 'package:meetings/landing/bloc/app_tab_bloc.dart';
import 'package:meetings/landing/screen/bottom_navigator.dart';
import 'package:meetings/profile/screen/user_profile_screen.dart';
import 'package:meetings/reports/screen/report_list_screen.dart';
import 'package:meetings/notifications/screen/notifications_screen.dart';

// class LandingScreen extends StatefulWidget {
//   static Route route() {
//     return MaterialPageRoute<void>(builder: (_) => LandingScreen());
//   }

//   @override
//   _LandingScreenState createState() => _LandingScreenState();
// }

// class _LandingScreenState extends State<LandingScreen>
//     with SingleTickerProviderStateMixin {
//   final List<Tab> tabs = <Tab>[
//     Tab(icon: Icon(Icons.home_outlined)),
//     Tab(icon: Icon(Icons.message_outlined)),
//     Tab(icon: Icon(Icons.notifications_none_outlined)),
//     Tab(icon: Icon(Icons.source_outlined)),
//     Tab(icon: Icon(Icons.person_outline)),
//   ];

//   TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = new TabController(length: tabs.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(),
//         bottomNavigationBar: Material(
//           color: AccentLightColor,
//           child: TabBar(
//             tabs: tabs,
//             controller: _tabController,
//           ),
//         ),
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             HomeScreen(),
//             CommsTab(),
//             NotificationsScreen(),
//             ReportListScreen(),
//             UserProfileScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LandingScreenNew extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LandingScreenNew());
  }

  Widget _tempMapBody(AppTab tab) {
    switch (tab) {
      case AppTab.meeetings:
        return HomeScreen();
      case AppTab.comms:
        return CommsTab();
      case AppTab.notifications:
        return NotificationsScreen();
      case AppTab.reports:
        return ReportListScreen();
      case AppTab.profile:
        return UserProfileScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppTabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
          ),
          body: _tempMapBody(activeTab),
          bottomNavigationBar: BottomNavigator(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<AppTabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
