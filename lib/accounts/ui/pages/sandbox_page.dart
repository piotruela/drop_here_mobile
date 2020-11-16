import 'dart:io';

import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_customers_request.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/services/customer_management_service.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/products/model/api/page_api.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/shipments/ui/pages/dashboard_page.dart';
import 'package:drop_here_mobile/shipments/ui/pages/shipment_details_page.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:drop_here_mobile/spots/services/spots_user_service.dart';
import 'package:drop_here_mobile/spots/ui/pages/company_map_page.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../management/ui/pages/client_details_management_page.dart';

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
                    child: Text("client details management"),
                    onPressed: () async {
                      Page page = await companyManagementService
                          .getCompanyCustomers(CompanyCustomersRequest());
                      Get.to(ClientDetailsManagementPage(page.content.first));
                    }),
                FlatButton(
                    child: Text("Shipment details page"),
                    onPressed: () => Get.to(ShipmentDetailsPage(shipmentId: 123))),
                FlatButton(
                    child: Text("Dashboard page"),
                    onPressed: () {
                      Get.to(DashboardPage());
                    }),
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
                        .authenticate(LoginRequest(mail: "abc@abc.com", password: "12345678"))),
                //authenticationService.authenticate(LoginRequest(mail: "klient@g.pl", password: "12345678"))),
                FlatButton(
                    child: Text("log out from account"),
                    onPressed: () => authenticationService.logOutFromAccount()),
                FlatButton(
                    child: Text("company spots map page"),
                    onPressed: () => Get.to(CompanyMapPage())),
                FlatButton(
                    child: Text("customer spots map page"),
                    onPressed: () => Get.to(CustomerMapPage())),
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
