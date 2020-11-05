import 'dart:io';

import 'package:drop_here_mobile/accounts/ui/pages/products_list_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/chosen_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_floating_action_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_text_area.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/bloc/add_product_bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage2 extends BlocWidget<AddProductBloc2> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();

  @override
  AddProductBloc2 bloc() => AddProductBloc2()..add(FormInitialized());

  @override
  Widget build(BuildContext context, AddProductBloc2 bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
        body: BlocConsumer<AddProductBloc2, AddProductState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (bloc.state.type == AddProductStateType.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.type == AddProductStateType.fetching_error) {
          return Text("ERROR");
        } else {
          return _buildContent(context, bloc, localeBundle);
        }
      },
      listenWhen: (previous, current) => previous.type != current.type,
      listener: (context, state) {
        if (state.type == AddProductStateType.added_successfully) {
          Get.to(ProductsListPage());
        } else {}
      },
    ));
  }

  Widget _buildContent(BuildContext context, AddProductBloc2 bloc, LocaleBundle localeBundle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            localeBundle.addProduct,
            style: themeConfig.textStyles.primaryTitle,
          ),
          _field(localeBundle.nameMandatory, localeBundle.productNameExample, InputType.text,
              (value) => bloc.add(FormChanged2(product: bloc.state.product.copyWith(name: value)))),
          _sectionTitle(localeBundle.photo),
          choosePhotoWidget(bloc),
          _sectionTitle(localeBundle.categoryMandatory),
          Wrap(
            children: [
              for (String category in bloc.state.categories)
                ChoosableButton(
                  text: category,
                  isChosen: category == bloc.state.product.category,
                  chooseAction: () => bloc.add(FormChanged2(
                      product: bloc.state.product.copyWith(
                    category: category,
                  ))),
                ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          _field(
              localeBundle.description,
              "",
              InputType.text,
              (value) =>
                  bloc.add(FormChanged2(product: bloc.state.product.copyWith(description: value)))),
          _field(
              localeBundle.pricePerUnitMandatory,
              localeBundle.pricePerUnitExample,
              InputType.number,
              (value) => bloc.add(
                  FormChanged2(product: bloc.state.product.copyWith(price: double.parse(value))))),
          SizedBox(
            height: 4.0,
          ),
          BlocBuilder<AddProductBloc2, AddProductState>(
            buildWhen: (previous, current) => previous.type != current.type,
            builder: (context, state) => Center(
              child: SubmitFormButton(
                  text: localeBundle.addProduct,
                  isActive: state.isFormFilled,
                  onTap: () =>
                      bloc.add(FormSubmitted2(product: state.product, photo: state.photo))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: themeConfig.textStyles.secondaryTitle,
    );
  }

  Widget _field(String text, String hint, InputType inputType, Function(String) onChanged) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: themeConfig.textStyles.secondaryTitle,
        ),
        DhPlainTextFormField(
            hintText: hint, inputType: inputType, onChanged: (String value) => onChanged)
      ],
    );
  }

  Widget choosePhotoWidget(AddProductBloc2 bloc) {
    return BlocBuilder<AddProductBloc2, AddProductState>(
      builder: (context, state) => GestureDetector(
        child: Container(
          child: bloc.state.photo != null
              ? GestureDetector(
                  onTap: () {
                    bloc.add(PhotoChanged(photo: null));
                  },
                  child: Stack(children: [
                    Image.file(bloc.state.photo),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(Icons.close),
                    )
                  ]),
                )
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
    bloc.add(PhotoChanged(photo: File(pickedFile?.path)));
  }
}

class AddProductPage extends BlocWidget<AddProductBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();

  @override
  AddProductBloc bloc() => AddProductBloc()..add(FetchData());

  @override
  Widget build(BuildContext context, AddProductBloc addProductBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;

    return Scaffold(
      body: SafeArea(
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
    );
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
              ? GestureDetector(
                  onTap: () {
                    bloc.add(FormChanged(photoNull: true));
                  },
                  child: Stack(children: [
                    Image.file(bloc.state.photo),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(Icons.close),
                    )
                  ]),
                )
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
