import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? borderColor;
  final double borderRadius;
  final Widget? prefixIcon;
  final bool showStrengthIndicator;

  const PasswordField({
    Key? key,
    required this.label,
    this.hintText = "Enter your password",
    this.controller,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.backgroundColor,
    this.labelColor,
    this.hintColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.prefixIcon,
    this.showStrengthIndicator = false,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;
  String _password = '';

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _password = widget.controller!.text;
      widget.controller!.addListener(() {
        setState(() {
          _password = widget.controller!.text;
        });
      });
    }
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  PasswordStrength _getPasswordStrength(String password) {
    if (password.isEmpty) return PasswordStrength.none;
    if (password.length < 6) return PasswordStrength.weak;

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int score = 0;
    if (password.length >= 8) score++;
    if (hasUppercase) score++;
    if (hasLowercase) score++;
    if (hasDigits) score++;
    if (hasSpecialCharacters) score++;

    if (score >= 4) return PasswordStrength.strong;
    if (score >= 2) return PasswordStrength.medium;
    return PasswordStrength.weak;
  }

  Color _getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.medium:
        return Colors.orange;
      case PasswordStrength.strong:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStrengthText(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordStrength = _getPasswordStrength(_password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: widget.labelColor ?? const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),

        // Password Field
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.borderColor ?? const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _isObscured,
            enabled: widget.enabled,
            onChanged: (value) {
              setState(() {
                _password = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            validator: widget.validator,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF374151),
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 16,
                color: widget.hintColor ?? const Color(0xFF9CA3AF),
              ),
              prefixIcon: widget.prefixIcon ??
                  Icon(
                    Icons.lock_outline,
                    color: const Color(0xFF7BC4D4),
                  ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: const Color(0xFF9CA3AF),
                ),
                onPressed: _toggleVisibility,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),

        // Password Strength Indicator
        if (widget.showStrengthIndicator && _password.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: passwordStrength.index,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: _getStrengthColor(passwordStrength),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3 - passwordStrength.index,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _getStrengthText(passwordStrength),
                style: TextStyle(
                  fontSize: 12,
                  color: _getStrengthColor(passwordStrength),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

enum PasswordStrength { none, weak, medium, strong }

// Usage Examples
// class PasswordFieldExamples extends StatefulWidget {
//   @override
//   _PasswordFieldExamplesState createState() => _PasswordFieldExamplesState();
// }
//
// class _PasswordFieldExamplesState extends State<PasswordFieldExamples> {
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Password Field Examples'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Basic password field
//             PasswordField(
//               label: "Password",
//               controller: _passwordController,
//               validator: (value) {
//                 if (value?.isEmpty ?? true) {
//                   return 'Password is required';
//                 }
//                 if (value!.length < 6) {
//                   return 'Password must be at least 6 characters';
//                 }
//                 return null;
//               },
//             ),
//
//             const SizedBox(height: 20),
//
//             // Password field with strength indicator
//             PasswordField(
//               label: "Create Password",
//               hintText: "Create a strong password",
//               showStrengthIndicator: true,
//               onChanged: (value) {
//                 print('Password changed: $value');
//               },
//             ),
//
//             const SizedBox(height: 20),
//
//             // Confirm password field
//             PasswordField(
//               label: "Confirm Password",
//               hintText: "Re-enter your password",
//               controller: _confirmPasswordController,
//               prefixIcon: Icon(
//                 Icons.lock_reset_outlined,
//                 color: Color(0xFF7BC4D4),
//               ),
//               validator: (value) {
//                 if (value != _passwordController.text) {
//                   return 'Passwords do not match';
//                 }
//                 return null;
//               },
//             ),
//
//             const SizedBox(height: 20),
//
//             // Custom styled password field
//             PasswordField(
//               label: "Current Password",
//               backgroundColor: const Color(0xFFE3F2FD),
//               borderColor: const Color(0xFF7BC4D4),
//               labelColor: const Color(0xFF7BC4D4),
//               borderRadius: 12,
//             ),
//
//             const SizedBox(height: 30),
//
//             // Submit button example
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle form submission
//                   print('Password: ${_passwordController.text}');
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF7BC4D4),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
// }