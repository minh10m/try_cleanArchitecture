import 'package:clean_architecture/app.dart';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final String appTitle;
  final String buildFlavor;

  @override
  final Widget child;

  AppConfig(
      {Key? key, required this.appTitle, required this.buildFlavor, required this.child})
      : super(key: key, child: child);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

void appInit(AppConfig config) {
  AppConfig appConfig = AppConfig(
      appTitle: config.appTitle,
      buildFlavor: config.buildFlavor,
      child: MyApp());
  runApp(appConfig);
}