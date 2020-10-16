import 'dart:io';

import 'package:drop_here_mobile/accounts/bloc/add_product_bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/product_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_floating_action_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddProductPage extends BlocWidget<AddProductBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();
  File _image;
  List<GestureDetector> categoryChoiceWidgets = [];

  @override
  AddProductBloc bloc() => AddProductBloc()..add(FetchCategories())..add(FetchUnits());

  @override
  Widget build(BuildContext context, AddProductBloc addProductBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;

    return Scaffold(
        body: SlidingUpPanel(
      body: Center(child: Text('background')),
      panel: SafeArea(
        child: BlocBuilder<AddProductBloc, AddProductFormState>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    Localization.of(context).bundle.addProduct,
                    style: themeConfig.textStyles.primaryTitle,
                  ),
                ),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          locale.categoryMandatory,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        FutureBuilder(
                          future: addProductBloc.state.categories,
                          initialData: List<ProductCategoryResponse>(0),
                          builder:
                              (context, AsyncSnapshot<List<ProductCategoryResponse>> snapshot) {
                            List<ProductCategoryResponse> categories = snapshot.data ?? [];
                            return Wrap(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (ProductCategoryResponse item in categories)
                                      categoryChoice(
                                          text: item.name, addProductBloc: addProductBloc)
                                  ],
                                ),
                              ],
                            );
                          },
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
                          value: state.productManagementRequest.description,
                        ),
                        Text(
                          locale.unitTypeMandatory,
                          style: themeConfig.textStyles.secondaryTitle,
                        ),
                        FutureBuilder(
                          future: addProductBloc.state.units,
                          initialData: List<ProductUnitResponse>(0),
                          builder: (context, AsyncSnapshot<List<ProductUnitResponse>> snapshot) {
                            List<ProductUnitResponse> units = snapshot.data ?? [];
                            List<String> textUnits = units.map((e) => e.name).toList();
                            return DropdownButton<String>(
                              isExpanded: true,
                              onChanged: (String unit) => addProductBloc.add(FormChanged(
                                  productManagementRequest:
                                      state.productManagementRequest.copyWith(unit: unit))),
                              value: state.productManagementRequest?.unit,
                              icon: Icon(Icons.arrow_drop_down),
                              items: textUnits.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );
                          },
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
                          height: 4.0,
                        ),
                        Center(
                          child: BigColoredRoundedFlatButton(
                              text: locale.addProduct,
                              isActive: state.isFilled(),
                              //TODO check this function
                              onTap: () {
                                addProductBloc.add(FormSubmitted());
                              }),
                        ),
                        SizedBox(
                          height: 50.0,
                        )
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

  GestureDetector categoryChoice(
      {String text, bool isChosen = false, AddProductBloc addProductBloc}) {
    return GestureDetector(
      onTap: () {
        addProductBloc
            .add(FormChanged(productManagementRequest: ProductManagementRequest(category: text)));
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: addProductBloc.state.productManagementRequest.category == text
                  ? Colors.red
                  : Colors.black),
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
      String text, AddProductBloc addProductBloc, LocaleBundle locale) {
    return BlocBuilder<AddProductBloc, AddProductFormState>(
        buildWhen: (previous, current) => current.isFilled(),
        builder: (context, state) {
          return dhFloatingButton(text: locale.addProduct, enabled: state.isFilled());
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
