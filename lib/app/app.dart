import 'package:animeverse/app/routes/app_splashScreen.dart';
import 'package:animeverse/theme/appTheme.dart';
import 'package:animeverse/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AnimeVerse',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          builder: (context, child) {
            ErrorWidget.builder = (FlutterErrorDetails details) {
              debugPrint('❌ Error in app: ${details.exception}');
              return const Material(
                child: Center(
                  child: Text('Something went wrong. Please restart the app.'),
                ),
              );
            };
            return child ?? const SizedBox.shrink();
          },
          home: const Scaffold(
            body: SplashScreen(),
          ),
        );
      },
    );
  }
}
