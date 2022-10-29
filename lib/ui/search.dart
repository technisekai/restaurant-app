import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/widget/widget_no_data.dart';
import 'package:restaurant_app/widget/widget_no_internet.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

class Search extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        /* for responsive */
        child: SingleChildScrollView(
          /* padding screen */
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              /* search input */
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFc80064),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Search",
                  fillColor: Colors.white,
                ),
              ),

              /* line space */
              const SizedBox(
                height: 16,
              ),

              /* content */
              SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                /* if has data input */
                child: _controller.text.isNotEmpty
                    ? ChangeNotifierProvider<SearchProvider>(
                        create: (context) => SearchProvider(
                          apiService: ApiServices(),
                          key: _controller.text,
                        ),
                        child: Consumer<SearchProvider>(
                          builder: (context, state, _) {
                            /* load data */
                            if (state.state == ResultState.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            /* has data */
                            else if (state.state == ResultState.hasData) {
                              /* found data */
                              if (state.result.founded != 0) {
                                return ListView.builder(
                                  itemCount: state.result.founded,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CardRestaurant(
                                        state.result.restaurants[index]);
                                  },
                                );
                              }
                              /* not found data */
                              else {
                                return const NoData();
                              }
                            }
                            /* no data */
                            else if (state.state == ResultState.noData) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            }
                            /* error */
                            else if (state.state == ResultState.error) {
                              return const Center(
                                child: Material(
                                  child: NoInternet(),
                                ),
                              );
                            } else {
                              return const Center(
                                child: Material(
                                  child: SizedBox(),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }

  /* for controller widget */
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
