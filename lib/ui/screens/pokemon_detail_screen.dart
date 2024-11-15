import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pockemon_app/repos/hive_repo.dart';
import 'package:flutter_pockemon_app/ui/screens/rotating_image_widget.dart';
import 'package:flutter_pockemon_app/utils/extensions/buildcontext_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/pokemons.dart';
import '../../utils/helpers/pokemon_card.color.dart';

class PokemonDetailScreen extends ConsumerStatefulWidget {
  const PokemonDetailScreen({super.key, required this.pokemon});
  final Pokemons pokemon;

  @override
  ConsumerState<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.getPokemonCardColour(
          pokemonType: widget.pokemon.typeofpokemon!.first),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Helpers.getPokemonCardColour(
            pokemonType: widget.pokemon.typeofpokemon!.first),
        centerTitle: true,
        title: Text(
          widget.pokemon.name!,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(hiveRepoProvider).addPokemonToHive(widget.pokemon);
              },
              icon: const Icon(Icons.favorite)),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: context.getHeight(percentage: 0.55),
              decoration:  BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(widget.pokemon.xdescription!),
                    ProductDetailsRowWidget(
                        title: 'Type',
                        data: widget.pokemon.typeofpokemon!.join(',')),
                    ProductDetailsRowWidget(
                        title: 'Height', data: widget.pokemon.height!),
                    ProductDetailsRowWidget(
                        title: 'Weight', data: widget.pokemon.weight!),
                    ProductDetailsRowWidget(
                        title: 'Speed', data: widget.pokemon.speed!.toString()),
                    ProductDetailsRowWidget(
                        title: 'Attack', data: widget.pokemon.attack!.toString()),
                    ProductDetailsRowWidget(
                        title: 'Defense',
                        data: widget.pokemon.defense!.toString()),
                    ProductDetailsRowWidget(
                        title: 'Weakness',
                        data: widget.pokemon.weaknesses!.join(',')),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: context.getWidth(percentage: 0.5) - 125,
            child:  const RotatingImageWidget(),
           
         ),
          Positioned(
            top: 50,
            left: context.getWidth(percentage: 0.5) - 125,
            child: Hero(
              tag: widget.pokemon.id!,
              child: CachedNetworkImage(
                imageUrl: widget.pokemon.imageurl!,
                width: 250,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailsRowWidget extends StatelessWidget {
  const ProductDetailsRowWidget(
      {super.key, required this.title, required this.data});
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
              width: context.getWidth(percentage: 0.3),
              child: Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Text(data, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
