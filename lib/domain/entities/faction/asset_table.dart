import 'package:flutter/cupertino.dart';

///
/// The AssetTable indicates the available asset types a ruleset or faction has
/// available.  A null value indicates it is unlimited.
///
@immutable
class AssetTable {
  final int? greenSquads;
  final int? regularSquads;
  final int? veteranSquads;
  final int? eliteSquads;
  final int? duelistOrAces;
  final int? airSupport;
  final int? artillerySupport;
  final int? droneSupport;

  const AssetTable({
    this.greenSquads,
    this.regularSquads,
    this.veteranSquads,
    this.eliteSquads,
    this.duelistOrAces,
    this.airSupport,
    this.artillerySupport,
    this.droneSupport,
  });

  // Named constructor for unlimited assets
  const AssetTable.unlimited()
    : greenSquads = null,
      regularSquads = null,
      veteranSquads = null,
      eliteSquads = null,
      duelistOrAces = null,
      airSupport = null,
      artillerySupport = null,
      droneSupport = null;
}
