// OnbordingViewOne with page indicator
import 'package:edgewaterhealth/Resources/AppAssets/images_assets.dart';
import 'package:edgewaterhealth/Resources/AppComponents/app_onbording_button.dart';
import 'package:edgewaterhealth/Resources/AppComponents/page_indigator.dart';
import 'package:edgewaterhealth/Resources/AppRoutes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnbordingViewOne extends StatelessWidget {
  const OnbordingViewOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // Top left circles
          Positioned(
            top: -120,
            left: -120,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF7BC4D4).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -130,
            left: -100,
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                color: const Color(0xFF7BC4D4).withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Bottom right circles
          Positioned(
            bottom: -120,
            right: -120,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF7BC4D4).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -130,
            right: -100,
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                color: const Color(0xFF7BC4D4).withOpacity(0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Bottom gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xFF7BC4D4),
                      const Color(0xFF7BC4D4).withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.onbordinOne),
                const SizedBox(height: 50),

                const Text("Impact Starts Here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text("Small steps create big impact. Your submissions turn into insights that improve care for everyone.", style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
                ),
                const SizedBox(height: 40),

                OnbordingBtn(
                  isForward: true,
                  onTap: () {
                    Get.toNamed(RouteName.onbordingViewTwo);
                  },
                ),

                SizedBox(height: 20,),

                PageIndicator(
                  currentPage: 0,
                  totalPages: 3,
                ),
              ],
            ),
          ),

          Positioned(
            top: 60,
            right: 20,

            child: TextButton(onPressed: (){
              Get.toNamed(RouteName.onbordingViewThree);
            }, child: Text("Skip",style: TextStyle(fontSize: 20),)),
          )

        ],
      ),
    );
  }
}
