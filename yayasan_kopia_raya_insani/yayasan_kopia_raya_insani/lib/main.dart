import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'day_20/constans/app_colors.dart';
import 'day_20/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KopiaRayaInsaniApp());
}

class KopiaRayaInsaniApp extends StatelessWidget {
  const KopiaRayaInsaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yayasan Kopia Raya Insani',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          // background: AppColors.background,
          error: AppColors.error,
        ),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashScreen(),
    );
  }
}
