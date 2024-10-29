import 'package:coin/domain/usecase/redeem_reward_usecase.dart';
import 'package:coin/domain/usecase/scratch_card_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reward_event.dart';
import 'reward_state.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final ScratchCardUseCase scratchUseCase;
  final RedeemRewardUseCase redeemUseCase;
  int balance = 1000;
  List<Map<String, dynamic>> transactions = [];

  RewardBloc(this.scratchUseCase, this.redeemUseCase) : super(RewardInitial(balance: 1000)) {
    on<ScratchCardEvent>((event, emit) {
      final reward = scratchUseCase.scratch();
      balance += reward;
      transactions.add({'type': 'Scratch Card Reward', 'date': DateTime.now().toString(), 'amount': reward});
      emit(BalanceUpdated(balance));
    });

    on<RedeemRewardEvent>((event, emit) {
      if (redeemUseCase.redeem(event.cost)) {
        balance -= event.cost;
        transactions.add({'type': 'Redeemed Item', 'date': DateTime.now().toString(), 'amount': -event.cost});
        emit(RedemptionSuccess(balance));
      } else {
        emit(RedemptionFailure(balance));
      }
    });
  }
}