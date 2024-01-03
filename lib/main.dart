import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:food_ui/Home/home.dart';

// Using ProviderScope for state management provided by riverpod package
void main() => runApp(const ProviderScope(child: FoodUI()));

class FoodUI extends StatelessWidget {
  const FoodUI({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome is used to manage the appearance of status & navigation bar provided by services packages.
    // It also controls the orientation, immersive mode or Platform specific behaviour
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      title: 'Food UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff45C37B)
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}