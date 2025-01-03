import 'package:animeverse/features/auth/pages/signin.dart';
import 'package:animeverse/features/auth/pages/signin_with_password.dart';
import 'package:animeverse/features/auth/provider/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/icon.png',
                ),
              ),
              const SizedBox(height: 24),
                Text(
                  'Sign Up',
                  style: GoogleFonts.urbanist(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                  label: 'First Name',
                  icon: Icons.person,
                  controller: firstNameController,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Last Name',
                  icon: Icons.person,
                  controller: lastNameController,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    // Handle sign up action
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    await authProvider.signUpWithEmail(
                      emailController.text,
                      passwordController.text,
                      firstNameController.text,
                      lastNameController.text,
                    );

                    // Redirect to SigninWithPassword page
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SigninWithPassword(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Green sign up button
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.urbanist(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Or sign up with',
                  style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      color: Colors.red,
                      icon: Icons.g_mobiledata,
                      label: 'Google',
                      onPressed: () {
                        // Handle Google sign up
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSignInPrompt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.urbanist(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
      style: GoogleFonts.urbanist(color: Colors.black),
    );
  }

  Widget _buildSocialButton({
    required Color color,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: GoogleFonts.urbanist(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: GoogleFonts.urbanist(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            );
          },
          child: Text(
            'Sign in',
            style: GoogleFonts.urbanist(
              color: const Color(0xFF06C149),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
