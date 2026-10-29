import 'package:flutter/material.dart';

import 'screens/beranda_screen.dart';

class KampusKuApp extends StatelessWidget {
  const KampusKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KampusKu',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0F1D),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          onPrimary: Color(0xFF00363D),
          primaryContainer: Color(0xFF112236),
          onPrimaryContainer: Color(0xFFB3F5FF),
          secondary: Color(0xFF6366F1),
          surface: Color(0xFF131B2E),
          onSurface: Color(0xFFE2E8F0),
          surfaceContainerHighest: Color(0xFF1B263E),
          outline: Color(0xFF23324D),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0F1D),
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          iconTheme: IconThemeData(color: Color(0xFF00E5FF)),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF131B2E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFF1F2B44), width: 1),
          ),
        ),
        dividerColor: const Color(0xFF1E293B),
      ),
      home: const BerandaScreen(),
    );
  }
}
