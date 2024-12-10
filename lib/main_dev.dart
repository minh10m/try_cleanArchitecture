import 'package:clean_architecture/AppConfig.dart';
import 'package:clean_architecture/data/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'di/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp();

  await NotificationService().initNotifications();

  // Đăng ký các dịch vụ với GetIt
  await configureDependencies();

  appInit(AppConfig(appTitle: 'flavor dev', buildFlavor: 'dev', child: Container()));
}

