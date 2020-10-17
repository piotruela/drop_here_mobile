import 'package:geocoder/geocoder.dart';

Future<String> getAddressFromCoordinates(double y, double x) async {
  if (y == null || x == null) {
    return "null passed";
  }
  final coordinates = Coordinates(y, x);
  List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  Address first = addresses.first;
  return "${first.locality}, ${first.thoroughfare}";
}
