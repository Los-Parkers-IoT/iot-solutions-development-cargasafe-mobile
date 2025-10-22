import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'iam/presentation/pages/login/login_page.dart';
import 'iam/presentation/pages/password_recovery/password_recovery.dart';
import 'iam/presentation/pages/register/register_page.dart';
import 'iam/presentation/pages/new_password/new_password.dart';
import 'iam/presentation/pages/otp_verification/otp_verification.dart';



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
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/password-recovery': (context) => const PasswordRecoveryPage(),
        '/otp-verification': (context) => const OtpVerificationPage(),
        '/new-password': (context) => const NewPasswordPage(),
      },
    );
  }
}