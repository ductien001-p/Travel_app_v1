import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/deep_link/deep_link_service.dart';
import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

class TravelSocialApp extends ConsumerStatefulWidget {
  const TravelSocialApp({super.key});

  @override
  ConsumerState<TravelSocialApp> createState() => _TravelSocialAppState();
}

class _TravelSocialAppState extends ConsumerState<TravelSocialApp> {
  StreamSubscription<String>? _deepLinks;

  @override
  void initState() {
    super.initState();
    // The router's auth redirect keeps the path through splash and login.
    _deepLinks = ref
        .read(deepLinkServiceProvider)
        .appPaths
        .listen((path) => ref.read(routerProvider).go(path));
  }

  @override
  void dispose() {
    _deepLinks?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Travel Social',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,

      routerConfig: router,
    );
  }
}
