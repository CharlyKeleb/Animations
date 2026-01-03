import 'package:flutter/material.dart';

import '../demo_registry.dart';
import '../home/demo_catalog_page.dart';

/// Central place for all navigation.
class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String _demoBase = '/demo';

  static String demoRoute(String id) => '$_demoBase/$id';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final name = settings.name ?? home;

    if (name == home) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const DemoCatalogPage(),
      );
    }

    if (name.startsWith('$_demoBase/')) {
      final id = name.substring('$_demoBase/'.length);
      final demo = DemoRegistry.byId(id);

      if (demo == null) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => _UnknownRoutePage(routeName: name),
        );
      }

      return MaterialPageRoute<void>(
        settings: settings,
        builder: demo.builder,
      );
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => _UnknownRoutePage(routeName: name),
    );
  }
}

class _UnknownRoutePage extends StatelessWidget {
  final String routeName;

  const _UnknownRoutePage({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not found')),
      body: Center(
        child: Text('Unknown route: $routeName'),
      ),
    );
  }
}
