// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/data/cognitive_distortions_data.dart';
import 'package:mind_mazes/data/paradoxes_data.dart';
import 'package:mind_mazes/ui/pages/decision_chains.dart';
import 'package:mind_mazes/ui/pages/education.dart';
import 'package:mind_mazes/ui/pages/quiz.dart';
import 'package:mind_mazes/ui/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isExpandedLime = false;
  bool _isExpandedLavender = false;
  bool _isExpandedPastelBlue = false;

  bool showEducation = false;
  bool showQuiz = false;
  bool showDecisionChains = false;

  bool _cognitiveExpanded = false;
  bool _paradoxesExpanded = false;

  void _closeAllMainSections() {
    _isExpandedLime = false;
    _isExpandedLavender = false;
    _isExpandedPastelBlue = false;
    showEducation = false;
    showQuiz = false;
    showDecisionChains = false;
  }

  void _closeAllSubSections() {
    _cognitiveExpanded = false;
    _paradoxesExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: body(theme: theme),
    );
  }

  Widget body({required TextTheme theme}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mind Mazes',
                      style: theme.bodySmall
                          ?.copyWith(fontSize: 40.sp, color: AppColors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            return SettingsScreen();
                          }),
                        );
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: AppColors.black,
                          ),
                        ),
                        child: const Icon(Icons.settings),
                      ),
                    ),
                  ],
                ),
              ),
              CollapsibleCard(
                title: 'Когнитивные искажения',
                content:
                    'Это систематические ошибки в восприятии, интерпретации и обработке информации, которые влияют на наши решения и суждения. Эти искажения могут приводить к неправильным выводам, несправедливым решениям или даже ошибочным действиям.',
                onTapClose: () {
                  setState(() {
                    _closeAllMainSections();
                    _cognitiveExpanded = !_cognitiveExpanded;
                  });
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return EducationScreen(
                        data: cognitiveDistortionsData,
                      );
                    }),
                  );
                },
                isExpanded: _cognitiveExpanded,
              ),
              SizedBox(height: 10),
              CollapsibleCard(
                title: 'Парадоксы',
                content:
                    'Это ситуации, в которых интуитивно верные решения оказываются противоречивыми или парадоксальными на основе логического анализа. Они часто вводят нас в заблуждение и требуют особого подхода для правильного разрешения.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return EducationScreen(
                        data: paradoxesData,
                      );
                    }),
                  );
                },
                onTapClose: () {
                  setState(() {
                    _closeAllMainSections();
                    _paradoxesExpanded = !_paradoxesExpanded;
                  });
                },
                isExpanded: _paradoxesExpanded,
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _closeAllSubSections();
                    _isExpandedLime = !_isExpandedLime;
                  });
                  Future.delayed(
                    const Duration(milliseconds: 0),
                    () {
                      if (mounted) {
                        showEducation = !showEducation;
                        setState(() {});
                      }
                    },
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  curve: Curves.easeInOut,
                  height: _isExpandedLime ? 150.w : 62.w,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Обучение',
                              style: theme.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) {
                                    return EducationScreen(
                                      data: cognitiveDistortionsData +
                                          paradoxesData,
                                    );
                                  }),
                                );
                              },
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (showEducation)
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 0),
                          child: _isExpandedLime
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    'Учитесь распознавать и избегать когнитивных искажений и парадоксов, таких как эффект Даннинга-Крюгера, ошибка выжившего, парадокс Монти Холла и другие.',
                                    style: theme.bodySmall,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 200,
                      height: _isExpandedLavender ? 150.w : 62.w,
                      color: AppColors.lime,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _closeAllSubSections();
                        _isExpandedLavender = !_isExpandedLavender;
                      });
                      Future.delayed(
                        const Duration(milliseconds: 0),
                        () {
                          if (mounted) {
                            showQuiz = !showQuiz;
                            setState(() {});
                          }
                        },
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      height: _isExpandedLavender ? 140.w : 62.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lavender,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Квизы',
                                  style: theme.bodyMedium,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) {
                                        return QuizScreen();
                                      }),
                                    );
                                  },
                                  child: Container(
                                      width: 20.w,
                                      height: 20.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primary,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.black,
                                        size: 18,
                                      )),
                                )
                              ],
                            ),
                          ),
                          if (showQuiz)
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 0),
                              child: _isExpandedLavender
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        'Квизы с интерактивными сценариями, где необходимо выбрать верный ответ для разных ситуаций',
                                        style: theme.bodySmall,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 200,
                      height: _isExpandedPastelBlue ? 150.w : 82.w,
                      color: AppColors.lavender,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _closeAllSubSections();
                        _isExpandedPastelBlue = !_isExpandedPastelBlue;
                      });
                      Future.delayed(
                        const Duration(milliseconds: 0),
                        () {
                          if (mounted) {
                            showDecisionChains = !showDecisionChains;
                            setState(() {});
                          }
                        },
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      height: _isExpandedPastelBlue ? 190.w : 82.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.pastelBlue,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Цепочки решений',
                                  style: theme.bodyMedium,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) {
                                        return DecisionChainsScreen();
                                      }),
                                    );
                                  },
                                  child: Container(
                                      width: 20.w,
                                      height: 20.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primary,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.black,
                                        size: 18,
                                      )),
                                )
                              ],
                            ),
                          ),
                          if (showDecisionChains)
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 0),
                              child: _isExpandedPastelBlue
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        'Выбирайте один из предложенных сценариев и принимайте решения, основываясь на доступной информации. Каждое ваше решение будет вызывать новое событие, которое влияет на дальнейший выбор, формируя цепочку из нескольких связанных ситуаций.',
                                        style: theme.bodySmall,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CollapsibleCard extends StatefulWidget {
  final String title;
  final String content;
  void Function() onTap;
  final VoidCallback onTapClose;
  final bool isExpanded;

  CollapsibleCard({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
    required this.onTapClose,
    required this.isExpanded,
  });

  @override
  _CollapsibleCardState createState() => _CollapsibleCardState();
}

class _CollapsibleCardState extends State<CollapsibleCard> {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: widget.onTapClose,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 0),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            if (widget.isExpanded)
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: theme.titleSmall
                      ?.copyWith(color: AppColors.black, fontSize: 18.sp),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: AnimatedRotation(
                    turns: widget.isExpanded ? 0.0 : 0.0,
                    duration: const Duration(milliseconds: 0),
                    child: Image.asset(!widget.isExpanded
                        ? AppImages.arrowRightDown
                        : AppImages.arrowRightUp),
                  ),
                ),
              ],
            ),
            if (widget.isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.content,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
