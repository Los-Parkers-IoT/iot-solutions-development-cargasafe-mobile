import 'package:flutter/material.dart';
import 'package:cargasafe/app/app.dart';
import 'package:provider/provider.dart';
import 'package:cargasafe/app/di/app_providers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const MyApp(),
    ),
  );
}
