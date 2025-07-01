import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/screen/profile/widget/profile_summary_card.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/widget/bsr_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            ProfileInformation(
              onEdit: (model) async => await router.push('/edit-profile', extra: model),
            ),
            SizedBox(height: 20.h),
            SectionList(
              items: const ["Delete Account", "Logout"],
              textColor: Colors.red,
              onTap: (p0) {
                if (p0 == "Logout") {
                  logOutSheet(
                    context: context,
                    onLogOut: () async => await getIt<AuthService>().signOut(),
                  );
                } else if (p0 == "Delete Account") {
                  deleteAccountSheet(
                    context: context,
                    onDelete: () async => await getIt<AuthService>().deleteAccount(),
                  );
                }
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String label;
  final String value;

  const StatItem({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
      ],
    );
  }
}

class SectionList extends StatelessWidget {
  final List<String> items;
  final Color textColor;
  final void Function(String)? onTap;

  const SectionList({
    required this.items,
    this.textColor = Colors.black,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FAFF), Color(0xFFE1E9F7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: items.map((item) {
          final isLast = item == items.last;
          return Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTap?.call(item),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward, size: 18.sp, color: Colors.black87),
                      ],
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Divider(
                    color: Colors.grey.shade300,
                    height: 1.h,
                    thickness: 0.6,
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
