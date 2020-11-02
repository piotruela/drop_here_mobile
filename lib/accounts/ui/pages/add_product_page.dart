import 'dart:io';

import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/chosen_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_floating_action_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/bloc/add_product_bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddProductPage extends BlocWidget<AddProductBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();

  @override
  AddProductBloc bloc() => AddProductBloc()..add(FetchData());

  @override
  Widget build(BuildContext context, AddProductBloc addProductBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;

    return Scaffold(
        body: SlidingUpPanel(
      maxHeight: 550,
      defaultPanelState: PanelState.OPEN,
      body: Center(child: Text('background')),
      panel: SafeArea(
        child: ListView(
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
                            productManagementRequest: addProductBloc.state.productManagementRequest
                                .copyWith(name: name, productCustomizationWrappers: [])));
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
                    BlocBuilder<AddProductBloc, AddProductFormState>(
                      buildWhen: (previous, current) =>
                          previous.productManagementRequest.category !=
                              current.productManagementRequest.category ||
                          previous.categories != current.categories,
                      builder: (context, state) => Wrap(
                        children: [
                          if (state.categories != null)
                            for (ProductCategoryResponse item in state.categories)
                              categoryChoice(text: item.name, addProductBloc: addProductBloc)
                          else
                            CircularProgressIndicator(),
                          addCategory(
                              text: locale.addNew,
                              context: context,
                              locale: locale,
                              addProductBloc: addProductBloc)
                        ],
                      ),
                    ),
                    Text(
                      locale.description,
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    DhTextArea(
                      onChanged: (String description) {
                        addProductBloc.add(FormChanged(
                            productManagementRequest: addProductBloc.state.productManagementRequest
                                .copyWith(description: description)));
                      },
                      value: addProductBloc.state.productManagementRequest.description,
                    ),
                    Text(
                      locale.unitTypeMandatory,
                      style: themeConfig.textStyles.secondaryTitle,
                    ),
                    BlocBuilder<AddProductBloc, AddProductFormState>(
                      buildWhen: (previous, current) =>
                          previous.productManagementRequest.unit !=
                              current.productManagementRequest.unit ||
                          previous.units != current.units,
                      builder: (context, state) => DropdownButton<String>(
                        isExpanded: true,
                        onChanged: (String unit) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          return addProductBloc.add(FormChanged(
                              productManagementRequest: addProductBloc
                                  .state.productManagementRequest
                                  .copyWith(unit: unit)));
                        },
                        value: state.productManagementRequest?.unit,
                        icon: Icon(Icons.arrow_drop_down),
                        items: addProductBloc.state?.units
                            ?.map((e) => e.name)
                            ?.toList()
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })?.toList(),
                      ),
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
                            productManagementRequest: addProductBloc.state.productManagementRequest
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
                            productManagementRequest: addProductBloc.state.productManagementRequest
                                .copyWith(unitFraction: value != "" ? double.parse(value) : null)));
                      },
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    BlocBuilder<AddProductBloc, AddProductFormState>(
                      buildWhen: (previous, current) => previous.isFilled() != current.isFilled(),
                      builder: (context, state) => Center(
                        child: SubmitFormButton(
                            text: locale.addProduct,
                            isActive: state.isFilled(),
                            //TODO check this function
                            onTap: () {
                              if (state.isFilled()) {
                                addProductBloc.add(FormSubmitted());
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  GestureDetector categoryChoice(
      {String text, bool isChosen = false, AddProductBloc addProductBloc}) {
    return GestureDetector(
      onTap: () {
        addProductBloc.add(FormChanged(
            productManagementRequest:
                addProductBloc.state.productManagementRequest.copyWith(category: text)));
      },
      child: addProductBloc.state.productManagementRequest.category == text
          ? ChosenRoundedFlatButton(
              text: text,
            )
          : RoundedFlatButton(
              text: text,
            ),
    );
  }

  GestureDetector addCategory(
      {String text, AddProductBloc addProductBloc, BuildContext context, LocaleBundle locale}) {
    TextEditingController controller = TextEditingController();
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        String category = await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    locale.addCategory,
                    style: themeConfig.textStyles.secondaryTitle,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller,
                      ),
                    ],
                  ),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          //addProductBloc.add(FormChanged());
                          Navigator.of(context).pop(controller.text);
                        },
                        child: Text(locale.add))
                  ],
                ));
        //TODO add option to delete category and show 'addCategory' button only when user hasn't added own category
        addProductBloc.add(FormChanged(
            categories: addProductBloc.state.categories
              ..add(ProductCategoryResponse(name: category)),
            productManagementRequest:
                addProductBloc.state.productManagementRequest.copyWith(category: category)));
        // addProductBloc.add(FormChanged(
        //     categories: addProductBloc.state.categories
        //       ..add(ProductCategoryResponse(name: category))));
        // .add(FormChanged(
        //     categories: addProductBloc.state.categories
        //       ..add(ProductCategoryResponse(name: category))));
        //addProductBloc.add(FormChanged(productManagementRequest: addProductBloc.state.productManagementRequest.copyWith()));
        print(category);
        // addProductBloc.add(FormChanged(
        //     productManagementRequest:
        //     addProductBloc.state.productManagementRequest.copyWith(category: text)));
      },
      child: RoundedFlatButton(
        text: text,
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

  Widget choosePhotoWidget(AddProductBloc bloc) {
    return BlocBuilder<AddProductBloc, AddProductFormState>(
      builder: (context, state) => GestureDetector(
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
      ),
    );
  }

  Future getImage(Bloc bloc) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    bloc.add(FormChanged(photo: File(pickedFile?.path)));
  }
}
