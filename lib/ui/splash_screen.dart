import 'package:flutter/material.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/ui/data_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color backgroundColor = AppColors.lavender;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        backgroundColor = AppColors.lime;
      });
    });

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          _checkOnboardingStatus();
        }
      },
    );
  }

  Future<void> _checkOnboardingStatus() async {
    bool onboardingSeen = await DataStorage.isOnboardingSeen();
    if (onboardingSeen) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/onBoarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
        color: backgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.logoIcon),
                const SizedBox(height: 20),
                Text(
                  'Mind Mazes',
                  style: theme.headlineLarge?.copyWith(color: AppColors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
