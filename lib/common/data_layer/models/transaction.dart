import "package:objectbox/objectbox.dart";

import "category.dart";

@Entity()
class Transaction {
  @Id()
  int id = 0;
  DateTime date;
  String comment;
  ToOne<Category> category = ToOne<Category>();
  int amount;

  Transaction({
    required this.date,
    required this.comment,
    required this.amount,
  });

  Transaction.empty({
    required this.date,
    this.comment = "",
    this.amount = 0,
  });
}
