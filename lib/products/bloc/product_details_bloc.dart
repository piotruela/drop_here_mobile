import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import 'file:///E:/Piotr%20Maszota/inzynierka/drop_here_mobile/lib/products/services/product_management_service.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial());

  final ProductManagementService productManagementService = Get.find<ProductManagementService>();

  @override
  Stream<ProductDetailsState> mapEventToState(
    ProductDetailsEvent event,
  ) async* {
    if (event is FetchProductDetails) {
      final Product product = Product();
      product.name = 'Apple';
      product.category = 'Fruits';
      product.description = 'descdkfldsfk sdjflskd jfl;skdfj ';
      product.unit = 'kilograms';
      product.price = 6;
      product.unitFraction = 0.5;
      //await productManagementService.getCompanyProducts(CompanyProductsRequest());
      yield ProductDetailsFetched(product);
    }
  }
}
