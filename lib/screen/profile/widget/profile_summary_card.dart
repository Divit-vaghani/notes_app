import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/user_model/user_model.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/utils/shimmer/shimmer.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key, required this.onEdit});

  final Future<void> Function(UserModel model) onEdit;

  @override
  State<ProfileInformation> createState() => ProfileInformationState();
}

class ProfileInformationState extends State<ProfileInformation> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<AuthService>().getUserData(),
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
          return ProfileSummaryCard(
            userModel: snapshot.data as UserModel,
            onEdit: () async {
              if (snapshot.data != null) {
                await widget.onEdit(snapshot.data as UserModel);
                update();
              }
            },
          );
        }
        return const ProfileSummaryCardShimmer();
      },
    );
  }
}

class ProfileSummaryCard extends StatelessWidget {
  final VoidCallback? onEdit;
  final UserModel userModel;

  const ProfileSummaryCard({
    required this.userModel,
    this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FAFF), Color(0xFFE1E9F7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userModel.fullName, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 2.h),
                  if (userModel.mobile.isNotEmpty) Text(userModel.mobile, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  SizedBox(height: 2.h),
                  if (userModel.accountCreation.isNotEmpty) Text('Member since: ${userModel.accountCreation}', style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                ],
              ),
              InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(30.r),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: const Icon(Icons.edit, color: Colors.black54, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileSummaryCardShimmer extends StatelessWidget {
  const ProfileSummaryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FAFF), Color(0xFFE1E9F7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    shimmerBox(width: 120.w, height: 20.h),
                    SizedBox(height: 10.h),
                    shimmerBox(width: 80.w, height: 15.h),
                    SizedBox(height: 10.h),
                    shimmerBox(width: 100.w, height: 15.h),
                  ],
                ),
                // Edit Icon
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: shimmerBox(width: 20.w, height: 20.w, shape: BoxShape.circle),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget shimmerBox({
    required double width,
    required double height,
    double borderRadius = 8,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(borderRadius) : null,
      ),
    );
  }
}
