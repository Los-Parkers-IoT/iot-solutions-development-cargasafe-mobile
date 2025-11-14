import 'package:flutter/material.dart';
import 'package:cargasafe/shared/app/app.dart';
import 'package:provider/provider.dart';
import 'package:cargasafe/shared/app/di/app_providers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const MyApp(),
    ),
  );
}
