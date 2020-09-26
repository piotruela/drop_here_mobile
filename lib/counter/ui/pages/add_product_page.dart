import 'dart:io';

import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/counter/bloc/add_product_bloc.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final addProductBloc = BlocProvider.of<AddProductBloc>(context);
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
        body: BlocBuilder<AddProductBloc, AddProductState>(
          builder: (context, state) {
            return ListView(
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
                        choosePhotoWidget(),
                        Text(
                          'Category*',
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        GestureDetector(
                          onTap: () => {},
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            decoration: BoxDecoration(
                                border: Border.all(), borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                        DropdownButton<UnitType>(
                          isExpanded: true,
                          onChanged: (UnitType unitType) => addProductBloc.add(ChooseUnitType(unitType: unitType)),
                          value: state.unitType,
                          icon: Icon(Icons.arrow_drop_down),
                          items: <UnitType>[UnitType.grams, UnitType.kilograms]
                              .map<DropdownMenuItem<UnitType>>((UnitType value) {
                            return DropdownMenuItem<UnitType>(
                              value: value,
                              child: Text(value.toString().split('.').last),
                            );
                          }).toList(),
                        ),
                        Text(
                          'Price per unit* (PLN)',
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        dhTextFormField(
                          hintText: 'e.g. 4.20',
                          inputType: InputType.number,
                        ),
                        Text(
                          'Unit fraction*',
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        dhTextFormField(
                          hintText: 'minimum value: 0.1',
                          inputType: InputType.number,
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
            );
          },
        ));
  }

  GestureDetector choosePhotoWidget() {
    return GestureDetector(
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
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(2, 3),
            )
          ],
        ),
      ),
      onTap: getImage,
    );
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
  final InputType inputType;
  const dhTextFormField({this.hintText, this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        keyboardType: inputType == InputType.number ? TextInputType.number : null,
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

enum InputType { text, number }

// ignore: camel_case_types
class dhTextArea extends StatelessWidget {
  final String hintText;
  dhTextArea({this.hintText});
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        controller: _controller,
        cursorColor: Colors.black,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: () => _controller.clear(), icon: Icon(Icons.clear)),
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
