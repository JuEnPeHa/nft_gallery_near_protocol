import 'package:json_annotation/json_annotation.dart';

part 'metadataParas.g.dart';

class MetadataParas {
  final String title;
  final String description;
  final String media;
  @JsonKey(name: "media_hash")
  final String? mediaHash;
  final int copies;
  @JsonKey(name: "issued_at")
  final String issuedAt;
  @JsonKey(name: "expires_at")
  final Object? expiresAt;
  @JsonKey(name: "starts_at")
  final Object? startsAt;
  @JsonKey(name: "updated_at")
  final Object? updatedAt;
  final String? extra;
  final String? reference;
  @JsonKey(name: "reference_hash")
  final String? referenceHash;

  MetadataParas({
    required this.title,
    required this.description,
    required this.media,
    this.mediaHash,
    required this.copies,
    required this.issuedAt,
    this.expiresAt,
    this.startsAt,
    this.updatedAt,
    this.extra,
    this.reference,
    this.referenceHash,
  });

  factory MetadataParas.fromJson(Map<String, dynamic> json) =>
      _$MetadataParasFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataParasToJson(this);

  @override
  String toString() {
    return 'MetadataParas{title: $title, description: $description, media: $media, mediaHash: $mediaHash, copies: $copies, issuedAt: $issuedAt, expiresAt: $expiresAt, startsAt: $startsAt, updatedAt: $updatedAt, extra: $extra, reference: $reference, referenceHash: $referenceHash}';
  }
}
