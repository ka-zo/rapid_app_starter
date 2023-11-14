import 'package:flutter_localization/flutter_localization.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Store only constants and finals as global variables

late final PackageInfo packageInfo;
final FlutterLocalization localization = FlutterLocalization.instance;
final Logger logger = Logger(
  printer: PrettyPrinter(),
);
