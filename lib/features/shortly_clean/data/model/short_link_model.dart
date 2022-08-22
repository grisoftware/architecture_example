// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ShortLinkModel extends Equatable {
  final String id;
  final String fullShortLink;
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
