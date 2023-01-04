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

final pointsFormatter = NumberFormat('###,###,###');
