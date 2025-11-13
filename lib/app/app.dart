import 'package:cargasafe/app/di/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:cargasafe/app/router/app_router.dart';
import 'package:provider/provider.dart';
import '../shared/presentation/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp.router(
        title: 'CargaSafe',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
