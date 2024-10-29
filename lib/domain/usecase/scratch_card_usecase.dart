import 'dart:math';

class ScratchCardUseCase {
  int scratch() {
    return Random().nextInt(451) + 50;
  }
}
