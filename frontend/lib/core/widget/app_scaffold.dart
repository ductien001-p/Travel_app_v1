import 'package:flutter/material.dart';

import 'app_background.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.topBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = true,
  });

  final Widget body;
  final Widget? topBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: AppBackground(
        child: SafeArea(
          bottom: bottomNavigationBar == null,
          child: Column(
            children: [
              ?topBar,
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}
