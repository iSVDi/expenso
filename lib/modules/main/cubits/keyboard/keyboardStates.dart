abstract class KeyboardState<T> {
  T data;
  KeyboardState({
    required this.data,
  });
}

class EnteringAmountState extends KeyboardState<String> {
  EnteringAmountState({required super.data});
}