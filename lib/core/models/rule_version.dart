import 'package:gearforce/core/routing/app_route_names.dart';

enum RuleVersion {
  v3_1('3.1', 'v3', V3RouteNames.roster, '/v3'),
  v4_0('4.0', 'v4', V4RouteNames.roster, '/v4');

  const RuleVersion(
    this.versionName,
    this.code,
    this.routeName,
    this.routePath,
  );

  final String versionName;
  final String code;
  final String routeName;
  final String routePath;

  static RuleVersion fromCode(String code) {
    return RuleVersion.values.firstWhere(
      (v) => v.code == code || v.versionName == code,
      orElse: () => RuleVersion.v4_0,
    );
  }
}
