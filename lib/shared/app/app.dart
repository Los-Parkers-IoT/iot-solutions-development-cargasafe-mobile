import 'package:flutter/material.dart';
import 'package:cargasafe/shared/app/router/app_router.dart';
import 'package:cargasafe/shared/presentation/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CargaSafe',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
