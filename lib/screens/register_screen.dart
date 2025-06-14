import 'package:flutter/material.dart';
import 'package:KAS/routes/app_route.dart';
import 'package:KAS/screens/home_screen.dart';
import 'package:KAS/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isValidMail = false;
  bool _isValidPassword = false;
  bool _isMatchingPassword = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/kasLogo.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 24),
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),
                _fullNameField,
                const SizedBox(height: 16),
                _emailField,
                const SizedBox(height: 16),
                _passwordField,
                const SizedBox(height: 16),
                _confirmPasswordField,
                const SizedBox(height: 24),
                _registerButton,
                const SizedBox(height: 24),
                SocialLoginButtons(),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Takes user back to LoginScreen
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _fullNameField {
    return TextFormField(
      controller: _fullNameController,
      decoration: InputDecoration(
        labelText: "Full Name",
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your full name";
        }
        return null;
      },
    );
  }

  Widget get _emailField {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _isValidMail = value.contains("@gmail");
        });
      },
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(Icons.email),
        suffix:
            _isValidMail
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.check_circle, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your email";
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }

  Widget get _passwordField {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _isValidPassword = value.length >= 6;
          _isMatchingPassword = value == _confirmPasswordController.text;
        });
      },
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock),
        suffix:
            _isValidPassword
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.check_circle, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a password";
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

  Widget get _confirmPasswordField {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _isMatchingPassword = value == _passwordController.text;
        });
      },
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        prefixIcon: const Icon(Icons.lock_outline),
        suffix:
            _isMatchingPassword
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.check_circle, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please confirm your password";
        }
        if (value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }

  Widget get _registerButton {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // You can replace this with actual registration logic.
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(email: _emailController.text),
              ),
            );
          }
        },
        child: const Text(
          "Register",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Or login with",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.facebook,
              label: "Facebook",
              color: Colors.blue.shade800,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Facebook login not implemented"),
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.send, // Telegram-like icon
              label: "Telegram",
              color: Colors.blue,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Telegram login not implemented"),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label),
    );
  }
}
