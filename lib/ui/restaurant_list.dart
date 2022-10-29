import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';
import 'package:restaurant_app/widget/widget_no_data.dart';
import 'package:restaurant_app/widget/widget_no_internet.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantList createState() => _RestaurantList();
}

class _RestaurantList extends State<RestaurantList> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* title and desc */
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFc80064),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      /* widget align */
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        /* title */
                        Text(
                          'Restaurant',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'DM Sans',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /* desc */
                        Text(
                          'Recommendation restaurants special for you',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Dancing Script',
                              fontSize: 16,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.favorite),
                          color: const Color(0xFFc80064),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/favorite',
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          color: const Color(0xFFc80064),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/search',
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.settings),
                          color: const Color(0xFFc80064),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/setting',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /* whitespace */
              const SizedBox(height: 30),
              /* navigation bar */

              /* list restaurant */
              SizedBox(
                height: MediaQuery.of(context).size.height - 240,
                child: Consumer<RestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.hasData) {
                      return ListView.builder(
                        itemCount: state.result.restaurants.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardRestaurant(
                              state.result.restaurants[index]);
                        },
                      );
                    }
                    /* no data */
                    else if (state.state == ResultState.noData) {
                      return const Center(
                        child: Material(
                          child: NoData(),
                        ),
                      );
                      /* error */
                    } else if (state.state == ResultState.error) {
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
              ),
            ],
          ),
        ),
      ),
      /* to search page */
    );
  }
}
