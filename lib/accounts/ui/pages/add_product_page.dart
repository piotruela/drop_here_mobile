import 'dart:io';

import 'package:drop_here_mobile/accounts/bloc/add_product_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/product_management_api.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends BlocWidget<AddProductBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();
  File _image;
  List<GestureDetector> categoryChoiceWidgets = [];

  @override
  AddProductBloc bloc() => AddProductBloc();

  @override
  Widget build(BuildContext context, AddProductBloc addProductBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    final List categories = ['fruits', 'vege', 'other'];

    categories.forEach((element) {
      return categoryChoiceWidgets.add(categoryChoice(
          text: element,
          isChosen: addProductBloc.state.productManagementRequest.category == element));
    });
    return Scaffold(
        floatingActionButton: floatingButton(locale, addProductBloc),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: themeConfig.colors.primary1,
          title: Text(Localization.of(context).bundle.addProduct),
        ),
        body: BlocBuilder<AddProductBloc, AddProductFormState>(
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
                          locale.nameMandatory,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        DhPlainTextFormField(
                          hintText: locale.productNameExample,
                          onChanged: (String name) {
                            addProductBloc.add(FormChanged(
                                productManagementRequest:
                                    state.productManagementRequest.copyWith(name: name)));
                          },
                        ),
                        Text(
                          locale.photo,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        choosePhotoWidget(addProductBloc),
                        Text(
                          locale.categoryMandatory,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        Wrap(
                          children: categoryChoiceWidgets,
                        ),

                        Text(
                          locale.description,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        DhTextArea(
                          onChanged: (String description) {
                            addProductBloc.add(FormChanged(
                                productManagementRequest: state.productManagementRequest
                                    .copyWith(description: description)));
                          },
                        ),
                        Text(
                          locale.unitTypeMandatory,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          onChanged: (String unit) => addProductBloc.add(FormChanged(
                              productManagementRequest:
                                  state.productManagementRequest.copyWith(unit: unit))),
                          value: state.productManagementRequest?.unit,
                          icon: Icon(Icons.arrow_drop_down),
                          items: <String>['grams', 'kilograms', 'liters']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Text(
                          locale.pricePerUnitMandatory,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        DhPlainTextFormField(
                          hintText: locale.pricePerUnitExample,
                          inputType: InputType.number,
                          onChanged: (String value) {
                            addProductBloc.add(FormChanged(
                                productManagementRequest: state.productManagementRequest
                                    .copyWith(price: double.parse(value))));
                          },
                        ),
                        Text(
                          locale.unitFractionMandatory,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        DhPlainTextFormField(
                          hintText: locale.unitFractionExample,
                          inputType: InputType.number,
                          onChanged: (String value) {
                            addProductBloc.add(FormChanged(
                                productManagementRequest: state.productManagementRequest.copyWith(
                                    unitFraction: value != "" ? double.parse(value) : null)));
                          },
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

  GestureDetector categoryChoice({String text, bool isChosen = false}) {
    return GestureDetector(
      onTap: () {
        isChosen = true;
        bloc().add(FormChanged(productManagementRequest: ProductManagementRequest(category: text)));
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          border: Border.all(color: isChosen ? Colors.red : Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }

  BlocBuilder<AddProductBloc, AddProductFormState> floatingButton(
      LocaleBundle locale, AddProductBloc addProductBloc) {
    return BlocBuilder<AddProductBloc, AddProductFormState>(
        buildWhen: (previous, current) => current.isFilled(),
        builder: (context, state) {
          return FloatingActionButton.extended(
            //TODO add action
            onPressed: () {},
            label: Text(
              locale.addProduct,
              style: TextStyle(
                  color: addProductBloc.state.isFilled()
                      ? themeConfig.colors.primary1
                      : themeConfig.colors.addSthHere),
            ),
            backgroundColor: themeConfig.colors.white,
          );
        });
  }

  GestureDetector choosePhotoWidget(Bloc bloc) {
    return GestureDetector(
      child: Container(
        child: bloc.state.photo != null
            ? Image.file(bloc.state.photo)
            : Icon(
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
      onTap: () => getImage(bloc),
    );
  }

  Future getImage(Bloc bloc) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    bloc.add(FormChanged(photo: _image));
  }
}

class DhPlainTextFormField extends StatelessWidget {
  final String hintText;
  final InputType inputType;
  final void Function(String) onChanged;
  const DhPlainTextFormField({this.hintText, this.inputType, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        onChanged: onChanged,
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

class DhTextArea extends StatelessWidget {
  final String hintText;
  final void Function(String) onChanged;
  DhTextArea({this.hintText, this.onChanged});
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextFormField(
        onChanged: onChanged,
        //controller: _controller,
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