import 'dart:async';

import 'package:belajar_riverpod/app/route.dart';
import 'package:belajar_riverpod/provider/dio_provider.dart';
import 'package:belajar_riverpod/repository/biodata_repository.dart';
import 'package:belajar_riverpod/screen/biodata/biodata_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/biodata_model.dart';

class BiodataScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final x = ref.read(biodataStateProvider.notifier).load();

    final isLoading = useState(false);
    final errorMessage = useState("");
    final listBiodataResult = useState<List<BiodataModel>>(List.empty());

    // untuk state ketika ada perubahan setelah di render pertama kali
    ref.listen(biodataStateProvider, (prev, next) {
      if (next is BiodataLoadStateLoading) {
        isLoading.value = true;
      } else if (next is BiodataLoadStateError) {
        isLoading.value = false;
        errorMessage.value = next.message;
      } else if (next is BiodataLoadStateDone) {
        isLoading.value = false;
        listBiodataResult.value = next.model;
        print(listBiodataResult.value);
      }
    });

    // render pertama kali saat halaman di load
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(biodataStateProvider.notifier).load();
        BiodataRepository(dio: ref.read(dioProvider)).load();
      });
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (errorMessage.value != "") Text(errorMessage.value),
              SizedBox(
                width: 100,
                height: 100,
                child: ListView.builder(
                    itemCount: listBiodataResult.value.length,
                    itemBuilder: (context, index) {
                      print(listBiodataResult);
                      return Text('${listBiodataResult.value}');
                      // return Text('sassa');
                    }),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: FutureBuilder<List<BiodataModel>>(
                  // future: BiodataRepository(dio: ref.read(dioProvider)).load(),
                  future : BiodataRepository(dio: ref.read(dioProvider)).getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }else if(snapshot.hasData){
                        // final data = snapshot.data as String;
                        print('masuk');
                        return Center(
                          child: Text('${snapshot.data?[0].nama}'),
                        );
                      }
                    }
                    return Text('hallo');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
