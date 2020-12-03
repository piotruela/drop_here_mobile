import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DHAssetsConfig extends AssetsConfig {
  @override
  String get appLogo => "assets/images/app_logo.svg";

  @override
  String get buyerImage => "assets/images/buyer.svg";

  @override
  String get sellerImage => "assets/images/seller.svg";

  @override
  String get splashScreenImage => "assets/images/first_page_image.svg";

  @override
  String get ph => "assets/images/ph.png";

  @override
  Future<BitmapDescriptor> get spotPin async => await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)), 'assets/images/pin_icon.png');
}
