import 'package:flutter_pockemon_app/data/models/pokemons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class HiveRepo {
  final pokemonBoxName = 'pokemonBox';
  void registerAdapter() {
    Hive.registerAdapter(PokemonsAdapter());
  }

  Future addPokemonToHive(Pokemons pokemon) async {
   final  pokemonBox = Hive.isBoxOpen(pokemonBoxName) ? Hive.box<Pokemons>(pokemonBoxName) : await Hive.openBox<Pokemons>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      await pokemonBox.put(pokemon.id, pokemon);
      await pokemonBox.close();
    } else {
      throw Exception('Box is not open');
    }
  }
  Future deletePokemonFromhive(String id) async{
   final  pokemonBox = Hive.isBoxOpen(pokemonBoxName) ? Hive.box<Pokemons>(pokemonBoxName) : await Hive.openBox<Pokemons>(pokemonBoxName);

    if (pokemonBox.isOpen) {
      await pokemonBox.delete(id);
      await pokemonBox.close();
    } else {
      throw Exception('Box is not open');
    }
  }
    Future <List<Pokemons>> getAllPokemonsFromHive() async{
   final  pokemonBox = Hive.isBoxOpen(pokemonBoxName) ?  Hive.box<Pokemons>(pokemonBoxName) : await Hive.openBox<Pokemons>(pokemonBoxName);

    if (pokemonBox.isOpen) {
      return  pokemonBox.values.toList();
    } else {
      throw Exception('Box is not open');
    }
  }
   Future <Pokemons> getSinglePokemonsFromHive( String id) async{
   final  pokemonBox = Hive.isBoxOpen(pokemonBoxName) ?  Hive.box(pokemonBoxName) : await Hive.openBox(pokemonBoxName);

    if (pokemonBox.isOpen) {
      return  pokemonBox.get(id)!;
    } else {
      throw Exception('Box is not open');
    }
  }
}
final hiveRepoProvider=Provider<HiveRepo>((ref)=>HiveRepo());
