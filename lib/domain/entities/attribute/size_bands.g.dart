// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_bands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeBands<T> _$SizeBandsFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => SizeBands<T>(
  l: fromJsonT(json['l']),
  m: fromJsonT(json['m']),
  h: fromJsonT(json['h']),
);

Map<String, dynamic> _$SizeBandsToJson<T>(
  SizeBands<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'l': toJsonT(instance.l),
  'm': toJsonT(instance.m),
  'h': toJsonT(instance.h),
};

TraitSizeBands _$TraitSizeBandsFromJson(Map<String, dynamic> json) =>
    TraitSizeBands(
      l: json['l'] == null
          ? const []
          : const TraitListConverter().fromJson(json['l'] as List),
      m: json['m'] == null
          ? const []
          : const TraitListConverter().fromJson(json['m'] as List),
      h: json['h'] == null
          ? const []
          : const TraitListConverter().fromJson(json['h'] as List),
    );

Map<String, dynamic> _$TraitSizeBandsToJson(TraitSizeBands instance) =>
    <String, dynamic>{
      'l': const TraitListConverter().toJson(instance.l),
      'm': const TraitListConverter().toJson(instance.m),
      'h': const TraitListConverter().toJson(instance.h),
    };

DamageSizeBands _$DamageSizeBandsFromJson(Map<String, dynamic> json) =>
    DamageSizeBands(
      l: (json['l'] as num).toInt(),
      m: (json['m'] as num).toInt(),
      h: (json['h'] as num).toInt(),
    );

Map<String, dynamic> _$DamageSizeBandsToJson(DamageSizeBands instance) =>
    <String, dynamic>{'l': instance.l, 'm': instance.m, 'h': instance.h};
