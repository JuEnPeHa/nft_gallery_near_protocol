import 'package:json_annotation/json_annotation.dart';

part 'resultReference.g.dart';

@JsonSerializable()
class ResultEveryNftReference {
  final String? title;
  final String? description;
  final String? media;
  @JsonKey(name: 'media_hash')
  final String? mediaHash;
  final int? copies;
  @JsonKey(name: 'expires_at')
  final Object? expiresAt;
  @JsonKey(name: 'starts_at')
  final Object? startsAt;
  final String? extra;
  final String reference;
  @JsonKey(name: 'reference_hash')
  final String? referenceHash;

  ResultEveryNftReference({
    required this.title,
    required this.description,
    required this.media,
    required this.mediaHash,
    required this.copies,
    required this.expiresAt,
    required this.startsAt,
    required this.extra,
    required this.reference,
    required this.referenceHash,
  });

  factory ResultEveryNftReference.fromJson(Map<String, dynamic> json) =>
      _$ResultEveryNftReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$ResultEveryNftReferenceToJson(this);

  @override
  String toString() {
    return 'ResultEveryNftReference{title: $title, description: $description, media: $media, mediaHash: $mediaHash, copies: $copies, expiresAt: $expiresAt, startsAt: $startsAt, extra: $extra, reference: $reference, referenceHash: $referenceHash}';
  }
}
