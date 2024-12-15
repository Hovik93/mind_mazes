import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

class QuizResultPage extends StatefulWidget {
  final Map<String, dynamic> quizData;
  final List<int> userAnswers;

  const QuizResultPage({
    super.key,
    required this.quizData,
    required this.userAnswers,
  });

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  int correctAnswers = 0;
  int selectedQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.quizData['questions'].length; i++) {
      final question = widget.quizData['questions'][i];
      if (widget.userAnswers[i] + 1 == question['correctAnswer']) {
        correctAnswers++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.quizData['number']}:",
                    style: theme.titleSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      widget.quizData['quizTitle'],
                      style: theme.bodyLarge?.copyWith(
                        fontSize: 20.sp,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Результат: ", style: theme.titleSmall),
                      Text(
                        "$correctAnswers/${widget.quizData['questions'].length}",
                        style: theme.bodyMedium?.copyWith(
                            fontSize: 20.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 60.w,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: List.generate(
                  widget.quizData['questions'].length,
                  (index) {
                    final question = widget.quizData['questions'][index];
                    final isCorrect = question['correctAnswer'] ==
                        widget.userAnswers[index] + 1;
                    final isSelected = selectedQuestionIndex == index;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedQuestionIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8.w),
                          width: double.infinity,
                          height: 55.w,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isCorrect
                                    ? AppColors.green.withOpacity(0.5)
                                    : AppColors.red.withOpacity(0.5))
                                : (isCorrect
                                    ? AppColors.green.withOpacity(0.1)
                                    : AppColors.red.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: isSelected
                                  ? (isCorrect
                                      ? AppColors.green
                                      : AppColors.red)
                                  : (isCorrect
                                      ? AppColors.green
                                      : AppColors.red),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${index + 1}",
                            style: theme.bodyMedium?.copyWith(
                              fontSize: 20.sp,
                              color: isSelected
                                  ? AppColors.black
                                  : AppColors.grey1,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: (widget.userAnswers[selectedQuestionIndex] + 1 ==
                          widget.quizData['questions'][selectedQuestionIndex]
                              ['correctAnswer'])
                      ? AppColors.green.withOpacity(0.1)
                      : AppColors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: (widget.userAnswers[selectedQuestionIndex] + 1 ==
                            widget.quizData['questions'][selectedQuestionIndex]
                                ['correctAnswer'])
                        ? AppColors.green
                        : AppColors.red,
                  ),
                ),
                child: _buildQuestionDetails(theme),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      width: 152.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(width: 1, color: AppColors.primary)),
                      child: Center(
                        child: Text(
                          "На главную",
                          style: theme.titleSmall?.copyWith(
                            color: AppColors.primary,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 152.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Text(
                          "Еще раз",
                          style: theme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionDetails(TextTheme theme) {
    final question = widget.quizData['questions'][selectedQuestionIndex];
    final userAnswer = widget.userAnswers[selectedQuestionIndex] + 1;

    final isCorrect = userAnswer == question['correctAnswer'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${question['number']}",
          style: theme.titleSmall?.copyWith(
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ваш ответ: ",
              style: theme.titleSmall,
            ),
            Expanded(
              child: Text(
                "${userAnswer}. ${question['options'][userAnswer - 1]}",
                style: theme.titleSmall?.copyWith(color: AppColors.black),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Divider(
            height: 1,
            thickness: 1,
            color: isCorrect ? AppColors.green : AppColors.red,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Правильный ответ:",
              style: theme.titleSmall,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                "${question['correctAnswer']}",
                style: theme.titleSmall?.copyWith(color: AppColors.black),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          question['explanation'],
          style: theme.titleSmall?.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
