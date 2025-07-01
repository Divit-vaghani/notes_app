import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/screen/profile/widget/profile_summary_card.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/widget/bsr_bottom_sheet.dart';
import 'package:notes_app/widget/section_list.dart';

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
