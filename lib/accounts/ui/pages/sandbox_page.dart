import 'dart:io';

import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_customers_request.dart';
import 'package:drop_here_mobile/accounts/model/api/customer_management_api.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/services/customer_management_service.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_product_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_route_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_new_item_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/home_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/management_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/map_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/product_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/products_list_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/spot_details_page.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/notifications/services/push_notifications_service.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/routes/ui/pages/route_details_page.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:drop_here_mobile/spots/services/spots_user_service.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:drop_here_mobile/spots/ui/pages/spots_map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'add_drop_to_route_page.dart';
import 'add_spot_page.dart';
import 'edit_product_page.dart';
import 'edit_spot_page.dart';

class SandboxPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final AssetsConfig assetsConfig = Get.find<AssetsConfig>();
  final AuthenticationService authenticationService = Get.find<AuthenticationService>();
  final PushNotificationsConfigurationService notificationsConfigurationService = Get.find<PushNotificationsConfigurationService>();
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
                    child: Text("initialize firebase"),
                    onPressed: () async {
                      await notificationsConfigurationService.configurePushNotifications();
                    }),
                FlatButton(
                    child: Text("add product"),
                    onPressed: () {
                      Get.to(AddProductPage());
                    }),
                FlatButton(
                    child: Text("route details"),
                    onPressed: () {
                      Get.to(RouteDetailsPage(routeId: 2));
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
                    child: Text("add spot"),
                    onPressed: () {
                      Get.to(AddSpotPage());
                    }),
                FlatButton(
                    child: Text("edit product"),
                    onPressed: () {
                      Get.to(EditProductPage());
                    }),
                FlatButton(
                    child: Text("edit spot"),
                    onPressed: () {
                      Get.to(EditSpotPage());
                    }),
                FlatButton(
                    child: Text("clients list"),
                    onPressed: () {
                      Get.to(ManagementPage());
                    }),
                FlatButton(
                  child: Text("home page"),
                  onPressed: () {
                    Get.to(Home());
                  },
                ),
                FlatButton(
                  child: Text("spot details page"),
                  onPressed: () {
                    Get.to(CompanySpotDetailsPage(spot: SpotCompanyResponse()));
                  },
                ),
                FlatButton(
                  child: Text("create new item page"),
                  onPressed: () {
                    Get.to(CreateNewItemPage());
                  },
                ),
                FlatButton(
                  child: Text("product details page"),
                  onPressed: () {
                    Get.to(ProductDetailsPage(
                      photo: File(
                          //TODO change this file
                          '/data/user/0/com.example.drop_here_mobile/cache/image_picker5158575234322302316.jpg'),
                    ));
                  },
                ),
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
                  child: Text("create admin profile"),
                  onPressed: () {
                    Get.to(CreateAdminProfilePage());
                  },
                ),
                FlatButton(
                    child: Text("Log in to company account"),
                    onPressed: () => authenticationService
                        .authenticate(LoginRequest(mail: "zrobilem@g.pl", password: "12345678"))),
                FlatButton(
                    child: Text("Log in to admin profile"),
                    onPressed: () async {
                      List<ProfileInfoResponse> profileInfoResponse =
                          await accountService.fetchProfiles();
                      authenticationService.loginToProfile(ProfileLoginRequest(
                          profileUid: profileInfoResponse
                              .firstWhere((element) => element.profileType == ProfileType.MAIN)
                              .profileUid,
                          password: "12345678"));
                    }),
                FlatButton(
                    child: Text("Log in to customer account"),
                    onPressed: () => authenticationService
                        .authenticate(LoginRequest(mail: "klient@g.pl", password: "12345678"))),
                FlatButton(
                    child: Text("log out from account"),
                    onPressed: () => authenticationService.logOutFromAccount()),
                FlatButton(
                    child: Text("fetch account details"),
                    onPressed: () => accountService.fetchAccountDetails()),
                FlatButton(
                  child: Text("fetch clients"),
                  onPressed: () {
                    companyManagementService
                        .getCompanyCustomers(CompanyCustomersRequest()..blocked = true);
                  },
                ),
                FlatButton(
                    child: Text("get spots (client)"),
                    onPressed: () async => spotsUserService.getSpots(SpotCustomerRequest(
                        member: false,
                        namePrefix: "",
                        radius: 20000,
                        xCoordinate: 54.397498,
                        yCoordinate: 18.589627))),
                FlatButton(
                    child: Text("get customer details"),
                    onPressed: () => customerManagementService.getCustomerInfo()),
                FlatButton(
                    child: Text("update customer details"),
                    onPressed: () => customerManagementService.updateCustomerInfo(
                        CustomerManagementRequest(firstName: "Piotr", lastName: "Maszota"))),
                FlatButton(child: Text("map page"), onPressed: () => Get.to(MapPage())),
                FlatButton(
                    child: Text("fetch profiles"),
                    onPressed: () async {
                      accountService.fetchProfiles();
                    }),
                FlatButton(
                    child: Text("fetch spots"),
                    onPressed: () async {
                      spotManagementService.fetchCompanySpots();
                    }),
                FlatButton(
                    child: Text("company spots map page"),
                    onPressed: () => Get.to(CompanyMapPage())),
                FlatButton(
                    child: Text("customer spots map page"),
                    onPressed: () => Get.offAll(CustomerMapPage())),
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
