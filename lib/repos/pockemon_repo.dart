import 'dart:convert';
import 'dart:developer';

import 'package:flutter_pockemon_app/data/models/pokemons.dart';
import 'package:flutter_pockemon_app/utils/helpers/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/dio_client.dart';

class PockemonRepo {
  final Ref ref;
  PockemonRepo(this.ref);
  Future getAllPockemons() async {
    try {
      final response = await ref.read(dioProvider).get(POKEMON_API_URL);

      if (response.statusCode == 200) {
        List<Pokemons> pokemonList = jsonDecode(response.data)
            .map<Pokemons>((pokemon) => Pokemons.fromJson(pokemon))
            .toList();
        log(pokemonList[0].name.toString());

        return pokemonList;
      } else {
        return Future.error("Failed to load pokemons");
      }
    } on Exception catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}

final pockemonRepoProvider = Provider<PockemonRepo>((ref) => PockemonRepo(ref));
