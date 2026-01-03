import 'package:flutter/material.dart';

import '../demo_registry.dart';
import '../model/demo.dart';
import '../router/app_router.dart';

/// Lightweight catalog of all demos in this repository.
///
/// This is the default `home` for the app.
class DemoCatalogPage extends StatefulWidget {
  const DemoCatalogPage({super.key});

  @override
  State<DemoCatalogPage> createState() => _DemoCatalogPageState();
}

class _DemoCatalogPageState extends State<DemoCatalogPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final demos = _filteredDemos(DemoRegistry.demos, _query);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Paint Animations'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search demos…',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid: wider screens get more columns.
                final width = constraints.maxWidth;
                final crossAxisCount = width >= 1100
                    ? 4
                    : width >= 800
                        ? 3
                        : width >= 520
                            ? 2
                            : 1;

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: crossAxisCount == 1 ? 3.4 : 1.6,
                  ),
                  itemCount: demos.length,
                  itemBuilder: (context, index) {
                    final demo = demos[index];
                    return _DemoCard(
                      demo: demo,
                      onTap: () {
                        try {
                          Navigator.of(context).pushNamed(
                            AppRouter.demoRoute(demo.id),
                          );
                        } catch (e, st) {
                          // Avoid silently failing into a white screen.
                          debugPrint('Failed to open demo ${demo.id}: $e');
                          debugPrintStack(stackTrace: st);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to open demo: ${demo.title}'),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final Demo demo;
  final VoidCallback onTap;

  const _DemoCard({
    required this.demo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            // Retro neon outline
            color: accent.withValues(alpha: 0.45),
            width: 1,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface.withValues(alpha: 0.70),
              theme.colorScheme.surface.withValues(alpha: 0.35),
            ],
          ),
          boxShadow: [
            // Subtle glow (not a rainbow)
            BoxShadow(
              color: accent.withValues(alpha: 0.18),
              blurRadius: 18,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // Content
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      demo.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      demo.id,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        letterSpacing: 0.6,
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.chevron_right,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              // Tiny scanlines overlay for retro feel
              IgnorePointer(
                child: Opacity(
                  opacity: 0.06,
                  child: _ScanlinesOverlay(
                    lineHeight: 3,
                    gap: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScanlinesOverlay extends StatelessWidget {
  const _ScanlinesOverlay({
    required this.lineHeight,
    required this.gap,
  });

  final double lineHeight;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final count = (h / (lineHeight + gap)).ceil();

        return Column(
          children: [
            for (int i = 0; i < count; i++)
              Padding(
                padding: EdgeInsets.only(bottom: i == count - 1 ? 0 : gap),
                child: Container(
                  height: lineHeight,
                  color: Colors.black,
                ),
              ),
          ],
        );
      },
    );
  }
}

List<Demo> _filteredDemos(List<Demo> demos, String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return demos;

  return demos.where((d) {
    if (d.title.toLowerCase().contains(q)) return true;
    for (final tag in d.tags) {
      if (tag.toLowerCase().contains(q)) return true;
    }
    return false;
  }).toList();
}
