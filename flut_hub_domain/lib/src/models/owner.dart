import 'package:json_annotation/json_annotation.dart';

part 'owner.g.dart';

@JsonSerializable()
class Owner {
  final int id;
  final String login;
  @JsonKey(name: "avatar_url")
  final String avatar;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map toJson() => _$OwnerToJson(this);

  Owner({
    required this.id,
    required this.login,
    required this.avatar,
  });
}
