import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:stratzy/features/search/bloc/category.dart';
import 'package:stratzy/features/search/bloc/item.dart';
import 'package:stratzy/features/search/models/search_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<CategoriesCubit, List<String>>(
        builder: (context, categories) {
      return BlocBuilder<ItemsCubit, List<SearchItem>>(
        builder: (context, items) {
          return Scaffold(
            backgroundColor: Color(0xff211A2A),
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xff2A2136),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Container(
                          width: screenWidth * 0.65,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 0,
                                minHeight: 0,
                              ),
                              prefixIcon: GradientIcon(
                                icon: Icons.search,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff01C36D),
                                    Color(0xff01C16C),
                                    Color(0xff018A4D)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.zero,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.zero,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.zero,
                              ),
                              hintText: "Search by Stock Name, Patterns...",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xffEBECEC),
                              ),
                            ),
                            onChanged: (String newQuery) {
                              setState(() {
                                searchQuery = newQuery;
                              });
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, size: 24),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            searchQuery = "";
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(width: 12),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 10,
                                  ),
                                  height: 40,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: selectedCategory == index
                                        ? LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xff393046),
                                              Color(0xff2D2537),
                                            ],
                                          )
                                        : LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.transparent
                                            ],
                                          ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    border: Border.all(
                                      color: selectedCategory == index
                                          ? Color(0xff01C36D)
                                          : Color(0xffA3A5A7),
                                    ),
                                  ),
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: selectedCategory == index
                                          ? Color(0xff01C36D)
                                          : Color(0xffA3A5A7),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Builder(builder: (context) {
                      List<SearchItem> filteredItems = context
                          .read<ItemsCubit>()
                          .filterSearchItems(
                              categories[selectedCategory], searchQuery);
                      return ListView.separated(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            color: Color(0xff2A2136),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Color(0xffD9D9D9),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(9))),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredItems[index].name,
                                      style: TextStyle(
                                        color: Color(0xffEBECEC),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      filteredItems[index].category,
                                      style: TextStyle(
                                        color: Color(0xffEBECEC),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                filteredItems[index].isBookMarked
                                    ? GradientIcon(
                                        offset: Offset(0, 0),
                                        icon: Icons.bookmark,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff01C36D),
                                            Color(0xff01C16C),
                                            Color(0xff018A4D)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      )
                                    : Icon(
                                        Icons.bookmark_border_outlined,
                                        color: Color(0xffEBECEC),
                                      )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 20,
                            color: Color(0xff211A2A),
                          );
                        },
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
