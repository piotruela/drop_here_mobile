import 'dart:io';

import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/services/customer_management_service.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_route_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/manage_product_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/product_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/products_list_page.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/products/model/api/product_management_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/routes/routes_list_page.dart';
import 'package:drop_here_mobile/routes/ui/pages/edit_route_page.dart';
import 'package:drop_here_mobile/routes/ui/pages/route_details_page.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:drop_here_mobile/spots/services/spots_user_service.dart';
import 'package:drop_here_mobile/spots/ui/pages/company_map_page.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'add_drop_to_route_page.dart';

class SandboxPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final AssetsConfig assetsConfig = Get.find<AssetsConfig>();
  final AuthenticationService authenticationService = Get.find<AuthenticationService>();
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  final CustomerManagementService customerManagementService = Get.find<CustomerManagementService>();
  final AccountService accountService = Get.find<AccountService>();
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();
  final SpotsUserService spotsUserService = Get.find<SpotsUserService>();

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FlatButton(
                    child: Text("Add product"),
                    onPressed: () {
                      Get.to(AddProductPage());
                    }),
                FlatButton(
                    child: Text("edit product"),
                    onPressed: () {
                      Get.to(EditProductPage(
                        productIdentify: 12,
                        initialProduct: ProductManagementRequest(
                            category: "MOET",
                            name: "CHAMPAGNE",
                            description: "Desc",
                            price: 4.0,
                            unit: "kg",
                            unitFraction: 1,
                            productCustomizationWrappers: [
                              ProductCustomizationWrapperRequest(
                                  required: true,
                                  heading: "Korek",
                                  type: CustomizationType.SINGLE,
                                  customizations: [ProductCustomizationRequest(value: "czarny", price: 20)])
                            ]),
                      ));
                    }),
                FlatButton(
                    child: Text("Product details page"),
                    onPressed: () {
                      Get.to(ProductDetailsPage(
                        product: ProductResponse(
                            name: "Hot dog",
                            description: "Hot dog, hot dog, hot dog nanana",
                            category: "FOOD",
                            price: 4.99,
                            unit: "piece",
                            unitFraction: 1,
                            drops: [
                              DropProductResponse(
                                  name: "Drop No. 2",
                                  startTime: DateTime(2020, 02, 02, 12, 30),
                                  endTime: DateTime(2020, 02, 02, 13, 30),
                                  routeProduct:
                                      RouteProductProductResponse(limitedAmount: false, price: 3.9, amount: 15))
                            ],
                            productCustomizationWrappers: [
                              ProductCustomizationWrapperResponse(
                                  heading: "Roll type",
                                  required: true,
                                  type: CustomizationType.SINGLE,
                                  customizations: [
                                    ProductCustomizationResponse(value: "Classic", price: 0.0),
                                    ProductCustomizationResponse(value: "Wholemeal", price: 0.70)
                                  ])
                            ]),
                      ));
                    }),
                FlatButton(
                    child: Text("routes list"),
                    onPressed: () {
                      Get.to(RoutesListPage());
                    }),
                FlatButton(
                    child: Text("route details"),
                    onPressed: () {
                      Get.to(RouteDetailsPage(routeId: 2));
                    }),
                FlatButton(
                    child: Text("edit route"),
                    onPressed: () {
                      Get.to(EditRoutePage(routeId: 2));
                    }),
                FlatButton(
                    child: Text("add route"),
                    onPressed: () {
                      Get.to(AddRoutePage());
                    }),
                FlatButton(
                    child: Text("add drop to route"),
                    onPressed: () {
                      Get.to(AddDropToRoutePage(
                        addDrop: () {},
                      ));
                    }),
                FlatButton(
                  child: Text("choose profile page"),
                  onPressed: () {
                    Get.to(ChooseProfilePage());
                  },
                ),
                FlatButton(
                  child: Text("products list page"),
                  onPressed: () {
                    Get.to(ProductsListPage());
                  },
                ),
                FlatButton(
                    child: Text("Log in to company account"),
                    onPressed: () =>
                        authenticationService.authenticate(LoginRequest(mail: "zrobilem@g.pl", password: "12345678"))),
                FlatButton(
                    child: Text("Log in to admin profile"),
                    onPressed: () async {
                      List<ProfileInfoResponse> profileInfoResponse = await accountService.fetchProfiles();
                      authenticationService.loginToProfile(ProfileLoginRequest(
                          profileUid: profileInfoResponse
                              .firstWhere((element) => element.profileType == ProfileType.MAIN)
                              .profileUid,
                          password: "12345678"));
                    }),
                FlatButton(
                    child: Text("Log in to customer account"),
                    onPressed: () =>
                        authenticationService.authenticate(LoginRequest(mail: "klient@g.pl", password: "12345678"))),
                FlatButton(
                    child: Text("log out from account"), onPressed: () => authenticationService.logOutFromAccount()),
                FlatButton(child: Text("company spots map page"), onPressed: () => Get.to(CompanyMapPage())),
                FlatButton(child: Text("customer spots map page"), onPressed: () => Get.to(CustomerMapPage())),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }
}
