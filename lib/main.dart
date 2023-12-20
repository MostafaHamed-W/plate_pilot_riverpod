import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:plate_pilot_riverpod/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const PlatePilotRiverpod());
}

class PlatePilotRiverpod extends StatelessWidget {
  const PlatePilotRiverpod({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const Tabs(),
    );
  }
}
