import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewClientCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Client Create",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 207.h),
            _buildInputField(
              label: 'Name',
              icon: Icons.person,
              isPassword: false,
            ),
            SizedBox(height: 16.h),
            _buildInputField(
              label: 'E mail',
              icon: Icons.email,
              isPassword: false,
            ),
            SizedBox(height: 16.h),
            _buildInputField(
              label: 'Password',
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                // Handle button action
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'Create Client',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required bool isPassword,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey[700],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                hintStyle: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          if (isPassword)
            Icon(
              Icons.visibility_off,
              color: Colors.grey[700],
            ),
        ],
      ),
    );
  }
}
