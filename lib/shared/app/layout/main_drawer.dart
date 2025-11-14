import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final state = GoRouterState.of(context);
    final current = state.matchedLocation.isNotEmpty
        ? state.matchedLocation
        : state.uri.toString();

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      backgroundColor: cs.surface.withValues(alpha: .98),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 140,
            padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.onPrimary.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.local_shipping_rounded,
                    size: 28,
                    color: cs.onPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'CargaSafe',
                  style: TextStyle(
                    color: cs.onPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .2,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _Section(
                  children: [
                    _NavItem(
                      icon: Icons.dashboard_rounded,
                      label: 'Dashboard',
                      path: '/dashboard',
                      current: current,
                    ),
                  ],
                ),

                _Divider(cs: cs),

                _Section(
                  children: [
                    _NavItem(
                      icon: Icons.directions_car_filled_rounded,
                      label: 'Vehicles',
                      path: '/fleet/vehicles',
                      current: current,
                    ),
                    _NavItem(
                      icon: Icons.sensors_rounded,
                      label: 'Sensors',
                      path: '/fleet/devices',
                      current: current,
                    ),
                    _NavItem(
                      icon: Icons.route_rounded,
                      label: 'Trips',
                      path: '/trips',
                      current: current,
                    ),
                  ],
                ),

                _Divider(cs: cs),

                _Section(
                  children: [
                    _NavItem(
                      icon: Icons.warning_amber_rounded,
                      label: 'Alerts',
                      path: '/alerts',
                      current: current,
                    ),
                    _NavItem(
                      icon: Icons.subscriptions_rounded,
                      label: 'Subscriptions',
                      path: '/subscriptions',
                      current: current,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const _BottomDivider(),
          _NavItem(
            icon: Icons.logout_rounded,
            label: 'Log out',
            path: '/logout',
            current: current,
            isDestructive: true,
            popAfterTap: false,
            onTapOverride: (ctx) {
              Navigator.of(ctx).pop();
              GoRouter.of(ctx).go('/login');
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final List<Widget> children;
  const _Section({required this.children});

  @override
  Widget build(BuildContext context) => Column(
    children: children
        .map(
          (w) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: w,
          ),
        )
        .toList(),
  );
}

class _Divider extends StatelessWidget {
  final ColorScheme cs;
  const _Divider({required this.cs});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: cs.outlineVariant.withValues(alpha: .6),
    ),
  );
}

class _BottomDivider extends StatelessWidget {
  const _BottomDivider();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Divider(height: 1, indent: 16, endIndent: 16),
  );
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String path;
  final String current;
  final bool isDestructive;
  final bool popAfterTap;
  final void Function(BuildContext)? onTapOverride;

  const _NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.path,
    required this.current,
    this.isDestructive = false,
    this.popAfterTap = true,
    this.onTapOverride,
  });

  bool get _selected => current == path || current.startsWith('$path/');

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final textStyle = TextStyle(
      fontWeight: _selected ? FontWeight.w700 : FontWeight.w500,
      color: isDestructive
          ? Colors.red.shade700
          : (_selected ? cs.onSecondaryContainer : Colors.black87),
    );

    return Material(
      color: _selected
          ? cs.secondaryContainer.withValues(alpha: .6)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (onTapOverride != null) return onTapOverride!(context);
          if (popAfterTap) Navigator.of(context).pop();
          if (!_selected) GoRouter.of(context).go(path);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: isDestructive
                    ? Colors.red.shade700
                    : (_selected ? cs.onSecondaryContainer : Colors.black87),
              ),
              const SizedBox(width: 14),
              Text(label, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
