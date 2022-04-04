import 'package:climate_app/routes/router.dart';
import 'package:climate_app/routes/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () {
          return MaterialApp(
            title: 'Climate app',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: const Color(0XFF020207),
                colorScheme: const ColorScheme.light().copyWith(
                    primary: const Color(0XFF014EFD),
                    secondary: const Color(0XFF1F48A7),
                    tertiary: const Color(0XFFD3D8D5)),
                textTheme: const TextTheme(
                    titleLarge: TextStyle(
                        fontSize: 20,
                        color: Color(0XFFD3D8D5),
                        fontWeight: FontWeight.w600),
                    titleMedium: TextStyle(
                        fontSize: 18,
                        color: Color(0XFFD3D8D5),
                        fontWeight: FontWeight.w600),
                    titleSmall: TextStyle(
                        fontSize: 16,
                        color: Color(0XFFD3D8D5),
                        fontWeight: FontWeight.w600),
                    bodySmall: TextStyle(
                      fontSize: 14,
                      color: Color(0XFF9EA6A5),
                    ))),
            builder: (context, widget) {
              ScreenUtil.setContext(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            initialRoute: splashRoute,
            onGenerateRoute: generateRoute,
          );
        });
  }
}
