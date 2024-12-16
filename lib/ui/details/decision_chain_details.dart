import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/ui/details/decision_chain_result_screen.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

class DecisionChainDetails extends StatefulWidget {
  final Map<String, dynamic> chainData;

  const DecisionChainDetails({super.key, required this.chainData});

  @override
  State<DecisionChainDetails> createState() => _DecisionChainDetailsState();
}

class _DecisionChainDetailsState extends State<DecisionChainDetails> {
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    final options = widget.chainData['options'];

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
                      child: Icon(Icons.arrow_back_ios_new,
                          color: AppColors.grey2),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Цепочка решений ${widget.chainData['number']}",
                      style: theme.bodySmall?.copyWith(
                        fontSize: 17.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Этап 1",
                    style: theme.titleSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      widget.chainData['title'],
                      style: theme.titleSmall
                          ?.copyWith(color: AppColors.black, fontSize: 24.sp),
                    ),
                  ),
                  Text(
                    widget.chainData['initialSituation'],
                    style: theme.titleSmall?.copyWith(color: AppColors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.primary,
                  )
                ],
              ),
            ),
            SizedBox(height: 20.w),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOptionIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.w),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        border: Border(
                            left:
                                BorderSide(color: AppColors.primary, width: 1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                option['number'],
                                style:
                                    theme.bodyMedium?.copyWith(fontSize: 16.sp),
                              ),
                              Image.asset(!(selectedOptionIndex == index)
                                  ? AppImages.arrowRightDown
                                  : AppImages.arrowRightUp),
                            ],
                          ),
                          if (selectedOptionIndex == index) ...[
                            SizedBox(height: 10.w),
                            Text(
                              option['option'],
                              style: theme.bodySmall,
                            ),
                          ]
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
                  child: Text(
                    "Выберите действие:",
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.grey2,
                    ),
                  ),
                ),
                SizedBox(height: 10.w),
                selectedOptionIndex != null
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: AppColors.primary, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Выбор ${String.fromCharCode(65 + selectedOptionIndex!)} — Эффект привязанности",
                              style: theme.bodySmall,
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              options[selectedOptionIndex!]['branch']['result'],
                              style:
                                  theme.titleSmall?.copyWith(fontSize: 12.sp),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
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
                      Container(
                        width: 5.w,
                        height: 5.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.grey1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                if (selectedOptionIndex != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DecisionChainResultScreen(
                        number: widget.chainData['number'],
                        selectedItem:
                            "Выбор ${String.fromCharCode(65 + selectedOptionIndex!)} — Эффект привязанности",
                        selectData: options[selectedOptionIndex!],
                        fullData: widget.chainData,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                height: 48.w,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: selectedOptionIndex == null
                      ? AppColors.primary.withOpacity(0.3)
                      : AppColors.primary,
                ),
                child: Center(
                  child: Text(
                    "Выбрать",
                    style: theme.bodySmall?.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
