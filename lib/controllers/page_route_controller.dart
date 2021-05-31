import 'package:clock_in_admin/screens/dashboard/dashboard_screen.dart';
import 'package:clock_in_admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class PageRouteController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Widget _route = DashboardScreen();
  Widget get route => _route;

  String _pageTitle = '';
  String get pageTitle => _pageTitle;

  void navigate(Widget page, {String title = ''}) {
    _route = page;
    _pageTitle = title;
    notifyListeners();
  }
}
