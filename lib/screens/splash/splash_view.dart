import 'package:climate_app/core/extensions/context_extensions.dart';
import 'package:climate_app/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<SplashViewModel>().nextPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "lib/assets/lottie/splash_lottie.json",
              width: ScreenUtil().setWidth(250),
              height: ScreenUtil().setHeight(200),
              fit: BoxFit.fitWidth,
            ),
            ScreenUtil().setVerticalSpacing(20),
            Text(
              "CLIMA",
              style: context.typo.titleLarge!.copyWith(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
