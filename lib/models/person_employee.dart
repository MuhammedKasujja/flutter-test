// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:flutter_objectbox/models/base_model.dart';

abstract class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void displayInfo();
}

abstract class Employee {
  int employeeId;
  String department;

  Employee(this.employeeId, this.department);

  void work();
}

class PersonEmployee implements Person, Employee {
  @override
  int age;

  @override
  String name;

  @override
  void displayInfo() {
    print("This is info");
  }

  @override
  String department;

  @override
  int employeeId;
  PersonEmployee({
    required this.age,
    required this.name,
    required this.department,
    required this.employeeId,
  });

  @override
  void work() {
    print("Person working");
  }
}

@Entity()
class Manager extends BaseModelImp<Manager> implements BaseModel {
  @Id()
  int id;
  String name;
  @override
  DateTime? createdAt;
  @override
  DateTime? deletedAt;
  @override
  DateTime? updatedAt;
  bool isDeleted;

  Manager({
    this.id = 0,
    required this.name,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.isDeleted = false,
  }) : super(
          isDeleted: isDeleted,
          createdAt: createdAt,
          deletedAt: deletedAt,
          updatedAt: updatedAt,
        );

  @override
  Manager delete() {
    return super.deleteModel(this);
  }

  @override
  Manager forceDelete() {
    return super.forceDeleteModel(this);
  }

  @override
  Manager restore() {
    return super.restoreModel(this);
  }

  @override
  Manager save() {
    return super.saveModel(this);
  }

  @override
  bool isTrashed() {
    return super.trashed();
  }

  @override
  Manager update() {
    return super.updateModel(this);
  }
}
