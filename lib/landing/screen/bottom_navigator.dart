import 'package:flutter/material.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/landing/bloc/app_tab_bloc.dart';

class BottomNavigator extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  BottomNavigator({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  BottomNavigationBarItem _mapNavigationBarItem(AppTab tab) {
    switch (tab) {
      case AppTab.meeetings:
        return BottomNavigationBarItem(
          label: 'meetings',
          activeIcon: Icon(
            Icons.home,
            color: BottombarColorSelected,
          ),
          icon: Icon(
            Icons.home_outlined,
            color: BottombarColor,
          ),
        );
      case AppTab.comms:
        return BottomNavigationBarItem(
          label: 'comms',
          activeIcon: Icon(
            Icons.message,
            color: BottombarColorSelected,
          ),
          icon: Icon(
            Icons.message_outlined,
            color: BottombarColor,
          ),
        );
      case AppTab.notifications:
        return BottomNavigationBarItem(
          label: 'notifications',
          activeIcon: Icon(
            Icons.notifications,
            color: BottombarColorSelected,
          ),
          icon: Icon(
            Icons.notifications_none_outlined,
            color: BottombarColor,
          ),
        );
      case AppTab.reports:
        return BottomNavigationBarItem(
          label: 'reports',
          activeIcon: Icon(
            Icons.source,
            color: BottombarColorSelected,
          ),
          icon: Icon(
            Icons.source_outlined,
            color: BottombarColor,
          ),
        );
      case AppTab.profile:
        return BottomNavigationBarItem(
          label: 'profile',
          activeIcon: Icon(
            Icons.person,
            color: BottombarColorSelected,
          ),
          icon: Icon(
            Icons.person_outline,
            color: BottombarColor,
          ),
        );
      default:
        return BottomNavigationBarItem(
          label: 'meetings',
          activeIcon: Icon(
            Icons.home,
            color: BottombarColorSelected,
          ),
          icon: Icon(
            Icons.home_outlined,
            color: BottombarColor,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: BottombarColorSelected,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return _mapNavigationBarItem(tab);
      }).toList(),
    );
  }
}
