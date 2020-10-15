import 'package:flutter/material.dart';

SizedBox editButton({Function onPressed}) {
  return SizedBox(
    width: 28.0,
    height: 28.0,
    child: RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.edit,
        size: 18.0,
      ),
      shape: CircleBorder(
        side: BorderSide(color: Colors.black),
      ),
    ),
  );
}
