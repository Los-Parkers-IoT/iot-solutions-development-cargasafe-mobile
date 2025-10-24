import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'iam/presentation//login/login_screen.dart';
import 'iam/presentation/password_recovery/password_recovery.dart';
import 'iam/presentation//register/register_screen.dart';
import 'iam/presentation//new_password/new_password.dart';
import 'iam/presentation//otp_verification/otp_verification.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CargaSafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFFFF9333),
          onPrimary: Colors.white,
        ),
        fontFamily: GoogleFonts.sourceSans3().fontFamily,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/password-recovery': (context) => const PasswordRecoveryScreen(),
        '/otp-verification': (context) => const OtpVerificationScreen(),
        '/new-password': (context) => const NewPasswordScreen(),
      },
    );
  }
}