import 'package:climate_app/screens/search/search_view.dart';
import 'package:climate_app/screens/search/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(),
      lazy: true,
      child: const SearchView(),
    );
  }
}
