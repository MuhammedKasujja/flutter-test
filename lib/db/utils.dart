import 'package:flutter_objectbox/db/objectbox.dart';

T saveEntity<T>(T entity) {
  final box = ObjectBox.instance.store.box<T>();
  final entityId = box.put(entity);
  return box.get(entityId) ?? entity;
}
