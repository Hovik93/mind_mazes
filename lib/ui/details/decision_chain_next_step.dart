// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/ui/details/decision_chain_next_choice.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

// ignore: must_be_immutable
class DecisionChainNextStepScreen extends StatefulWidget {
  final Map<String, dynamic> nextStepData;
  final Map<String, dynamic> fullData;
  String? number;

  DecisionChainNextStepScreen({
    super.key,
    required this.nextStepData,
    required this.fullData,
    this.number,
  });

  @override
  State<DecisionChainNextStepScreen> createState() =>
      _DecisionChainNextStepScreenState();
}

class _DecisionChainNextStepScreenState
    extends State<DecisionChainNextStepScreen> {
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final choices = widget.nextStepData['choices'];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomBorderContainer(
              child: Padding(
                padding: EdgeInsets.only(top: 20.w, left: 16.w, bottom: 15.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_new,
                          color: AppColors.grey2),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Цепочка решений ${widget.number}",
                      style: theme.bodySmall?.copyWith(
                        fontSize: 17.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Этап 2",
                    style: theme.titleSmall,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.fullData['title'] ?? '',
                    style: theme.titleSmall?.copyWith(
                      fontSize: 24.sp,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.nextStepData['description'] ??
                        "Вы столкнулись с убытками. Как поступить дальше?",
                    style: theme.titleSmall?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.primary,
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: choices.length,
                itemBuilder: (context, index) {
                  final choice = choices[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOptionIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: selectedOptionIndex == index
                            ? AppColors.primary.withOpacity(0.1)
                            : Colors.transparent,
                        border: Border(
                          left: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            index == 0
                                ? "Правильное решение — ${choice['choice']}"
                                : "Неправильное решение — ${choice['choice']}",
                            style: theme.bodyMedium?.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            choice['result'],
                            style: theme.bodySmall?.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.grey2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text("Выберите действие:", style: theme.titleSmall),
                ),
                if (selectedOptionIndex != null) SizedBox(height: 10.w),
                if (selectedOptionIndex != null)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        choices[selectedOptionIndex!]['choice'],
                        style: theme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                if (selectedOptionIndex != null)
                  Padding(
                    padding: EdgeInsets.only(right: 16.w, top: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 11.w,
                          height: 5.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.primary,
                          ),
                        ),
                        Container(
                          width: 5.w,
                          height: 5.w,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.grey1,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 10.w),
                GestureDetector(
                  onTap: () {
                    if (selectedOptionIndex != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DecisionChainNextChoiceScreen(
                            selectedData: choices[selectedOptionIndex!],
                            number: widget.number,
                            titleFirst: selectedOptionIndex == 0
                                ? "Правильное решение — "
                                : "Неправильное решение — ",
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 48.w,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: selectedOptionIndex != null
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Text(
                        "Выбрать",
                        style: theme.bodyMedium?.copyWith(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
