import 'package:flutter/material.dart';

import '../screen/biodata/biodata_screen.dart';

const listBiodata = "/listBiodata";

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == listBiodata) {
      return MaterialPageRoute(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: 1.0, padding: EdgeInsets.all(0)),
          child: BiodataScreen(),
        );
      });
    }

    return MaterialPageRoute(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaleFactor: 1.0, padding: EdgeInsets.all(0)),
        child: BiodataScreen(),
      );
    });
  }
}
