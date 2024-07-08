import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stratzy/features/search/bloc/category.dart';
import 'package:stratzy/features/search/bloc/item.dart';
import 'package:stratzy/features/search/screens/search.dart';
import 'package:stratzy/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoriesCubit()),
        BlocProvider(create: (_) => ItemsCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData,
        home: SearchScreen(),
      ),
    );
  }
}
