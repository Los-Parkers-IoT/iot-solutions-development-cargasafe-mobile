import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cargasafe/shared/presentation/theme/app_theme.dart';
import 'package:cargasafe/dashboard/presentation/pages/dashboard_page/dashboard_page.dart';
import 'package:cargasafe/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:cargasafe/dashboard/application/dashboard_service.dart';
import 'package:cargasafe/dashboard/infrastructure/repositories/dashboard_repository.dart';
import 'package:cargasafe/dashboard/infrastructure/datasources/dashboard_remote_datasource.dart';
import 'package:cargasafe/alerts/presentation/pages/alert_page/alerts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configurar dependencias
    final dataSource = DashboardRemoteDataSource();
    final repository = DashboardRepository(remoteDataSource: dataSource);
    final service = DashboardService(repository: repository);

    // Configurar rutas
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/alerts',
          name: 'alerts',
          builder: (context, state) => const AlertsPage(),
        ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(service: service),
        ),
      ],
      child: MaterialApp.router(
        title: 'CargaSafe',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
