import 'package:objectbox/objectbox.dart';

abstract class NumberAvailabilityChecker {
  bool checkNumberAvailability(String number);
}

abstract class BaseEntity {
  DateTime? createdAt;
  double amount;
  String? details;
  BaseEntity({this.createdAt, required this.amount, this.details});
}

@Entity()
class ShopOrder extends BaseEntity implements NumberAvailabilityChecker {
  @Id()
  int id;
  int price;
  final customer = ToOne<Customer>();
  double amount;
  String? details;
  DateTime? createdAt;

  ShopOrder({
    this.id = 0,
    required this.price,
    this.createdAt,
    required this.amount,
    this.details,
  }) : super(
          amount: amount,
          createdAt: createdAt,
          details: details,
        );

  @override
  bool checkNumberAvailability(String number) {
    return true;
  }
}

@Entity()
class Customer implements NumberAvailabilityChecker {
  @Id()
  int id;
  String name;
  @Backlink("customer")
  final orders = ToMany<ShopOrder>();

  Customer({
    this.id = 0,
    required this.name,
  });

  @override
  bool checkNumberAvailability(String number) {
    return true;
  }
}
