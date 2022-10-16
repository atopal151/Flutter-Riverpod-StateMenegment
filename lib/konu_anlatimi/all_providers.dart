import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/sayac_model.dart';
import 'sayac_manager.dart';

final titleProvider = Provider<String>((ref) => 'Riverpod Basics');
final title2Provider =
    Provider<String>((ref) => 'Riverpod SteteNotifierProvider Basics');
final textProvider = Provider<String>((ref) {
  return 'Butona Basılma Sayısı :';
});

final sayacStateProvider = StateProvider<int>((ref) {
  return 0;
});

final sayacNotifierProvider =
    StateNotifierProvider<SayacManager, SayacModel>((ref) {
  return SayacManager();
});

final ciftMiProvider = Provider<bool>((ref) {
  var sayacModel = ref.watch(sayacNotifierProvider);
  /*if(sayacModel.sayacDegeri % 2 ==0){
    return true;
  }else {
    return false;
  }*/
  return sayacModel.sayacDegeri % 5 == 0;
});
