import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/edit_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/info_text.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_circled_info.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/model/units.dart';
import 'package:drop_here_mobile/products/ui/pages/manage_product_page.dart';
import 'package:drop_here_mobile/routes/ui/widgets/drop_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final ProductResponse product;
  final bool editable;
  final VoidCallback backAction;

  ProductDetailsPage({this.product, this.editable = true, this.backAction});

  @override
  Widget build(BuildContext context) {
    final LocaleBundle localeBundle = Localization.of(context).bundle;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            DhBackButton(
              backAction: backAction,
              padding: EdgeInsets.zero,
            ),
            pageTitle(product.name),
            pageSubtitle(product.category),
            buildInfoWithLabel(localeBundle, localeBundle.description, product.description),
            LabeledCircledInfo(label: localeBundle.unitType, text: product.unit),
            Divider(),
            LabeledCircledInfo(label: localeBundle.price, text: product.productPrice),
            Divider(),
            LabeledCircledInfo(label: localeBundle.unitFraction, text: product.unitFraction.toString()),
            sectionTitle("Customizations"),
            Conditional.single(
                context: context,
                conditionBuilder: (_) => Units.isUnitFractionable[product.unit] ?? false,
                widgetBuilder: (_) => InfoText(
                      text: "This product cannot have any customizations",
                    ),
                fallbackBuilder: (_) => customizationsList(context, product.customizationsWrappers)),
            sectionTitle(localeBundle.availableInDrops),
            dropsCarousel()
          ],
        ),
      ),
    );
  }

  Widget pageTitle(String text) {
    return Wrap(
      children: [
        Text(
          text,
          style: themeConfig.textStyles.primaryTitle,
        ),
        SizedBox(
          width: 10.0,
        ),
        editable
            ? editButton(onPressed: () {
                Get.to(EditProductPage(
                  initialProduct: product.toRequest(),
                  productIdentify: product.id,
                ));
              })
            : SizedBox.shrink(),
      ],
    );
  }

  Widget pageSubtitle(String text) {
    return Text(
      text,
      style: themeConfig.textStyles.category,
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: themeConfig.textStyles.title2,
      ),
    );
  }

  Widget buildInfoWithLabel(LocaleBundle localeBundle, String label, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          label,
          style: themeConfig.textStyles.dataAnnotation,
        ),
        Text(
          content ?? localeBundle.noContent,
          style: themeConfig.textStyles.data,
        )
      ]),
    );
  }

  Widget customizationsList(BuildContext context, List<ProductCustomizationWrapperResponse> customizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoText(text: "- is obligatory", iconType: Icons.star),
        Conditional.single(
            context: context,
            conditionBuilder: (_) => customizations != null,
            widgetBuilder: (_) => buildCustomizationsTilesList(context, customizations),
            fallbackBuilder: (_) => SizedBox.shrink())
      ],
    );
  }

  Widget buildCustomizationsTilesList(BuildContext context, List<ProductCustomizationWrapperResponse> customizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (ProductCustomizationWrapperResponse customization in customizations)
          buildCustomizationTile(context, customization)
      ],
    );
  }

  Widget buildCustomizationTile(BuildContext context, ProductCustomizationWrapperResponse customization) {
    return ChoosableButtonWithSubText(
        text: customization.heading,
        subText: "${describeEnum(customization.type)} type, ${customization.customizations.length} options",
        chooseAction: () async =>
            await showDialog(context: context, child: customizationDetailsDialog(context, customization)),
        isChosen: false,
        trailing: customization.required ? Icon(Icons.star, size: 30.0) : SizedBox.shrink());
  }

  Widget customizationDetailsDialog(BuildContext context, ProductCustomizationWrapperResponse customization) {
    return AlertDialog(
      title: Align(
          child: Text(
        customization.heading,
        style: themeConfig.textStyles.title2,
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabeledCircledInfo(label: "Type", text: describeEnum(customization.type)),
          Divider(),
          LabeledCircledInfo(label: "Obligatory", text: customization.required ? "YES" : "NO"),
          Align(
              child: Text(
            "Values",
            style: themeConfig.textStyles.title2,
          )),
          for (ProductCustomizationResponse option in customization.customizations)
            LabeledCircledInfo(label: option.value, text: option.priceWithCurrency)
        ],
      ),
      actions: [
        GestureDetector(
          child: Text(
            "Close",
            style: themeConfig.textStyles.blocked.copyWith(fontSize: 20.0),
          ),
          onTap: () => Navigator.pop(context, null),
        ),
      ],
    );
  }

  Widget dropsCarousel() {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 14 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.5,
        ),
        items: product.drops.map((drop) => CompanyProductDetailsDropCard(drop: drop)).toList());
  }
}
