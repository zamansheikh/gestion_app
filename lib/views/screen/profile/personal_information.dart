import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Information",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  /// Display the image (default or selected)
                  ClipOval(
                    child: _selectedImage == null
                        ? Image.asset(
                      AppImages.personalPicImage,
                      height: 128.h,
                      width: 128.w,
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      _selectedImage!,
                      height: 128.h,
                      width: 128.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  /// Camera Icon for picking image
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Take a Photo'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Choose from Gallery'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      padding: EdgeInsets.all(6.r),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// Name
              _buildInfoField(
                label: 'Name',
                value: 'Jane Cooper',
              ),
              SizedBox(height: 12.h),

              /// Email
              _buildInfoField(
                label: 'Email',
                value: 'lawson@example.com Engineer',
              ),
              SizedBox(height: 12.h),

              /// Phone Number
              _buildInfoField(
                label: 'Phone Number',
                value: '+76348344',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper to Build Info Fields
  Widget _buildInfoField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.shadowColor,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.backcolorsE6E6E6,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.subTextColor,
              width: 1,
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }
}
