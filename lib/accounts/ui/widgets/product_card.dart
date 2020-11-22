import 'package:drop_here_mobile/accounts/bloc/list_bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dh_shadow.dart';

class ProductCard extends StatelessWidget {
  final ProductResponse product;
  final List<String> popupOptions;
  final DhListBloc bloc;
  final VoidCallback onTap;

  const ProductCard({this.product, this.popupOptions, this.bloc, this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: Container(
        child: ListTile(
          onTap: onTap,
          leading: productPhoto(context),
          title: Text(
            product.name,
            style: themeConfig.textStyles.secondaryTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Text(
                product.category,
                style: themeConfig.textStyles.cardSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                '${removeDecimalZeroFormat(product.price)}${locale.currency}/${product.unit}',
                style: themeConfig.textStyles.cardSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: popupOptions != null
              ? PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: themeConfig.colors.black,
                    size: 30.0,
                  ),
                  onSelected: (value) => bloc.add(DeleteProduct(productId: product.id)),
                  itemBuilder: (BuildContext context) {
                    return popupOptions.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: themeConfig.textStyles.popupMenu,
                        ),
                      );
                    }).toList();
                  },
                )
              : SizedBox.shrink(),
        ),
        decoration: BoxDecoration(
          color: themeConfig.colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            dhShadow(),
          ],
        ),
      ),
    );
  }

  Widget productPhoto(BuildContext context) {
    return Container(
      width: 74.0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 74,
          maxHeight: 84,
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Icon(Icons.shopping_basket)),
      ),
    );
  }
}
