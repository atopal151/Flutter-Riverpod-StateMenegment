import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpos_statemenegment/models/cat_fact_model.dart';

final httpClientProvider = Provider((ref) {
  return Dio(BaseOptions(baseUrl: 'https://catfact.ninja/'));
});

final catFactsProvider = FutureProvider.autoDispose
    .family<List<CatFactModel>, Map<String, dynamic>>(
        (ref, parametreMap) async {
  final _dio = ref.watch(httpClientProvider);
  final _result = await _dio.get('facts', queryParameters: parametreMap);
  ref.keepAlive();
  /*
    final _result =
      await _dio.get('facts', queryParameters: {
        'limit':parametreMap['limit'],
        'max_length':parametreMap['max_length'],
      });
   */
  List<Map<String, dynamic>> _mapData = List.from(_result.data['data']);
  List<CatFactModel> _catFactList =
      _mapData.map((e) => CatFactModel.fromMap(e)).toList();
  return _catFactList;
});

class FutureProviderExample extends ConsumerWidget {
  const FutureProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _liste =
        ref.watch(catFactsProvider(const {'limit': 6, 'max_length': 50}));
    return Scaffold(
      body: SafeArea(
          child: _liste.when(
              data: (liste) {
                return ListView.builder(
                    itemCount: liste.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(liste[index].fact),
                      );
                    });
              },
              error: (err, stack) {
                return Center(
                  child: Text('Hataa!! ${err.toString()}'),
                );
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ))),
    );
  }
}
