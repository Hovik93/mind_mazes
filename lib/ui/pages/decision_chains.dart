import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/images.dart';
import 'package:mind_mazes/data/decision_chains_data.dart';
import 'package:mind_mazes/ui/details/decision_chain_details.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';

class DecisionChainsScreen extends StatefulWidget {
  const DecisionChainsScreen({
    super.key,
  });

  @override
  State<DecisionChainsScreen> createState() => _DecisionChainsScreenState();
}

class _DecisionChainsScreenState extends State<DecisionChainsScreen> {
  List<Map<String, dynamic>> filteredDecisionChains = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDecisionChains = decisionChains;
  }

  void _filterChains(String query) {
    setState(() {
      filteredDecisionChains = decisionChains
          .where((chain) =>
              chain["title"].toLowerCase().contains(query.toLowerCase()) ||
              chain["initialSituation"]
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              chain["number"]
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
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
        child: SafeArea(
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
                        'Цепочки решений',
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
                  onChanged: _filterChains,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset(
                      AppImages.searchIcon,
                      color: AppColors.primary,
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
                child: ListView.builder(
                  itemCount: filteredDecisionChains.length,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (context, index) {
                    final chain = filteredDecisionChains[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 16.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${chain['number']}",
                                      style: theme.bodyMedium?.copyWith(
                                        fontSize: 20.sp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Text(
                                      " ${chain['title']}",
                                      style: theme.bodyMedium?.copyWith(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.sp),
                                  child: Text(chain["initialSituation"],
                                      style: theme.bodySmall),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DecisionChainDetails(chainData: chain),
                                ),
                              );
                            },
                            child: Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
