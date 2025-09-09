import 'package:edgewaterhealth/Resources/AppAssets/images_assets.dart';
import 'package:edgewaterhealth/Resources/AppColor/app_colors.dart';
import 'package:edgewaterhealth/View/Splash_View/splash_services.dart' show SplashServices;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashServices _splashServices=SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashServices.isLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColor.backgroundColor,
      body: Stack(
        children: [
          // Top left circular background
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



          // Bottom right circular background
          Positioned(
            bottom: -120,
            right: -120,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF7BC4D4).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),    Positioned(
            bottom: -130,
            right: -100,
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                color: const Color(0xFF7BC4D4).withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               SvgPicture.asset(AppImages.splashScreen,height: 200,width: 100,),

                SizedBox(height: 30,),
                Lottie.asset("asstes/Morphing Particle Loader.json",height: 130),
              ],
            ),
          )
        ],
      ),
    );
  }
}