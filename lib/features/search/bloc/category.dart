import 'package:flutter_bloc/flutter_bloc.dart';

List<String> categories = ["All", "Ideas", "Strategies", "Stocks"];

class CategoriesCubit extends Cubit<List<String>> {
  CategoriesCubit() : super(categories);
}
