import 'package:belajar_riverpod/screen/biodata/biodata_provider.dart';
import 'package:belajar_riverpod/screen/biodata/biodata_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BiodataAdd extends HookConsumerWidget {
  var etNama = TextEditingController();
  var etUmur = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final isSucces = useState(true);
    final errorMessage = useState("");

    ref.listen(biodataStateProvider, ((previous, next) {
      if (next is BiodataLoadStateError) {
        isLoading.value = false;
        isSucces.value = false;
        errorMessage.value = next.message;
      } else if (next is BiodataLoadStateDone) {
        isLoading.value = false;
      }
    }));

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (errorMessage.value != "") Text(errorMessage.value),
            if (isSucces.value == false) Text(errorMessage.value),
            TextFormField(
              controller: etNama,
              decoration: InputDecoration(hintText: 'Nama...'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: etUmur,
              decoration: InputDecoration(hintText: 'Umur...'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(biodataStateProvider.notifier)
                    .addBiodata(etNama.text.toString(), etUmur.text.toString());
                if (isSucces.value == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => BiodataScreen(),
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
