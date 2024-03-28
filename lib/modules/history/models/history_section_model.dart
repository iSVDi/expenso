import 'package:expenso/common/data_layer/models/transaction.dart';

class SectionHistory {
  String headerDate;
  String sum;
  List<Transaction> transactions;

  SectionHistory({
    required this.headerDate,
    required this.sum,
    required this.transactions,
  });
}
