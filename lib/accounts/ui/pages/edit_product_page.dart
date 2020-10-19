import 'dart:io';

import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/bloc/edit_product_bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EditProductPage extends BlocWidget<EditProductBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();
  File _image;
  List<GestureDetector> categoryChoiceWidgets = [];

  @override
  EditProductBloc bloc() => EditProductBloc();

  @override
  Widget build(BuildContext context, EditProductBloc editProductBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    final List categories = ['fruits', 'vege', 'other'];

    categories.forEach((element) {
      return categoryChoiceWidgets.add(categoryChoice(
          text: element,
          isChosen: editProductBloc.state.productManagementRequest.category == element));
    });
    return Scaffold(
        body: SlidingUpPanel(
      body: Center(
        child: Text('background'),
      ),
      panel: SafeArea(
        child: BlocBuilder<EditProductBloc, EditProductFormState>(
          builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    locale.editProduct,
                    style: themeConfig.textStyles.primaryTitle,
                  ),
                ),
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
                            editProductBloc.add(FormChanged(
                                productManagementRequest:
                                    state.productManagementRequest.copyWith(name: name)));
                          },
                        ),
                        Text(
                          locale.photo,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        choosePhotoWidget(editProductBloc),
                        SizedBox(
                          height: 8.0,
                        ),
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
                            editProductBloc.add(FormChanged(
                                productManagementRequest: state.productManagementRequest
                                    .copyWith(description: description)));
                          },
                          value: state.productManagementRequest.description,
                        ),
                        Text(
                          locale.unitTypeMandatory,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          onChanged: (String unit) => editProductBloc.add(FormChanged(
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
                            editProductBloc.add(FormChanged(
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
                            editProductBloc.add(FormChanged(
                                productManagementRequest: state.productManagementRequest.copyWith(
                                    unitFraction: value != "" ? double.parse(value) : null)));
                          },
                        ),
                        Center(
                          child: SubmitFormButton(
                              text: locale.submit,
                              isActive: state.isFilled(),
                              //TODO check this function
                              onTap: () {
                                editProductBloc.add(FormSubmitted());
                              }),
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
        ),
      ),
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

  BlocBuilder<EditProductBloc, EditProductFormState> floatingButton(
      LocaleBundle locale, EditProductBloc editProductBloc) {
    return BlocBuilder<EditProductBloc, EditProductFormState>(
        buildWhen: (previous, current) => current.isFilled(),
        builder: (context, state) {
          return FloatingActionButton.extended(
            //TODO add action
            onPressed: () {},
            label: Text(
              locale.submit,
              style: TextStyle(
                  color: editProductBloc.state.isFilled()
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
            dhShadow(),
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
