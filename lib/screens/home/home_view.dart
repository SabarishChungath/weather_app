import 'package:climate_app/core/extensions/context_extensions.dart';
import 'package:climate_app/core/models/weather.dart';
import 'package:climate_app/routes/routing_constants.dart';
import 'package:climate_app/screens/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeViewModel>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
        child: Column(
          children: [
            ScreenUtil()
                .setVerticalSpacing(MediaQuery.of(context).padding.top + 20),
            searchButton(context),
            Flexible(
              child: FutureBuilder(
                  future: context.watch<HomeViewModel>().future,
                  builder: (_, snapshot) {
                    Widget _child;
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          _child = const Center(
                            child: Text("Something went wrong!"),
                          );
                        } else {
                          _child = SuccessWidget(
                              weather: context.watch<HomeViewModel>().weather!);
                        }
                        break;

                      case ConnectionState.waiting:
                        _child = Center(
                          child: SizedBox.fromSize(
                              size: Size(ScreenUtil().setWidth(40),
                                  ScreenUtil().setHeight(40)),
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )),
                        );
                        break;

                      default:
                        _child =
                            const Center(child: Text("Something went wrong"));
                        break;
                    }

                    return AnimatedSwitcher(
                      switchInCurve: Curves.easeInBack,
                      switchOutCurve: Curves.easeOut,
                      duration: const Duration(milliseconds: 500),
                      child: _child,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  searchButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, searchRoute);
      },
      child: Container(
        height: ScreenUtil().setHeight(45),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScreenUtil().setHorizontalSpacing(20),
            Icon(Icons.near_me, color: context.colorScheme.tertiary),
            ScreenUtil().setHorizontalSpacing(20),
            Text("Search by city name . . . . .",
                style: context.typo.titleSmall)
          ],
        ),
      ),
    );
  }
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({Key? key, required this.weather}) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.place, color: Colors.grey),
              ScreenUtil().setHorizontalSpacing(10),
              Text(
                weather.timezone ?? "",
                style: context.typo.titleSmall,
              )
            ],
          ),
          ScreenUtil().setVerticalSpacing(20),
          Center(
            child: LottieBuilder.asset(
              weather.current!.lottieAsset,
              width: ScreenUtil().setWidth(200),
              height: ScreenUtil().setHeight(100),
              fit: BoxFit.fitWidth,
            ),
          ),
          ScreenUtil().setVerticalSpacing(60),
          Text(weather.current!.temperature.toString() + "°c",
              style: TextStyle(
                fontSize: 50,
                color: context.colorScheme.tertiary,
                fontWeight: FontWeight.w600,
              )),
          ScreenUtil().setVerticalSpacing(40),
          HourlyForecast(weather: weather),
          ScreenUtil().setVerticalSpacing(40),
          WeeklyForecast(weather: weather)
        ],
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(60),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: weather.hourly!.length.clamp(0, 5),
          separatorBuilder: (_, __) =>
              SizedBox(width: ScreenUtil().setWidth(20)),
          itemBuilder: (_, index) {
            var item = weather.hourly![index];
            return SizedBox(
              height: ScreenUtil().setHeight(50),
              width: ScreenUtil().setWidth(60),
              child: Column(
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(40),
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Text(
                    item.time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class WeeklyForecast extends StatelessWidget {
  const WeeklyForecast({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(60),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: weather.hourly!.length.clamp(0, 5),
          separatorBuilder: (_, __) =>
              SizedBox(width: ScreenUtil().setWidth(20)),
          itemBuilder: (_, index) {
            var item = weather.daily![index];
            return SizedBox(
              height: ScreenUtil().setHeight(50),
              width: ScreenUtil().setWidth(80),
              child: Column(
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(40),
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Text(
                    item.time,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
