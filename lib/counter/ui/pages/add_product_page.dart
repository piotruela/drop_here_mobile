import 'dart:io';

import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();
  File _image;
  final String ddValue = 'Grams';
  @override
  Widget build(BuildContext context) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            'Add product',
            style: TextStyle(color: Colors.orange),
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: themeConfig.colors.primary1,
          title: Text(Localization.of(context).bundle.addProduct),
        ),
        body: ListView(
          children: [
            Form(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name*',
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    dhTextFormField(
                      hintText: 'e.g. Strawberries',
                    ),
                    Text(
                      'Photo',
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    GestureDetector(
                      child: Container(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 46.0,
                        ),
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: themeConfig.colors.addSthHere,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: Offset(4, 4),
                            )
                          ],
                        ),
                      ),
                      onTap: getImage,
                    ),
                    Text(
                      'Category*',
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        decoration:
                            BoxDecoration(border: Border.all(), borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: Text(
                          'Fruits',
                        ),
                      ),
                    ),
                    Text(
                      'Description',
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    dhTextArea(),
                    Text(
                      'Unit type*',
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    DropdownButton<String>(
                      onChanged: (String newValue) {},
                      value: ddValue,
                      icon: Icon(Icons.arrow_drop_down),
                      items: <String>['Kilograms', 'Grams', 'Pieces', 'Liters']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Text(
                      'Price per unit* (PLN)',
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    dhTextFormField(
                      hintText: 'e.g. 4.20',
                    ),
                    Text(
                      'Unit fraction*',
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    dhTextFormField(
                      hintText: 'minimum value: 0.1',
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                    //dhTextFormField(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);

    // setState(() {
    //   _image = File(pickedFile.path);
    // });
  }
}

// ignore: camel_case_types
class dhTextFormField extends StatelessWidget {
  final String hintText;
  const dhTextFormField({this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class dhTextArea extends StatelessWidget {
  final String hintText;
  const dhTextArea({this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        cursorColor: Colors.black,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.clear),
          hintText: hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
