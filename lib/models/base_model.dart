import 'package:flutter_objectbox/db/utils.dart';

abstract class BaseModelImp<T> {
  bool isDeleted;
  DateTime? createdAt;
  DateTime? deletedAt;
  DateTime? updatedAt;
  BaseModelImp({
    required this.isDeleted,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
  });

  /// Check if this Entity was archived
  bool trashed() {
    return isDeleted;
  }

  /// Store/ persist the Entity [entity] in the db
  T saveModel(T entity) {
    createdAt ??= DateTime.now();
    updatedAt = DateTime.now();
    return saveEntity(entity);
  }

  /// Update the Entity [entity] properties
  T updateModel(T entity) {
    updatedAt = DateTime.now();
    return saveEntity(entity);
  }

  /// Archive this Entity [entity]
  T deleteModel(T entity) {
    isDeleted = true;
    deletedAt = DateTime.now();
    return saveEntity(entity);
  }

  /// Restore the Entity [entity] to active
  T restoreModel(T entity) {
    isDeleted = false;
    deletedAt = null;
    return saveEntity(entity);
  }

  /// Permanently delete the Entity [entity] from the db
  T forceDeleteModel(T entity) {
    return saveEntity(entity);
  }
}

abstract class BaseModel<T> {

  /// Check if this Entity was archived
  bool isTrashed();

  /// Store/ persist the Entity  in the db
  T save();

  /// Update the Entity  properties
  T update();

  /// Archive this Entity
  T delete();

  /// Restore the Entity  to active
  T restore();

  /// Permanently delete the Entity  from the db
  T forceDelete();
}
