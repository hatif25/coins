import 'package:coin/domain/usecase/scratch_card_usecase.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('Scratch card gives a reward between 50 and 500 coins', () {
    final scratchCardUseCase = ScratchCardUseCase();
    final reward = scratchCardUseCase.scratch();
    expect(reward, inInclusiveRange(50, 500));
  });
}
