abstract class KeyboardState<T> {
  T data;
  KeyboardState({
    required this.data,
  });
}

//* KeyboardState<(AmountString, Transaction DateTime)>
class EnteringBasicDataState extends KeyboardState<(String, DateTime)> {
  EnteringBasicDataState({required super.data});
  // EnteringBasicDataState({required super.data});
}

class SelectingDateState extends KeyboardState<DateTime> {
  SelectingDateState({required super.data});
}
