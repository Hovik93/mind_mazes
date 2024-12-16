import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> detailData;
  final List<Map<String, dynamic>> allData;

  const DetailScreen({
    super.key,
    required this.detailData,
    required this.allData,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    final randomItem = _getRandomItem();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Expanded(
                        child: Text(
                          detailData['title'] ?? '',
                          style: theme.bodySmall?.copyWith(fontSize: 17.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.w),
              _buildSection(
                title: detailData['title'] ?? '',
                content: detailData['description'] ?? '',
                theme: theme,
                highlight: true,
              ),
              if (detailData['example'] != null)
                _buildSection(
                  title: "Пример:",
                  content: detailData['example'],
                  theme: theme,
                ),
              if (detailData['howToAvoid'] != null)
                _buildAvoidSection(
                  intro: detailData['howToAvoidTitle'] ?? '',
                  points: detailData['howToAvoid'],
                  theme: theme,
                ),
              SizedBox(height: 20.w),
              if (randomItem != null)
                _buildSeeAlsoSection(context, randomItem, theme),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic>? _getRandomItem() {
    final filteredData =
        allData.where((item) => item['title'] != detailData['title']).toList();

    if (filteredData.isEmpty) return null;

    final randomIndex = Random().nextInt(filteredData.length);
    return filteredData[randomIndex];
  }

  Widget _buildAvoidSection({
    required String intro,
    required List<String> points,
    required TextTheme theme,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.lime.withOpacity(0.1),
        border: Border.all(
          width: 1,
          color: AppColors.lime,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Как избежать:",
            style: theme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.grey2,
            ),
          ),
          if (intro != '')
            Text(
              intro,
              style: theme.bodyMedium?.copyWith(
                color: AppColors.black,
                fontSize: 14.sp,
              ),
            ),
          Divider(
            thickness: 1,
            color: AppColors.lime,
            height: 20.w,
          ),
          Text(
            "Чтобы избежать ${detailData['title']}, важно:",
            style: theme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.grey2,
            ),
          ),
          SizedBox(height: 8.w),
          _buildBulletPoints(points: points, theme: theme),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required TextTheme theme,
    bool highlight = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: highlight ? AppColors.lime : AppColors.lime.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: AppColors.lime)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.titleSmall?.copyWith(
              fontSize: highlight ? 20.sp : 14.sp,
              color: highlight ? AppColors.black : AppColors.grey1,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            highlight ? "- ${content}" : content,
            style: theme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoints({required List<String> points, TextTheme? theme}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map((point) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "• ",
                style: theme?.bodyMedium?.copyWith(fontSize: 14.sp),
              ),
              Expanded(
                child: Text(
                  point,
                  style: theme?.bodyMedium?.copyWith(fontSize: 14.sp),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSeeAlsoSection(
      BuildContext context, Map<String, dynamic> randomItem, TextTheme theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Смотрите также",
            style: theme.titleSmall,
          ),
          SizedBox(height: 10.w),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    detailData: randomItem,
                    allData: allData,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lime),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    randomItem['title'] ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                        color: AppColors.lime, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.black,
                      size: 16.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
