import 'package:drop_here_mobile/accounts/ui/pages/products_list_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_plain_text_form_field.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/info_text.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/bloc/manage_product_bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/ui/widgets/customization_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProductPage extends ManageProductPage {
  final ProductManagementRequest initialProduct;
  final Image initialPhoto;
  final String productIdentify;

  EditProductPage({this.initialProduct, this.initialPhoto, this.productIdentify});

  @override
  String get pageTitle => "Edit product";

  @override
  bool get isEditing => false;

  String get productId => productIdentify;

  @override
  ProductManagementRequest get product => initialProduct;

  @override
  Image get photo => initialPhoto;
}

class AddProductPage extends ManageProductPage {
  @override
  String get pageTitle => "Add product";

  @override
  bool get isEditing => false;

  String get productId => null;

  @override
  Image get photo => null;

  @override
  ProductManagementRequest get product => ProductManagementRequest(productCustomizationWrappers: []);
}

abstract class ManageProductPage extends BlocWidget<ManageProductBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final picker = ImagePicker();

  ManageProductPage();

  @override
  ManageProductBloc bloc() => ManageProductBloc(product: product, photo: photo)..add(FormInitialized());

  ProductManagementRequest get product;

  Image get photo;

  String get pageTitle;

  bool get isEditing;

  String get productId;

  @override
  Widget build(BuildContext context, ManageProductBloc bloc, _) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
        body: BlocConsumer<ManageProductBloc, ManageProductState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (bloc.state.type == ManageProductStateType.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.type == ManageProductStateType.fetching_error) {
          return Text("ERROR");
        } else {
          return _buildContent(context, bloc, localeBundle);
        }
      },
      listenWhen: (previous, current) => previous.type != current.type,
      listener: (context, state) {
        if (state.type == ManageProductStateType.added_successfully) {
          Get.to(ProductsListPage());
        } else {}
      },
    ));
  }

  Widget _buildContent(BuildContext context, ManageProductBloc bloc, LocaleBundle localeBundle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          DhBackButton(padding: EdgeInsets.zero),
          Text(
            pageTitle,
            style: themeConfig.textStyles.primaryTitle,
          ),
          _field(
              localeBundle.nameMandatory,
              localeBundle.productNameExample,
              InputType.text,
              (value) => bloc.add(FormChanged(product: bloc.state.product.copyWith(name: value))),
              bloc.state.product.name),
          _sectionTitle(localeBundle.photo),
          choosePhotoWidget(bloc),
          _sectionTitle(localeBundle.categoryMandatory),
          InfoText(text: "Choose one from existing or add new"),
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
              localeBundle.descriptionMandatory,
              "This product is...",
              InputType.text,
              (value) => bloc.add(FormChanged(product: bloc.state.product.copyWith(description: value))),
              bloc.state.product.description),
          _sectionTitle(localeBundle.unitTypeMandatory),
          DropdownButton<ProductUnitResponse>(
              isExpanded: true,
              onChanged: (ProductUnitResponse unit) {
                FocusScope.of(context).requestFocus(FocusNode());
                return bloc.add(FormChanged(
                    product: bloc.state.product.copyWith(
                        unit: unit,
                        productCustomizationWrappers:
                            unit.fractionable ? [] : bloc.state.product.productCustomizationWrappers)));
              },
              value: bloc.state.product?.unit,
              icon: Icon(Icons.arrow_drop_down),
              items: [
                for (ProductUnitResponse unit in bloc.state.unitTypes)
                  DropdownMenuItem<ProductUnitResponse>(
                    value: unit,
                    child: Text(unit.name),
                  )
              ]),
          Conditional.single(
              context: context,
              conditionBuilder: (_) => bloc.state.product?.unit != null,
              widgetBuilder: (_) => _field(
                  localeBundle.unitFractionMandatory,
                  (bloc.state.product.unit.fractionable
                      ? localeBundle.unitFractionFractionableExample
                      : localeBundle.unitFractionNonFractionableExample),
                  InputType.number,
                  (value) =>
                      bloc.add(FormChanged(product: bloc.state.product.copyWith(unitFraction: double.parse(value)))),
                  bloc.state.product?.unitFraction?.toString() ?? ""),
              fallbackBuilder: (_) => SizedBox.shrink()),
          _field(
              localeBundle.pricePerUnitMandatory,
              localeBundle.pricePerUnitExample,
              InputType.number,
              (value) => bloc.add(FormChanged(product: bloc.state.product.copyWith(price: double.parse(value)))),
              bloc.state.product?.price?.toString() ?? ""),
          _sectionTitle("Customizations"),
          SizedBox(
            height: 4.0,
          ),
          _customizationsList(context, bloc, bloc.state.product.productCustomizationWrappers),
          Wrap(
            children: [
              Conditional.single(
                  context: context,
                  conditionBuilder: (_) => bloc.state.product?.unit?.fractionable,
                  widgetBuilder: (_) => InfoText(text: "You cannot create customization for fractionable product"),
                  fallbackBuilder: (_) => ChoosableButton(
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
                      ))
            ],
          ),
          BlocBuilder<ManageProductBloc, ManageProductState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: SubmitFormButton(
                    text: pageTitle,
                    isActive: state.isFormFilled,
                    onTap: () => bloc.add(
                        FormSubmitted(productId: productId, photo: bloc.state.photo, product: bloc.state.product))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customizationsList(
      BuildContext context, ManageProductBloc bloc, List<ProductCustomizationWrapperRequest> customizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (ProductCustomizationWrapperRequest customization in customizations)
          ChoosableButtonWithSubText(
            text: customization.heading + (customization.required ? "*" : ""),
            subText: "${describeEnum(customization.type)} type, ${customization.customizations.length} options",
            isChosen: false,
            chooseAction: () async => bloc.add(EditCustomization(
                customizationIndex: customizations.indexOf(customization),
                customization:
                    await showDialog(context: context, child: CustomizationDialog(customization: customization)))),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => bloc.add(CustomizationRemoved(customization: customization)),
            ),
          )
      ],
    );
  }

  Widget _categoriesTrailingButton(BuildContext context, ManageProductBloc bloc) {
    return bloc.state.addedCategory != null ? _addedCategoryButton(context, bloc) : _addCategoryButton(context, bloc);
  }

  Widget _addedCategoryButton(BuildContext context, ManageProductBloc bloc) {
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

  Widget _addCategoryButton(BuildContext context, ManageProductBloc bloc) {
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

  Widget _field(String text, String hint, InputType inputType, Function(String) onChanged, String initialValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: themeConfig.textStyles.secondaryTitle,
        ),
        DhPlainTextFormField(hintText: hint, inputType: inputType, onChanged: onChanged, initialValue: initialValue)
      ],
    );
  }

  Widget choosePhotoWidget(ManageProductBloc bloc) {
    return BlocBuilder<ManageProductBloc, ManageProductState>(
        buildWhen: (previous, current) => previous.photo != current.photo,
        builder: (context, state) => Conditional.single(
            context: context,
            conditionBuilder: (_) => bloc.state.photo != null,
            widgetBuilder: (_) => Stack(
                  children: [
                    GestureDetector(
                        onTap: () async =>
                            bloc.add(PhotoChanged(photo: await picker.getImage(source: ImageSource.gallery))),
                        child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(color: themeConfig.colors.primary1)),
                              child: ClipRRect(child: bloc.state.photo),
                            ))),
                    ChoosableButton(text: "Remove", chooseAction: () => bloc.add(PhotoChanged(photo: null)))
                  ],
                ),
            fallbackBuilder: (_) => Wrap(
                  children: [
                    ChoosableButton(
                      text: "Add photo +",
                      chooseAction: () async =>
                          bloc.add(PhotoChanged(photo: await picker.getImage(source: ImageSource.gallery))),
                    ),
                  ],
                )));
  }
}
