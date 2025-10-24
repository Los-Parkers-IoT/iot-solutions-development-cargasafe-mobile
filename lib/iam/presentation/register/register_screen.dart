import 'package:flutter/material.dart';
import '../../../../shared/utils/validators.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _segment = 'Client';

  final _companyEmailController = TextEditingController();
  final _legalNameController = TextEditingController();
  final _rucIdController = TextEditingController();
  final _fiscalAddressController = TextEditingController();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _termsAccepted = false;

  @override
  void dispose() {
    _companyEmailController.dispose();
    _legalNameController.dispose();
    _rucIdController.dispose();
    _fiscalAddressController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must accept the terms and conditions')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      print('Register: ${_emailController.text}, Segment: $_segment');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully!')),
      );

      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
        Expanded(
          flex: 35,
          child: _buildOrangePanel(isVertical: false),
        ),
        Expanded(
          flex: 65,
          child: _buildFormPanel(maxWidth: 680),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildOrangePanel(isVertical: true),
        Expanded(
          child: _buildFormPanel(maxWidth: double.infinity),
        ),
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
                  Text(
                    'CargaSafe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Smart Cargo Monitoring',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
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
                Text(
                  'CargaSafe',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            Text(
              'Join Us',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            SizedBox(height: 28),
            Text(
              'Monitor all your shipments on a single platform. Consolidate temperature, humidity, vibration, and location in real-time to protect your high-value products.',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                height: 1.65,
              ),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, size: 18, color: Colors.black87),
                      SizedBox(width: 6),
                      Text(
                        'Back to Log In',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                Text(
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),

                Text(
                  'Complete the data to register',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),

                _buildSectionTitle('Choose your segment'),
                SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        value: 'Client',
                        groupValue: _segment,
                        onChanged: (value) {
                          setState(() => _segment = value!);
                        },
                        title: Text('Client', style: TextStyle(fontSize: 14)),
                        activeColor: Color(0xFFFF9333),
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        value: 'Shipping Company',
                        groupValue: _segment,
                        onChanged: (value) {
                          setState(() => _segment = value!);
                        },
                        title: Text('Shipping Company', style: TextStyle(fontSize: 14)),
                        activeColor: Color(0xFFFF9333),
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                if (_segment == 'Shipping Company') ...[
                  _buildSectionTitle('Company Data'),
                  SizedBox(height: 12),

                  _buildTextField(
                    controller: _companyEmailController,
                    label: 'Company contact email',
                    validator: Validators.validateEmail,
                  ),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _legalNameController,
                          label: 'Legal Name',
                          validator: (value) => Validators.validateRequired(value, 'Legal Name'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _rucIdController,
                          label: 'RUC ID',
                          validator: (value) => Validators.validateRequired(value, 'RUC ID'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  _buildTextField(
                    controller: _fiscalAddressController,
                    label: 'Fiscal Address',
                    validator: (value) => Validators.validateRequired(value, 'Fiscal Address'),
                  ),
                  SizedBox(height: 24),
                ],

                _buildSectionTitle(
                    _segment == 'Shipping Company'
                        ? 'Administrator Details'
                        : 'Profile Data'
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _firstNameController,
                        label: 'First Name',
                        validator: (value) => Validators.validateRequired(value, 'First Name'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        validator: (value) => Validators.validateRequired(value, 'Last Name'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                _buildSectionTitle(
                    _segment == 'Shipping Company'
                        ? 'Administrator Account'
                        : 'Account Data'
                ),
                SizedBox(height: 12),

                _buildTextField(
                  controller: _emailController,
                  label: 'Email address',
                  validator: Validators.validateEmail,
                ),
                SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true,
                        validator: Validators.validatePassword,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm password',
                        obscureText: true,
                        validator: (value) => Validators.validateConfirmPassword(
                            value,
                            _passwordController.text
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: Checkbox(
                        value: _termsAccepted,
                        onChanged: (value) {
                          setState(() => _termsAccepted = value ?? false);
                        },
                        activeColor: Color(0xFFFF9333),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        children: [
                          Text(
                            'By accepting, you agree to the application\'s ',
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'terms and conditions',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFF9333),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '.',
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF9333),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Color(0xFFFF9333), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isDense: true,
            errorStyle: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }

}
