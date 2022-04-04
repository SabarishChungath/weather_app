import 'package:climate_app/screens/home/home_view.dart';
import 'package:climate_app/screens/search/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    context.read<SearchViewModel>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
        child: Column(
          children: [
            ScreenUtil()
                .setVerticalSpacing(MediaQuery.of(context).padding.top + 20),
            RoundedSearchInput(
              textController: context.read<SearchViewModel>().controller,
              hintText: "Search a city name",
            ),
            Flexible(
              child: FutureBuilder(
                future: context.watch<SearchViewModel>().future,
                initialData: null,
                builder: (_, snapshot) {
                  Widget _child;
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        _child = Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        _child = SuccessWidget(
                            weather: context.watch<SearchViewModel>().weather!);
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedSearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const RoundedSearchInput(
      {required this.textController, required this.hintText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(70),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: textController,
        onSubmitted: (value) {
          context.read<SearchViewModel>().onSubmit();
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[500]!,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(45.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(45.0)),
          ),
        ),
      ),
    );
  }
}
