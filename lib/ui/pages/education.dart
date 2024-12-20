import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/ui/details/detail_screen_education.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

class EducationScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const EducationScreen({super.key, required this.data});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  List<Map<String, dynamic>> filteredList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    filteredList = widget.data;
    super.initState();
  }

  void _filterCognitiveBiases(String query) {
    setState(() {
      filteredList = widget.data
          .where((bias) =>
              bias['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: TapRegion(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
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
                    child:
                        Icon(Icons.arrow_back_ios_new, color: AppColors.grey2),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Обучение',
                    style: theme.bodySmall?.copyWith(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.w),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.lime.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Когнитивные искажения и парадоксы",
                          style: theme.titleSmall?.copyWith(
                            color: AppColors.black,
                            fontSize: 17.sp,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "— это важная часть нашего мышления, которую мы часто не замечаем. "
                            "Изучение этих ловушек помогает научиться принимать более обоснованные решения, анализировать ситуации и избегать ошибок в будущем.",
                            style: theme.titleSmall),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterCognitiveBiases,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          AppImages.searchIcon,
                          color: AppColors.lime,
                        ),
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
                          borderSide: BorderSide(color: AppColors.lime),
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Когнитивные искажения",
                          style: theme.titleSmall?.copyWith(
                              fontSize: 12.sp, color: AppColors.black),
                        ),
                        Image.asset(AppImages.refreshCircle)
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredList.length,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return Container(
                        height: 56.w,
                        margin: EdgeInsets.only(bottom: 12.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.lime),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                item['title'],
                                overflow: TextOverflow.ellipsis,
                                style: theme.titleSmall?.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      detailData: item,
                                      allData: widget.data,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                  color: AppColors.lime,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
