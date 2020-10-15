import 'dart:io';

import 'package:flutter/material.dart';

Padding fullWidthPhoto(BuildContext context, File photo) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      alignment: Alignment.centerLeft,
      child: photo != null
          ? Image.file(
              photo,
              width: MediaQuery.of(context).size.width,
            )
          : null,
    ),
  );
}
