import "package:objectbox/objectbox.dart";

import "category.dart";

@Entity()
class Transaction {
  @Id()
  int id = 0;
  DateTime date;
  String comment;
  ToOne<Category> category = ToOne<Category>();
  double amount;

  set updateDate(DateTime newDateTime) => date = newDateTime;
  set updateComment(String newComment) => comment = newComment;
  set updateCategory(Category newCategory) => category.target = newCategory;
  set updateAmount(double newAmount) => amount = newAmount;

  Transaction({
    required this.date,
    required this.comment,
    required this.amount,
  });
}
