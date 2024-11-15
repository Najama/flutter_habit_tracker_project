import 'package:flutter_pockemon_app/repos/pockemon_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/pokemons.dart';

final pokemonFututeProvider= FutureProvider<List<Pokemons>>((ref) async{
    return await ref.watch(pockemonRepoProvider).getAllPockemons();
});

final counterStreamprovider = StreamProvider.autoDispose.family<int,int>((ref,counterStart) async* {
  int counter= 0 ;
  while (counter < 20)
  {
    await Future.delayed(Duration(milliseconds: 500));
    yield counter++;
  }

});