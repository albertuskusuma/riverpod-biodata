import 'package:belajar_riverpod/model/biodata_model.dart';
import 'package:belajar_riverpod/provider/dio_provider.dart';
import 'package:belajar_riverpod/repository/biodata_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/base_repository.dart';

// state provider
final biodataStateProvider = StateNotifierProvider<BiodataStateNotifier, BiodataLoadState>((ref){
  return BiodataStateNotifier(ref: ref);
});


// state notifier
class BiodataStateNotifier extends StateNotifier<BiodataLoadState>{
  
  Ref ref;
  BiodataStateNotifier({required this.ref}):super(BiodataLoadStateInit());
  
  void load() async {
    final dio = ref.read(dioProvider);

    try {
      state = BiodataLoadStateLoading();
      final resp = await BiodataRepository(dio: dio).load();
      state = BiodataLoadStateDone(model: resp);
      // print(resp);
    } catch (e) {
      if(e is BaseRepositoryException) {
        state = BiodataLoadStateError(message: e.message);
      }else{
        state = BiodataLoadStateError(message: e.toString());
      }
    }
  }
}

// state
abstract class BiodataLoadState extends Equatable{
  final DateTime dateTime;

  BiodataLoadState(this.dateTime);
  @override
  List<Object?> get props => [dateTime];
}

class BiodataLoadStateInit extends BiodataLoadState{
  BiodataLoadStateInit():super(DateTime.now());
}

class BiodataLoadStateLoading extends BiodataLoadState{
  BiodataLoadStateLoading():super(DateTime.now());
}

class BiodataLoadStateError extends BiodataLoadState{
  final String message;

  BiodataLoadStateError({required this.message}):super(DateTime.now());
  
}

class BiodataLoadStateDone extends BiodataLoadState{
  final List<BiodataModel> model;
  BiodataLoadStateDone({required this.model}):super(DateTime.now());
}