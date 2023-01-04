// const String uri = String.fromEnvironment(
//   'SPRINGBOOT_HOST',
//   defaultValue: 'https://plantngo.potatovault.com',
// );

// const String uri = String.fromEnvironment(
//   'SPRINGBOOT_HOST',
//   defaultValue: 'http://172.20.10.6:8080',
// );

import 'package:intl/intl.dart';

const String uri = String.fromEnvironment(
  'SPRINGBOOT_HOST',
  defaultValue: 'http://localhost:8080',
);

final formatGreenPoints = NumberFormat('###,###,### points');
final formatEmission = NumberFormat('###,###,### gCO2e');
final formatEmissionLong = NumberFormat('###,###,###.00 gCO2e');
final formatMoney = NumberFormat('S\$###,###,###.00');
final formatDistance = NumberFormat('###,###,###.00 km');
