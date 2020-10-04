import 'dart:io';

import 'package:drop_here_mobile/accounts/model/api/account_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/authentication_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_customers_request.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/company_products_request.dart';
import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/services/product_management_service.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_product_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/buyer_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/choose_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/client_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_details_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_admin_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/home_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/management_page.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SandboxPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final AssetsConfig assetsConfig = Get.find<AssetsConfig>();
  final AuthenticationService authenticationService = Get.find<AuthenticationService>();
  final CompanyManagementService companyManagementService = Get.find<CompanyManagementService>();
  final AccountService accountService = Get.find<AccountService>();
  final ProductManagementService productManagementService = Get.find<ProductManagementService>();
  final picker = ImagePicker();
  NetworkImage img;

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
                    child: Text("buyer details registration"),
                    onPressed: () {
                      Get.to(BuyerDetailsRegistrationPage());
                    },
                  ),
                  FlatButton(
                    child: Text("seller details registration"),
                    onPressed: () {
                      Get.to(CompanyDetailsRegistrationPage());
                    },
                  ),
                  FlatButton(
                    child: Text("company details"),
                    onPressed: () {
                      Get.to(CompanyDetailsPage());
                    },
                  ),
                  FlatButton(
                    child: Text("client details"),
                    onPressed: () {
                      Get.to(ClientDetailsPage());
                    },
                  ),
                  FlatButton(
                    child: Text("add product"),
                    onPressed: () {
                      Get.to(AddProductPage());
                    },
                  ),
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
                    child: Text("choose profile page"),
                    onPressed: () {
                      Get.to(ChooseProfilePage());
                    },
                  ),
                  FlatButton(
                    child: Text("create admin profile"),
                    onPressed: () {
                      Get.to(CreateAdminProfilePage());
                    },
                  ),
                  FlatButton(
                      child: Text("Log in to account"),
                      onPressed: () => authenticationService
                          .authenticate(LoginRequest(mail: "test@g.pl", password: "test1234"))),
                  FlatButton(
                      child: Text("Log in to admin profile"),
                      onPressed: () async {
                        List<ProfileInfoResponse> profileInfoResponse =
                            await accountService.fetchProfiles();
                        authenticationService.loginToProfile(ProfileLoginRequest(
                            profileUid: profileInfoResponse
                                .firstWhere((element) => element.profileType == ProfileType.MAIN)
                                .profileUid,
                            password: "test1234"));
                      }),
                  FlatButton(
                      child: Text("log out from account"),
                      onPressed: () => authenticationService.deleteToken()),
                  FlatButton(
                    child: Text("fetch clients"),
                    onPressed: () {
                      companyManagementService
                          .getCompanyCustomers(CompanyCustomersRequest()..blocked = true);
                    },
                  ),
                  FlatButton(
                      child: Text("get account details"),
                      onPressed: () => companyManagementService.getCompanyInfo()),
                  FlatButton(
                      child: Text("fetch products"),
                      onPressed: () async {
                        productManagementService.getCompanyProducts(CompanyProductsRequest());
                      }),
                  FlatButton(
                    child: Text('upload photo'),
                    onPressed: () async {
                      File photo = await getImage();
                      ResourceOperationResponse response =
                          await companyManagementService.uploadCompanyPhoto(photo);
                      print(response);
                    },
                  ),
                  FutureBuilder(
                      future: companyManagementService.getCompanyPhoto(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(backgroundImage: snapshot.data);
                        } else
                          return SizedBox.shrink();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }
}
