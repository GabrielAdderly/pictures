import 'package:flutter/material.dart';

import 'package:pictures_view/ui/layouts/main_layout/main_layout.dart';

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Center(
        child: Text(
          'UnkownPage',
        ),
      ),
    );
  }
}