import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestion_app/utils/app_colors.dart';
import '../../../../utils/app_dimensions.dart';
import '../../base/custom_text.dart';



class TermsServicesScreen extends StatelessWidget {
  TermsServicesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      //===========================================> AppBar Section <=============================================
      appBar: AppBar(
        title: CustomText(
          text: 'Terms of Services',
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge, vertical: 16.h),
          child:Column(
            children: [
              CustomText(
                text: 'Lorem ipsum dolor sit amet consectetur. Enim massa aenean ac odio leo habitasse tortor tempor. Ut id urna odio dui leo congue. Ultrices pharetra ornare nam faucibus. Integer id varius consectetur non.',
                fontsize: 14.sp,
                fontWeight: FontWeight.w400,
                maxline: 10,
                textAlign: TextAlign.start,
                color: AppColors.shadowColor,
              ),
              SizedBox(height: 37.h),
              CustomText(
                text: 'Lorem ipsum dolor sit amet consectetur. Enim massa aenean ac odio leo habitasse tortor tempor. Ut id urna odio dui leo congue. Ultrices pharetra ornare nam faucibus. Integer id varius consectetur non.',
                fontsize: 14.sp,
                fontWeight: FontWeight.w400,
                maxline: 10,
                textAlign: TextAlign.start,
                color: AppColors.shadowColor,
              ),
              SizedBox(height: 47.h),
              CustomText(
                text: 'Lorem ipsum dolor sit amet consectetur. Enim massa aenean ac odio leo habitasse tortor tempor. Ut id urna odio dui leo congue. Ultrices pharetra ornare nam faucibus. Integer id varius consectetur non.',
                fontsize: 14.sp,
                fontWeight: FontWeight.w400,
                maxline: 10,
                textAlign: TextAlign.start,
                color: AppColors.shadowColor,
              ),
            ],
          )

      ),

    );
  }
}


























