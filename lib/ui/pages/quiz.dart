import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/data/quiz_data.dart';
import 'package:mind_mazes/ui/details/quiz_details.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> filteredQuizData = quizData;
  final TextEditingController _searchController = TextEditingController();

  void _filterQuizzes(String query) {
    setState(() {
      filteredQuizData = quizData.where((quiz) {
        final titleMatch =
            quiz["quizTitle"].toLowerCase().contains(query.toLowerCase());
        final numberMatch =
            quiz["number"].toLowerCase().contains(query.toLowerCase());
        return titleMatch || numberMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: TapRegion(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus(); // Закрыть клавиатуру
        },
        child: body(theme: theme),
      ),
    );
  }

  Widget body({required TextTheme theme}) {
    return SafeArea(
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
                    'Квизы',
                    style: theme.bodySmall?.copyWith(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextField(
              controller: _searchController,
              onChanged: _filterQuizzes,
              decoration: InputDecoration(
                prefixIcon: Image.asset(AppImages.searchIcon),
                hintText: "Искать",
                hintStyle: theme.titleSmall,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.grey1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.grey1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.lavender),
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.w,
                  horizontal: 12.w,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.builder(
                itemCount: filteredQuizData.length,
                itemBuilder: (context, index) {
                  final quiz = filteredQuizData[index];

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.lavender.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.lavender),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${quiz["number"]}:",
                                  style: theme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  quiz["quizTitle"],
                                  style: theme.bodySmall?.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) {
                                  return QuizDetails(
                                    quizData: quiz,
                                  );
                                }),
                              );
                            },
                            child: Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                color: AppColors.lavender,
                                shape: BoxShape.circle,
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
