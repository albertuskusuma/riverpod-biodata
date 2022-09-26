import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/biodata_model.dart';

final currentBiodata = StateProvider<BiodataModel?>((ref)=>null);