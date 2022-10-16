import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/sayac_model.dart';

class SayacManager extends StateNotifier<SayacModel> {
  SayacManager() : super(SayacModel(0));

  void arttir() {
    var oAnkiSayacDegeri = state.sayacDegeri;
    state = SayacModel(oAnkiSayacDegeri + 1);
  }

  void azalt() {
    var oAnkiSayacDegeri = state.sayacDegeri;
    state = SayacModel(oAnkiSayacDegeri - 1);
  }
}
