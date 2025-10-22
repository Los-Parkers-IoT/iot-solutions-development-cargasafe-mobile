import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleReset() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (_newPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset successfully!')),
    );

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 35, child: _buildOrangePanel(isVertical: false)),
        Expanded(flex: 65, child: _buildFormPanel(maxWidth: 480)),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildOrangePanel(isVertical: true),
        Expanded(child: _buildFormPanel(maxWidth: double.infinity)),
      ],
    );
  }

  Widget _buildOrangePanel({required bool isVertical}) {
    if (isVertical) {
      return Container(
        color: Color(0xFFFF9333),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_shipping, size: 36, color: Colors.white),
                  SizedBox(width: 8),
                  Text('CargaSafe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ),
              SizedBox(height: 6),
              Text('Smart Cargo Monitoring', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      );
    } else {
      return Container(
        color: Color(0xFFFF9333),
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_shipping, size: 80, color: Colors.white),
                SizedBox(width: 14),
                Text('CargaSafe', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: Colors.white)),
              ],
            ),
            SizedBox(height: 80),
            Text('Almost there!', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2)),
            SizedBox(height: 28),
            Text(
              'Create a strong and secure password for your account. Make sure to follow all security requirements.',
              style: TextStyle(fontSize: 22, color: Colors.white, height: 1.65),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildFormPanel({required double maxWidth}) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, size: 18, color: Colors.black87),
                    SizedBox(width: 6),
                    Text('Back to Log In', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(height: 24),

              Text('Create New Password', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black), textAlign: TextAlign.center),
              SizedBox(height: 8),
              Text(
                "Please enter your new password. Make sure it's strong and secure.",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              Text('New Password', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
              SizedBox(height: 8),
              Container(
                height: 48,
                child: TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey[400]!)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Color(0xFFFF9333), width: 2)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 16),

              Text('Confirm Password', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
              SizedBox(height: 8),
              Container(
                height: 48,
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey[400]!)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Color(0xFFFF9333), width: 2)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 24),

              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleReset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF9333),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  child: Text('Reset Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}