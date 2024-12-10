import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/ui/data_storage.dart';

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
    Navigator.pushReplacementNamed(
        context, '/home'); // Переход на главный экран
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currentIndex != 2
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: _skipOnboarding,
                                child: Text(
                                  "Пропустить",
                                  style: theme.bodySmall?.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.grey2,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Image.asset(
                      _onBoardingData[_currentIndex]['image']!,
                    ),
                  ],
                ),
              ),

              // Изображение и текст
              Expanded(
                flex: 35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text("Mind Mazes", style: theme.headlineLarge),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Text(
                        _onBoardingData[_currentIndex]['text']!,
                        style: theme.titleSmall,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: _nextPage,
                      child: Container(
                        width: double.infinity,
                        height: 48.w,
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.primary),
                        child: Center(
                          child: Text(
                            _currentIndex == _onBoardingData.length - 1
                                ? "Начать"
                                : "Далее",
                            style: theme.bodySmall?.copyWith(
                                color: AppColors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Условия использования',
                      style: theme.titleSmall?.copyWith(fontSize: 9),
                    ),
                    Text(
                      "|",
                      style: TextStyle(color: AppColors.primary),
                    ),
                    Text(
                      'Политика конфиденциальности',
                      style: theme.titleSmall?.copyWith(fontSize: 9),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
