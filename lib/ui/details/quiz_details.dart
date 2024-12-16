import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/ui/details/quiz_result.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

class QuizDetails extends StatefulWidget {
  final Map<String, dynamic> quizData;

  const QuizDetails({
    super.key,
    required this.quizData,
  });

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  bool showCorrectAnswer = false;
  List<int> userAnswers = [];

  void _handleAnswerSelected(int index) {
    setState(() {
      selectedAnswer = index;
      showCorrectAnswer = true;

      if (userAnswers.length > currentQuestionIndex) {
        userAnswers[currentQuestionIndex] = index;
      } else {
        userAnswers.add(index);
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (currentQuestionIndex < widget.quizData['questions'].length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
          showCorrectAnswer = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => QuizResultPage(
              quizData: widget.quizData,
              userAnswers: userAnswers,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final question = widget.quizData['questions'][currentQuestionIndex];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomBorderContainer(
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 16.w, bottom: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.grey2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.quizData['number'],
                      style: theme.bodySmall?.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              question['number'],
                              style: theme.titleSmall,
                            ),
                            Text(
                              "${currentQuestionIndex + 1}/${widget.quizData['questions'].length}",
                              style: theme.bodySmall,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "${question['title']}",
                            style: theme.bodyMedium?.copyWith(
                              fontSize: 24.sp,
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.lavender,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                              color: AppColors.lavender.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 1, color: AppColors.lavender)),
                          child: Text(
                            question['description'],
                            style: theme.bodySmall
                                ?.copyWith(color: AppColors.black),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Выберите ответ:",
                          style: theme.titleSmall?.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 10.w),
                        Column(
                          children: List.generate(
                            question['options'].length,
                            (index) {
                              Color optionColor = AppColors.greyLight;

                              if (showCorrectAnswer) {
                                if (index + 1 == question['correctAnswer']) {
                                  optionColor = AppColors.green;
                                } else if (index == selectedAnswer) {
                                  optionColor = AppColors.red;
                                }
                              }

                              return GestureDetector(
                                onTap: showCorrectAnswer
                                    ? null
                                    : () => _handleAnswerSelected(index),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10.w),
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: optionColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: AppColors.lavender),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${index + 1}. ",
                                        style: theme.bodyMedium?.copyWith(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          question['options'][index],
                                          style: theme.bodyMedium?.copyWith(
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
