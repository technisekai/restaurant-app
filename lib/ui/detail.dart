import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/widget/widget_no_internet.dart';
import 'package:restaurant_app/provider/detail_provider.dart';

class Detail extends StatelessWidget {
  const Detail(this.idRestaurant, {Key? key}) : super(key: key);
  final String idRestaurant;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (context) => DetailProvider(
        apiService: ApiServices(),
        idRestaurant: idRestaurant,
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Consumer<DetailProvider>(
                builder: (context, state, _) {
                  /* data is load */
                  if (state.state == ResultState.loading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  /* has data */
                  else if (state.state == ResultState.hasData) {
                    return Column(
                      children: [
                        /* image of restaurant */
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: Image(
                            image: NetworkImage(
                              'https://restaurant-api.dicoding.dev/images/medium/${state.result.restaurant.pictureId}',
                            ),
                          ),
                        ),

                        /* line spacing */
                        const SizedBox(height: 10),

                        /* name of restaurant */
                        Text(
                          state.result.restaurant.name,
                          style: const TextStyle(
                            color: Color(0xFFc80064),
                            fontFamily: 'DM Sans',
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        /* line spacing */
                        const SizedBox(height: 6),

                        /* location */
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              state.result.restaurant.address,
                              style: const TextStyle(
                                  color: Color(0xFF6b7280),
                                  fontFamily: 'Open Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),

                            /* line space */
                            const SizedBox(
                              width: 12,
                            ),

                            /* rating */
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 18,
                            ),

                            /* line space */
                            const SizedBox(width: 6),

                            /* rating */
                            Text(
                              state.result.restaurant.rating.toString(),
                              style: const TextStyle(
                                  color: Color(0xFF6b7280),
                                  fontFamily: 'Open Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        /* line spacing */
                        const SizedBox(height: 36),

                        /* description */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Description',
                              style: TextStyle(
                                  color: Color(0xFFc80064),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),

                            /* line spacing */
                            const SizedBox(height: 8),

                            /* description */
                            Text(
                              state.result.restaurant.description,
                              style: const TextStyle(
                                color: Color(0xFF6b7280),
                                fontFamily: 'Open Sans',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        /* line spacing */
                        const SizedBox(height: 16),

                        /* foods */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Foods',
                              style: TextStyle(
                                  color: Color(0xFFc80064),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),

                            /* line spacing */
                            const SizedBox(height: 8),

                            /* foods list */
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.result.restaurant.menus.foods.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Column(
                                      children: [
                                        /* thumbnail */
                                        Container(
                                          height: 130,
                                          width: 130,
                                          padding: const EdgeInsets.all(10),
                                          /* rounded thumbnail */
                                          child: ClipRRect(
                                            child: Image.network(
                                              'https://icones.pro/wp-content/uploads/2021/04/icone-de-nourriture-hamburger-gris.png',
                                              width: 60,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            '${state.result.restaurant.menus.foods[index].name}',
                                            style: const TextStyle(
                                              color: Color(0xFF6b7280),
                                              fontFamily: 'Open Sans',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        /* line spacing */
                        const SizedBox(height: 16),

                        /* drinks */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Drinks',
                              style: TextStyle(
                                  color: Color(0xFFc80064),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),

                            /* line spacing */
                            const SizedBox(height: 8),

                            /* drink list */
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.result.restaurant.menus.drinks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Column(
                                      children: [
                                        /* thumbnail */
                                        Container(
                                          height: 130,
                                          width: 130,
                                          padding: const EdgeInsets.all(10),
                                          /* rounded thumbnail */
                                          child: ClipRRect(
                                            child: Image.network(
                                              'https://icones.pro/wp-content/uploads/2021/04/icone-de-nourriture-hamburger-gris.png',
                                              width: 60,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            '${state.result.restaurant.menus.drinks[index].name}',
                                            style: const TextStyle(
                                              color: Color(0xFF6b7280),
                                              fontFamily: 'Open Sans',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
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
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: Material(
                          child: NoInternet(),
                        ),
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
          ),
        ),
      ),
    );
  }
}
