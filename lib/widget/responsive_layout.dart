import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;

  const ResponsiveLayout({required this.mobileBody, required this.tabletBody, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use 600 as a common breakpoint for mobile/tablet
        if (constraints.maxWidth < 600) {
          return mobileBody;
        } else {
          return tabletBody;
        }
      },
    );
  }
}
