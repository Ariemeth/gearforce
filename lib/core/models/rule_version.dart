enum RuleVersion {
  v3_1('3.1', 'v3', '/v3'),
  v4_0('4.0', 'v4', '/v4');

  const RuleVersion(this.versionName, this.code, this.routePath);

  final String versionName;
  final String code;
  final String routePath;

  static RuleVersion fromCode(String code) {
    return RuleVersion.values.firstWhere(
      (v) => v.code == code || v.versionName == code,
      orElse: () => RuleVersion.v4_0,
    );
  }
}
