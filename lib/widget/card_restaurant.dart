import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

class CardRestaurant extends StatelessWidget {
  const CardRestaurant(this.restaurant, {Key? key}) : super(key: key);
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return InkWell(
              onTap: () {
                /* to detail page */
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: restaurant.id,
                );
              },
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      /* image */
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Image(
                          image: NetworkImage(
                            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                      /* whitespace */
                      const SizedBox(
                        width: 16,
                      ),
                      /* restaurant desc */

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /* name restaurant */
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 250,
                            child: Text(
                              restaurant.name,
                              style: const TextStyle(
                                color: Color(0xFFc80064),
                                fontFamily: 'DM Sans',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          /* spacing */
                          const SizedBox(height: 6),

                          /* locaction */
                          Row(
                            children: [
                              /* location icon */
                              const Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  restaurant.city,
                                  style: const TextStyle(
                                      color: Color(0xFF6b7280),
                                      fontFamily: 'Open Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          /* spacing */
                          const SizedBox(height: 6),

                          /* rating */
                          Row(
                            children: <Widget>[
                              /* rating icon */
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  restaurant.rating.toString(),
                                  style: const TextStyle(
                                      color: Color(0xFF6b7280),
                                      fontFamily: 'Open Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      /* if true, button action if tap will remove restaurant from favorite */
                      isFavorite
                          ? IconButton(
                              icon: const Icon(Icons.favorite),
                              color: const Color(0xFFc80064),
                              onPressed: () =>
                                  provider.removeFavorite(restaurant.id),
                            )
                          /* if false, button action if tap will add restaurant from favorite */
                          : IconButton(
                              icon: const Icon(Icons.favorite),
                              color: Colors.grey,
                              onPressed: () => provider.addFavorite(restaurant),
                            ),
                    ],
                  ),
                  /* line spacing */
                  const SizedBox(height: 14),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
