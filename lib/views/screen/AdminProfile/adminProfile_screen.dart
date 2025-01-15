import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gestion_app/routes/routes.dart';
import 'package:gestion_app/views/screen/AdminProfile/adminBottom_navbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controllers/profile_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class AdminProfileScreen extends StatelessWidget {
  AdminProfileScreen({super.key});
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            _profileHeader(),
            SizedBox(height: 36.h),
            _profileOption(
              label: 'Personal Information',
              iconPath: 'assets/icons/personal.svg',
              onTap: () => controller.navigateTo(AppRoutes.personalInformation),
            ),
            _divider(),
            _profileOption(
              label: 'Settings',
              iconPath: 'assets/icons/setting.svg',
              onTap: () => controller.navigateTo(AppRoutes.settingsScreen),
            ),
            _divider(),
            _profileOption(
              label: 'Log Out',
              iconPath: 'assets/icons/logout.svg',
              onTap: controller.showLogoutDialog,
              isLogout: true,
            ),
            _divider(),
          ],
        ),
      ),
      bottomNavigationBar: AdminBottomMenu(0),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Divider(
        color: AppColors.greyColor.withOpacity(0.4),
        thickness: 1.1,
      ),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Obx(() {
              final image = controller.profileImage.value;
              return Container(
                width: 120.w,
                height: 120.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFB3F81),
                      Color(0xFFB749BB),
                      Color(0xFF8C4AEF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.r),
                  child: ClipOval(
                    child: image != null
                        ? Image.file(
                            image,
                            fit: BoxFit.cover,
                            width: 120.w,
                            height: 120.h,
                          )
                        : Image.asset(
                            AppImages.profilePicImage,
                            fit: BoxFit.cover,
                            width: 120.w,
                            height: 120.h,
                          ),
                  ),
                ),
              );
            }),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showImagePickerDialog(),
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.textColor,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18.w,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'Jane Cooper',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 16.h),
        // Buttons added below
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _actionButton(
              label: 'New Client Create',
              onTap: () {
                Get.toNamed(AppRoutes.newClientCreateScreen);

                print('New Client Create tapped');
              },
            ),
            SizedBox(width: 12.w),
            _actionButton(
              label: 'User List',
              onTap: () {
                Get.toNamed(AppRoutes.userListScreen);
                print('User List tapped');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionButton({required String label, required VoidCallback onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            label == 'New Client Create' ? Colors.black : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      ),
      child: Text(
        label,
        style: TextStyle(
          color:
              label == 'New Client Create' ? Colors.white : AppColors.textColor,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _profileOption({
    required String label,
    required String iconPath,
    VoidCallback? onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24.w,
                  color: isLogout ? AppColors.redColor : AppColors.textColor,
                ),
                SizedBox(width: 16.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: isLogout ? AppColors.redColor : AppColors.textColor,
                    fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (!isLogout)
              SvgPicture.asset(
                'assets/icons/chevron.svg',
                width: 8.w,
                color: AppColors.textColor,
              ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose an option',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _imagePickerOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Get.back(); // Close the bottom sheet
                    controller.pickImage(ImageSource.gallery);
                  },
                ),
                _imagePickerOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Get.back(); // Close the bottom sheet
                    controller.pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _imagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: AppColors.greyColor.withOpacity(0.2),
            child: Icon(
              icon,
              color: AppColors.textColor,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
