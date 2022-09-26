import 'package:belajar_riverpod/provider/current_biodata.dart';
import 'package:belajar_riverpod/provider/dio_provider.dart';
import 'package:belajar_riverpod/screen/biodata/biodata_provider.dart';
import 'package:belajar_riverpod/screen/biodata/biodata_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/biodata_model.dart';

class BiodataEdit extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var etNama = TextEditingController();
    var etUmur = TextEditingController();
    var etIdBiodata;

    final isLoading = useState(false);
    final isSuccess = useState(true);
    final errorMessage = useState("");
    final listData = useState<List<BiodataModel>>(List.empty());

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        etNama.text = ref.read(currentBiodata)?.nama ?? "";
        etUmur.text = ref.read(currentBiodata)?.umur ?? "";
        etIdBiodata = ref.read(currentBiodata)?.idBiodata;
      });
    }, []);

    ref.listen(biodataStateProvider, (prev, next) {
      if (next is BiodataLoadStateLoading) {
        isLoading.value = true;
      } else if (next is BiodataLoadStateDone) {
        isLoading.value = false;
        listData.value = next.model;
      } else if(next is BiodataLoadStateError){
        isLoading.value = false;
        isSuccess.value = false;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (errorMessage.value != "") Text(errorMessage.value),
            if (isSuccess.value == false) Text(errorMessage.value),
            TextFormField(
              controller: etNama,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: etUmur,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(biodataStateProvider.notifier).editBiodata(
                    etIdBiodata.toString(), etNama.text.toString(), etUmur.text.toString());
                if (isSuccess.value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => BiodataScreen(),
                    ),
                  );
                }
              },
              child: Text('Edit'),
            )
          ],
        ),
      ),
    );
  }
}
