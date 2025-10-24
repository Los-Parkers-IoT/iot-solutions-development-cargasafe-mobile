import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleVerify() {
    String code = _controllers.map((c) => c.text).join();
    if (code.length == 6) {
      Navigator.pushNamed(context, '/new-password');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the complete 6-digit code')),
      );
    }
  }

  void _onKeyDown(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      }
    }
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
            Text('Verify your\nidentity', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2)),
            SizedBox(height: 28),
            Text(
              "We've sent a verification code to your email. Please enter it to continue with the password recovery process.",
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
                onTap: () => Navigator.pop(context),
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

              Text('Verify OTP Code', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black), textAlign: TextAlign.center),
              SizedBox(height: 8),
              Text(
                "We've sent a 6-digit verification code to your email. Please enter it below.",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[400]!)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[400]!)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Color(0xFFFF9333), width: 2)),
                      ),
                      onChanged: (value) => _onKeyDown(index, value),
                    ),
                  );
                }),
              ),
              SizedBox(height: 24),

              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleVerify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF9333),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  child: Text('Verify Code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive the code? ", style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code resent!')));
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(0, 0), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: Text('Resend Code', style: TextStyle(color: Color(0xFFFF9333), fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}