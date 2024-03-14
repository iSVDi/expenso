import "package:objectbox/objectbox.dart";

import "category.dart";

@Entity()
class Transaction {
  @Id()
  int id = 0;
  final DateTime date;
  final String comment;
  final category = ToOne<Category>();
  final double amount;

  Transaction({
    required this.date,
    required this.comment,
    required this.amount,
  });
}
