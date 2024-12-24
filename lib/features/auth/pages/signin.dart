import 'package:animeverse/features/auth/pages/signin_with_password.dart';
import 'package:animeverse/features/auth/pages/signup.dart';
import 'package:animeverse/features/auth/provider/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 39),
                _buildLogo(),
                const SizedBox(height: 16),
                _buildHeader(),
                const SizedBox(height: 40),
                const SizedBox(height: 16),
                _buildSocialButton(
                  iconUrl:
                      'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0Re26C0t0tieWblXnFog%2F7e3199e6-826d-46ed-b8ff-6f0943e720ce.png',
                  text: 'Continue with Google',
                  onPressed: () async {
                    final authProvider = context.read<AuthProvider>();
                    await authProvider.signInWithGoogle(context);
                  },
                ),
                const SizedBox(height: 20),
                _buildDividerWithText(),
                const SizedBox(height: 20),
                _buildSignInButton(context),
                const SizedBox(height: 20),
                _buildSignUpPrompt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset('assets/icon.png'),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Text(
      'Let’s you in',
      textAlign: TextAlign.center,
      style: GoogleFonts.urbanist(
        color: Colors.grey.shade900,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSocialButton({
    required String iconUrl,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(iconUrl, width: 24, height: 24),
            const SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.urbanist(
                color: Colors.grey.shade900,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerWithText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: Divider(color: Colors.grey)),
        const SizedBox(width: 8),
        Text(
          'or',
          style: GoogleFonts.urbanist(
            color: Colors.grey.shade700,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }

  Widget _buildSignInButton(context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFF06C149),
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F06C149),
            offset: Offset(4, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SigninWithPassword(),
            ),
          );
        },
        child: Text(
          'Sign in with password',
          style: GoogleFonts.urbanist(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don’t have an account?',
          style: GoogleFonts.urbanist(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SignupScreen(),
              ),
            );
          },
          child: Text(
            'Sign up',
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
