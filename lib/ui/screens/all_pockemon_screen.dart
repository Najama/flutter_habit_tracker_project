import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pockemon_app/data/models/pokemons.dart';
import 'package:flutter_pockemon_app/providers/pockemon_future_provider.dart';
import 'package:flutter_pockemon_app/ui/screens/favourite_pokemon_screen.dart';
import 'package:flutter_pockemon_app/ui/screens/pokemon_detail_screen.dart';
import 'package:flutter_pockemon_app/utils/extensions/buildcontext_extension.dart';
import 'package:flutter_pockemon_app/utils/helpers/pokemon_card.color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme_provider.dart';

class AllPockemonScreen extends ConsumerWidget {
  const AllPockemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemons>> pokemonList =
        ref.watch(pokemonFututeProvider);
        return Scaffold(
        appBar: AppBar(
          title:  Text(
            'Pokemon app',
            style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
          actions: [
            IconButton(
                onPressed: () {
                 context.go(FavouritePokemonScreen());
                },
                icon: const Icon(Icons.favorite)),
            IconButton(
                onPressed: () {
                  ref.read(themeModeProvider.notifier).setTheme();
                //    ref.read(themeModeProvider.notifier).state = theme == ThemeMode.light
                // ? ThemeMode.dark
                // : ThemeMode.light;
                  
                },
                icon: const Icon(Icons.lightbulb)),
          ],
        ),
        body: pokemonList.when(data: (data) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      context.go(PokemonDetailScreen(pokemon: data[index]));
                    },
                    child: Card(
                      color: Helpers.getPokemonCardColour(
                          pokemonType: data[index].typeofpokemon!.first),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            bottom: -10,
                            child: Image.asset(
                              'images/pokeball.png',
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              left: 10,
                              top: 20,
                              child: Text(
                                data[index].name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              )),
                          Positioned(
                              left: 10,
                              top: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data[index].typeofpokemon!.first,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                ),
                              )),
                          Positioned(
                            right: -10,
                            bottom: -10,
                            child: Hero(
                            
                              tag: data[index].id!,
                              child: CachedNetworkImage(
                                imageUrl: data[index].imageurl!,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        }, error: (err, stack) {
          return const Center(child: Text('No Pokemon found'));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
