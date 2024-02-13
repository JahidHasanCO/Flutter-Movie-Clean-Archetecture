import 'package:floor/floor.dart';

class ListIntConverter extends TypeConverter<List<int>?, String?> {
  @override
  List<int>? decode(String? databaseValue) {
    if (databaseValue == null) return null;
    final List<dynamic> list = List<dynamic>.from(databaseValue.split(','));
    return list.map((dynamic item) => item as int).toList();
  }

  @override
  String? encode(List<int>? value) {
    return value?.join(',');
  }
}
