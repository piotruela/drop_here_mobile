import 'dart:io';

import 'package:drop_here_mobile/accounts/ui/pages/products_list_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/bloc/add_product_bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/ui/widgets/customization_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends BlocWidget<AddProductBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();

  @override
  AddProductBloc bloc() => AddProductBloc()..add(FormInitialized());

  @override
  Widget build(BuildContext context, AddProductBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
        body: BlocConsumer<AddProductBloc, AddProductState>(
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

  Widget _buildContent(BuildContext context, AddProductBloc bloc, LocaleBundle localeBundle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          DhBackButton(padding: EdgeInsets.zero),
          Text(
            localeBundle.addProduct,
            style: themeConfig.textStyles.primaryTitle,
          ),
          _field(localeBundle.nameMandatory, localeBundle.productNameExample, InputType.text,
              (value) => bloc.add(FormChanged(product: bloc.state.product.copyWith(name: value)))),
          _sectionTitle(localeBundle.photo),
          choosePhotoWidget(bloc),
          _sectionTitle(localeBundle.categoryMandatory),
          Wrap(
            children: [
              for (String category in bloc.state.categories)
                ChoosableButton(
                  text: category,
                  isChosen: category == bloc.state.product.category,
                  chooseAction: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    bloc.add(FormChanged(
                        product: bloc.state.product.copyWith(
                      category: category,
                    )));
                  },
                ),
              _categoriesTrailingButton(context, bloc)
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
                  bloc.add(FormChanged(product: bloc.state.product.copyWith(description: value)))),
          _sectionTitle(localeBundle.unitTypeMandatory),
          DropdownButton<String>(
              isExpanded: true,
              onChanged: (String unit) {
                FocusScope.of(context).requestFocus(FocusNode());
                return bloc.add(FormChanged(product: bloc.state.product.copyWith(unit: unit)));
              },
              value: bloc.state.product?.unit,
              icon: Icon(Icons.arrow_drop_down),
              items: [
                for (String unit in bloc.state.unitTypes)
                  DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  )
              ]),
          _field(
              localeBundle.pricePerUnitMandatory,
              localeBundle.pricePerUnitExample,
              InputType.number,
              (value) => bloc.add(
                  FormChanged(product: bloc.state.product.copyWith(price: double.parse(value))))),
          _field(
              localeBundle.unitFractionMandatory,
              localeBundle.unitFractionExample,
              InputType.number,
              (value) => bloc.add(FormChanged(
                  product: bloc.state.product.copyWith(unitFraction: double.parse(value))))),
          _sectionTitle("Customizations"),
          SizedBox(
            height: 4.0,
          ),
          _customizationsList(context, bloc, bloc.state.product.productCustomizationWrappers),
          ChoosableButton(
            text: "Add customization +",
            isChosen: false,
            chooseAction: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              ProductCustomizationWrapperRequest customization = await showDialog(
                  context: context,
                  child: CustomizationDialog(customization: ProductCustomizationWrapperRequest()));
              if (customization != null) {
                bloc.add(CustomizationAdded(customization: customization));
              }
            },
          ),
          BlocBuilder<AddProductBloc, AddProductState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: SubmitFormButton(
                    text: localeBundle.addProduct,
                    isActive: state.isFormFilled,
                    onTap: () =>
                        bloc.add(FormSubmitted(product: state.product, photo: state.photo))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customizationsList(BuildContext context, AddProductBloc bloc,
      List<ProductCustomizationWrapperRequest> customizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (ProductCustomizationWrapperRequest customization in customizations)
          ChoosableButtonWithSubText(
            text: customization.heading + (customization.required ? "*" : ""),
            subText:
                "${describeEnum(customization.type)} type, ${customization.customizations.length} options",
            isChosen: false,
            chooseAction: () async => bloc.add(EditCustomization(customizationIndex: customizations.indexOf(customization),
                customization: await showDialog(
                    context: context, child: CustomizationDialog(customization: customization)))),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => bloc.add(CustomizationRemoved(customization: customization)),
            ),
          )
      ],
    );
  }

  Widget _categoriesTrailingButton(BuildContext context, AddProductBloc bloc) {
    return bloc.state.addedCategory != null
        ? _addedCategoryButton(context, bloc)
        : _addCategoryButton(context, bloc);
  }

  Widget _addedCategoryButton(BuildContext context, AddProductBloc bloc) {
    return ChoosableButton(
      text: bloc.state.addedCategory,
      isChosen: bloc.state.addedCategory == bloc.state.product.category,
      chooseAction: () {
        FocusScope.of(context).requestFocus(FocusNode());
        bloc.add(FormChanged(
            product: bloc.state.product.copyWith(
          category: bloc.state.addedCategory,
        )));
      },
      trailing: IconButton(
          icon: Icon(
            Icons.close,
            size: 20.0,
          ),
          onPressed: () => bloc.add(CategoryRemoved())),
    );
  }

  Widget _addCategoryButton(BuildContext context, AddProductBloc bloc) {
    final TextEditingController controller = TextEditingController();
    return ChoosableButton(
        text: "Add new +",
        isChosen: false,
        chooseAction: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final String category = await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(
                      "Add category",
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
                          child: Text("Add"))
                    ],
                  ));
          if (category != null && category != "") {
            bloc.add(CategoryAdded(addedCategory: category.toUpperCase()));
          }
        });
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
        DhPlainTextFormField(hintText: hint, inputType: inputType, onChanged: onChanged)
      ],
    );
  }

  Widget choosePhotoWidget(AddProductBloc bloc) {
    return BlocBuilder<AddProductBloc, AddProductState>(
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
