import 'dart:async';

import 'package:belajar_riverpod/app/route.dart';
import 'package:belajar_riverpod/provider/current_biodata.dart';
import 'package:belajar_riverpod/provider/dio_provider.dart';
import 'package:belajar_riverpod/repository/biodata_repository.dart';
import 'package:belajar_riverpod/screen/biodata/biodata_add.dart';
import 'package:belajar_riverpod/screen/biodata/biodata_edit.dart';
import 'package:belajar_riverpod/screen/biodata/biodata_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/biodata_model.dart';

class BiodataScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      });
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => BiodataAdd(),
                      ),
                    );
                  },
                  child: Text('Add'),
                ),
                SizedBox(
                  height: 10,
                ),
                if (errorMessage.value != "") Text(errorMessage.value),
                Text('StateNotifierProvider'),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ListView.builder(
                      itemCount: listBiodataResult.value.length,
                      itemBuilder: (context, index) {
                        print(listBiodataResult.value);
                        return InkWell(
                            onTap: () {
                              ref.read(currentBiodata.notifier).state =
                                  BiodataModel(
                                idBiodata: listBiodataResult.value[0].idBiodata.toString(),
                                nama: listBiodataResult.value[0].nama,
                                umur: listBiodataResult.value[0].umur.toString(),
                              );
                              // print(listBiodataResult.value[0].idBiodata);
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      BiodataEdit(),
                                ),
                              );
                            },
                            child: Text('${listBiodataResult.value[index].nama.toString()}'));
                        // return Text('sassa');
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Stream Provider')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
