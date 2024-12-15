// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

// ignore: must_be_immutable
class DecisionChainNextChoiceScreen extends StatefulWidget {
  final Map<String, dynamic> selectedData;
  String? titleFirst;
  String? number;

  DecisionChainNextChoiceScreen(
      {super.key, required this.selectedData, this.number, this.titleFirst});

  @override
  State<DecisionChainNextChoiceScreen> createState() =>
      _DecisionChainNextChoiceScreenState();
}

class _DecisionChainNextChoiceScreenState
    extends State<DecisionChainNextChoiceScreen> {
  int? expandedChoiceIndex;

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final nextSteps = widget.selectedData['nextStep'];

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
              child: Text(
                "Действие:",
                style: theme.titleSmall,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: AppColors.primary, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.titleFirst} ${widget.selectedData['choice']}",
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.selectedData['result'],
                    style: theme.titleSmall?.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 16.w),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.primary,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: AppColors.primary,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Результат:",
                    style: theme.titleSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "В следующий раз вы изучаете бизнес-стратегии более тщательно.",
                    style: theme.titleSmall?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: nextSteps.length,
                itemBuilder: (context, index) {
                  final step = nextSteps[index];
                  final isSelected = expandedChoiceIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedChoiceIndex =
                            expandedChoiceIndex == index ? null : index;
                      });
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
                      decoration: BoxDecoration(
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.w, horizontal: 12.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Выбор ${index + 1}",
                                  style: theme.bodyMedium?.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.grey1.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Image.asset(isSelected
                                        ? AppImages.arrowRightDown
                                        : AppImages.arrowRightUp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 12.w, right: 12.w, bottom: 12.h),
                              child: Text(
                                step,
                                style: theme.bodySmall,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text("Выберите действие:", style: theme.titleSmall),
            ),
            if (expandedChoiceIndex != null) SizedBox(height: 10.w),
            if (expandedChoiceIndex != null)
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
                    "Выбор ${(expandedChoiceIndex ?? 0) + 1}",
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            if (expandedChoiceIndex != null)
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
                if (expandedChoiceIndex != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Container(
                height: 48.w,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: expandedChoiceIndex != null
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
          ],
        ),
      ),
    );
  }
}
