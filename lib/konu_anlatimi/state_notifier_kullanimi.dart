import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'all_providers.dart';


class StateNotifierKullanimi extends StatelessWidget {
  const StateNotifierKullanimi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("MaterialApp Build Tetiklendi");
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("MyHomePage Build Tetiklendi");
    return Scaffold(
      appBar: AppBar(title: Consumer(
        builder: (context, ref, child) {
          var title = ref.watch(title2Provider);
          return Text(title);
        },
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyText(),
            SizedBox(
              height: 30,
            ),
            MyCounterText(),
            CiftMiWidget(),
          ],
        ),
      ),
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}

class CiftMiWidget extends ConsumerWidget {
  const CiftMiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    debugPrint("Çift Mi Widget Tettiklendi");
    var ciftMi= ref.watch(ciftMiProvider);
    return  Text(ciftMi ? "Çift":"Tek");
  }
}


class MyCounterText extends ConsumerWidget {
  const MyCounterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sayac = ref.watch(sayacNotifierProvider);
    debugPrint("MyCounterText Build Tetiklendi");
    return Text(
      sayac.sayacDegeri.toString(),
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class MyFloatingActionButton extends ConsumerWidget {
  const MyFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("MyFloatingActionButton Build Tetiklendi");
    return FloatingActionButton(
      onPressed: () {
        //ref.read(sayacNotifierProvider) bize SayacModeli verir
        //arttırma ve azaltma methotları SayacManager sınıfında olduğundan bu sınıfa erişmeki için .notifier kullanılır.
        ref.read(sayacNotifierProvider.notifier).arttir();
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ); //
  }
}

class MyText extends ConsumerWidget {
  const MyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("MyText Build Tetiklendi");

    //var text = ref.watch(textProvider);
    return Text(
      ref.watch(textProvider),
    );
  }
}
