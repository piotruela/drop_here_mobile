import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class AssetsConfig {
  String get buyerImage;
  String get sellerImage;
  String get splashScreenImage;
  String get appLogo;
  String get ph;
  Future<BitmapDescriptor> get spotPin;
}
