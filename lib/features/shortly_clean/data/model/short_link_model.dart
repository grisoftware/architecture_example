// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../core/config/constants/hive_type_constants.dart';

part 'short_link_model.g.dart';

@HiveType(typeId: HiveTypeConstants.shortLinkTypeId)
class ShortLinkModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String fullShortLink;
  @HiveField(2)
  bool isCopied;

  ShortLinkModel({
    required this.id,
    required this.fullShortLink,
    this.isCopied = false,
  });

  factory ShortLinkModel.fromJson(Map<String, dynamic> json) => ShortLinkModel(
      id: json['code'],
      fullShortLink: json['full_short_link'],
      isCopied: false);

  @override
  List<Object?> get props => [id, fullShortLink, isCopied];
}
