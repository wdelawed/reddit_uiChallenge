import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme({required Brightness brightness}) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFE4501)),
    textTheme: GoogleFonts.openSansTextTheme(),
    useMaterial3: true,
  );
}
