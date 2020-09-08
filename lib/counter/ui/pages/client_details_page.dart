import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class ClientDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(Localization.of(context).bundle.yourDetails),
    );
  }
}
