import 'package:hive/hive.dart';

part 'social_data.g.dart';

@HiveType(typeId: 0)
class SocialData extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String username;
  @HiveField(2)
  String password;

  SocialData({
    this.title,
    this.username,
    this.password,
  });
}
