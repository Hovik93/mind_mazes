// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/ui/details/decision_chain_next_step.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

// ignore: must_be_immutable
class DecisionChainResultScreen extends StatelessWidget {
  String? number;
  String? selectedItem;
  final Map<String, dynamic> selectData;
  final Map<String, dynamic> fullData;

  DecisionChainResultScreen({
    super.key,
    this.number,
    this.selectedItem,
    required this.fullData,
    required this.selectData,
  });

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
                      "Цепочка решений ${number ?? ''}",
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
                    selectedItem ?? '',
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    selectData['branch']['result'],
                    style: theme.titleSmall?.copyWith(
                      fontSize: 12.sp,
                    ),
                  )
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
                  Text(
                    selectData['branch']['nextStep'],
                    style: theme.titleSmall?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DecisionChainNextStepScreen(
                        number: number,
                        nextStepData: selectData['branch'],
                        fullData: fullData),
                  ),
                );
              },
              child: Container(
                height: 48.w,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.primary,
                ),
                child: Center(
                  child: Text(
                    "Следующий этап",
                    style: theme.bodySmall?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.white,
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
