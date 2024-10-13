import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                _buildSocialButton(
                  iconUrl:
                      'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0Re26C0t0tieWblXnFog%2F71a7e668-8912-4017-a589-5ab634cf8325.png',
                  text: 'Continue with Facebook',
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                _buildSocialButton(
                  iconUrl:
                      'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0Re26C0t0tieWblXnFog%2F7e3199e6-826d-46ed-b8ff-6f0943e720ce.png',
                  text: 'Continue with Google',
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                _buildDividerWithText(),
                const SizedBox(height: 20),
                _buildSignInButton(),
                const SizedBox(height: 20),
                _buildSignUpPrompt(),
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
        Transform.rotate(
          angle: 90 * 3.14 / 180,
          child: Image.network(
            'https://static.vecteezy.com/system/resources/thumbnails/022/385/025/small_2x/a-cute-surprised-black-haired-anime-girl-under-the-blooming-sakura-ai-generated-photo.jpg',
            width: 16,
            height: 19,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 0,
          child: Image.network(
            'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0Re26C0t0tieWblXnFog%2F30379b21-8fff-4f6c-a848-ba1e6be1c59a.png',
            width: 237,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 17,
          child: Opacity(
            opacity: 0.1,
            child: Image.network(
              'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0Re26C0t0tieWblXnFog%2F444b4475-e551-41ec-b454-aa18d648689c.png',
              width: 110,
              height: 102,
              fit: BoxFit.contain,
            ),
          ),
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

  Widget _buildSignInButton() {
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
        onPressed: () {},
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

  Widget _buildSignUpPrompt() {
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
          onPressed: () {},
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
