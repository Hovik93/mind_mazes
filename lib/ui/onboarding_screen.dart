import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/constants.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/ui/data_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> _onBoardingData = [
    {
      'image': AppImages.onboarding1,
      'text':
          "Научитесь распознавать и избегать когнитивных искажений и парадоксов.",
    },
    {
      'image': AppImages.onboarding2,
      'text':
          "Включены объяснения теорий и рекомендации по развитию критического мышления.",
    },
    {
      'image': AppImages.onboarding3,
      'text':
          "Выбирайте один из сценариев и принимайте решения, основываясь на доступной информации.",
    },
  ];

  void _nextPage() async {
    if (_currentIndex < _onBoardingData.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      await DataStorage.setOnboardingSeen();
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _skipOnboarding() async {
    await DataStorage.setOnboardingSeen();
    Navigator.pushReplacementNamed(context, '/home');
  }

  _launchURL({required String urlLink}) async {
    final Uri url = Uri.parse(urlLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_currentIndex != _onBoardingData.length - 1)
                    Padding(
                      padding: EdgeInsets.only(top: 10.w, right: 20.w),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: _skipOnboarding,
                          child: Text(
                            "Пропустить",
                            style: theme.bodySmall?.copyWith(
                              decoration: TextDecoration.underline,
                              color: AppColors.grey2,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 40.w),
                  Expanded(
                    child: Image.asset(
                      _onBoardingData[_currentIndex]['image']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 40.w),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Mind Mazes",
                    style: theme.headlineLarge?.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    _onBoardingData[_currentIndex]['text']!,
                    style: theme.titleSmall?.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.grey2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.w),
                  GestureDetector(
                    onTap: _nextPage,
                    child: Container(
                      width: double.infinity,
                      height: 48.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          _currentIndex == _onBoardingData.length - 1
                              ? "Начать"
                              : "Далее",
                          style: theme.bodySmall?.copyWith(
                            color: AppColors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _launchURL(urlLink: userAgreementUrl);
                        },
                        child: Text(
                          'Условия использования',
                          style: theme.titleSmall?.copyWith(fontSize: 10.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          "|",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL(urlLink: privacyPolicyUrl);
                        },
                        child: Text(
                          'Политика конфиденциальности',
                          style: theme.titleSmall?.copyWith(fontSize: 10.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
