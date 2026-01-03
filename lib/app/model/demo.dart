import 'package:flutter/widgets.dart';

/// Metadata for a single demo included in this repository.
class Demo {
  final String id;
  final String title;
  final WidgetBuilder builder;
  final List<String> tags;

  const Demo({
    required this.id,
    required this.title,
    required this.builder,
    this.tags = const <String>[],
  });
}

