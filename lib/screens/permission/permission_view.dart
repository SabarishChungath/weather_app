import 'package:climate_app/core/extensions/context_extensions.dart';
import 'package:climate_app/screens/permission/permission_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PermissionView extends StatefulWidget {
  const PermissionView({Key? key}) : super(key: key);

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LottieBuilder.asset(
                      "lib/assets/lottie/loc_lottie.json",
                      repeat: true,
                      width: ScreenUtil().setWidth(300),
                      height: ScreenUtil().setHeight(300),
                    ),
                  ],
                )),
            Flexible(
              flex: 2,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(18)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "App requires location permission, Give access by clicking the button below",
                      textAlign: TextAlign.center,
                      style: context.typo.titleMedium,
                    ),
                    ScreenUtil().setVerticalSpacing(40),
                    MaterialButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30),
                          vertical: ScreenUtil().setHeight(15)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: context.colorScheme.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      minWidth: ScreenUtil().setWidth(61),
                      height: ScreenUtil().setHeight(27),
                      textColor: context.colorScheme.tertiary,
                      onPressed: () {
                        context
                            .read<PermissionViewModel>()
                            .onPressProceed(context);
                      },
                      child: const Center(
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                              fontSize: 20,
                              height: 1,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(30)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
