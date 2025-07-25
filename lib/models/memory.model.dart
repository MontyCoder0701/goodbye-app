import 'base.model.dart';

class Memory extends BaseModel {
  final String memo;
  final DateTime createdAt;

  Memory({required this.memo, required this.createdAt});
}
