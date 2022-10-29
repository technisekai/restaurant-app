import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/widget/widget_no_data.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

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
              Container(
                width: double.infinity,
                height: 120,
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
                      'Favorite',
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
                      'Your favorite restaurants',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Dancing Script',
                          fontSize: 16,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              /* line space */
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                /* if has data input */
                child: ChangeNotifierProvider<DatabaseProvider>(
                  create: (context) =>
                      DatabaseProvider(databaseHelper: DatabaseHelper()),
                  child: Consumer<DatabaseProvider>(
                    builder: (context, provider, child) {
                      /* show favorite restaurant */
                      try {
                        if (provider.state == ResultState.hasData) {
                          return ListView.builder(
                            itemCount: provider.favorites.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardRestaurant(provider.favorites[index]);
                            },
                          );
                        } else {
                          return const Center(
                            child: NoData(),
                          );
                        }
                      } catch (e) {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
