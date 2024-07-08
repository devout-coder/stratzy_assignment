import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stratzy/features/search/models/search_item.dart';

List<SearchItem> searchItems = [
  SearchItem(
      1, "Trending Outliers", "Quantitative Strategy", "Strategies", true),
  SearchItem(2, "Booming Financial", "Thematic Strategy", "Strategies", false),
  SearchItem(3, "Value Picker", "Fundamental Strategy", "Ideas", false),
  SearchItem(4, "Strong TMT", "Long term Idea", "Ideas", false),
  SearchItem(5, "Vehicle Cell", "Short term Idea", "Ideas", false),
  SearchItem(
      6, "Trending Outliers", "Quantitative Strategy", "Strategies", false),
  SearchItem(
      7, "Trending Outliers", "Quantitative Strategy", "Strategies", false),
  SearchItem(
      8, "Trending Outliers", "Quantitative Strategy", "Strategies", false),
  SearchItem(
      9, "Trending Outliers", "Quantitative Strategy", "Strategies", false),
  SearchItem(
      10, "Trending Outliers", "Quantitative Strategy", "Strategies", false),
];

class ItemsCubit extends Cubit<List<SearchItem>> {
  ItemsCubit() : super(searchItems);
  List<SearchItem> filterSearchItems(String category, String query) {
    List<SearchItem> filteredItems = state.where((SearchItem searchItem) {
      if (category == "All") {
        return searchItem.name.toLowerCase().contains(query.toLowerCase());
      }

      return searchItem.name.toLowerCase().contains(query.toLowerCase()) &&
          searchItem.categoryLabel == category;
    }).toList();
    return filteredItems;
  }
}
