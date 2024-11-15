import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pockemon_app/providers/pockemon_future_provider.dart';
import 'package:flutter_pockemon_app/repos/hive_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/pokemons.dart';

class FavouritePokemonScreen extends ConsumerStatefulWidget {
  const FavouritePokemonScreen({super.key});

  @override
  ConsumerState<FavouritePokemonScreen> createState() =>
      _FavouritePokemonScreenState();
}

class _FavouritePokemonScreenState
    extends ConsumerState<FavouritePokemonScreen> {
   List<Pokemons> favPokemonList=[];
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref
          .read(hiveRepoProvider)
          .getAllPokemonsFromHive()
          .then((pokemonList) {
            log(pokemonList.length.toString());
        setState(() {
          favPokemonList = pokemonList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<int> counterProvider= ref.watch(counterStreamprovider(5));

    return Scaffold(
      appBar: AppBar(
        title:const Text('Favourites', style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: 
      counterProvider.when(data: (data){
              return ListView.builder(
                  itemCount:  favPokemonList.length, // Replace with your item count
                      itemBuilder: (context, index) {
                        final pokemon = favPokemonList[index];
                        return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(imageUrl: pokemon.imageurl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    ),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pokemon.name!,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      pokemon.typeofpokemon!.first,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
          
                
                  ],
                ),
              ),
              IconButton(icon:Icon(Icons.delete), onPressed: () {
                ref.read(hiveRepoProvider).deletePokemonFromhive(pokemon.id!);
                ref.read(hiveRepoProvider).getAllPokemonsFromHive().then((list){
                  setState(() {
                    favPokemonList=list;
                  });
                }
                );
                },),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
          child: Divider(
            height: 1,
            color: Colors.grey,
          ),
        )
      ],
    );
  
                      },
                    );
 

      },
       error: (err,stk){},
      loading: ()=>CircularProgressIndicator())
   );
  }
}
