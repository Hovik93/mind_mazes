import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mind_mazes/base/colors.dart';
import 'package:mind_mazes/base/constants.dart';
import 'package:mind_mazes/ui/widgets/buttom_border.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final InAppReview inAppReview = InAppReview.instance;

  _launchURL({required String urlLink}) async {
    final Uri url = Uri.parse(urlLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: body(theme: theme),
    );
  }

  Widget body({required TextTheme theme}) {
    return Column(
      children: [
        BottomBorderContainer(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, left: 30, bottom: 15),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new, color: AppColors.grey2),
                ),
                const SizedBox(width: 10),
                Text(
                  'Настройки',
                  style: theme.bodySmall?.copyWith(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _launchURL(urlLink: privacyPolicyUrl);
                },
                child: Container(
                  height: 56.w,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.greyLight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Политика конфиденциальности',
                        style: theme.bodySmall
                            ?.copyWith(color: AppColors.black, fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: AppColors.primary,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.w,
              ),
              InkWell(
                onTap: () {
                  _launchURL(urlLink: userAgreementUrl);
                },
                child: Container(
                  height: 56.w,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.greyLight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Пользовательское соглашение',
                        style: theme.bodySmall
                            ?.copyWith(color: AppColors.black, fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: AppColors.primary,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              Divider(
                color: AppColors.greyLight,
              ),
              SizedBox(
                height: 5.w,
              ),
              InkWell(
                onTap: () async {
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                },
                child: Container(
                  height: 56.w,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.greyLight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Оценить приложение',
                        style: theme.bodySmall
                            ?.copyWith(color: AppColors.black, fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: AppColors.primary,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
