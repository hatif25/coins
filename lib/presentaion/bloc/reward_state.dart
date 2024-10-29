abstract class RewardState {
  final int balance;

  RewardState(this.balance);
}

class RewardInitial extends RewardState {
  RewardInitial({required int balance}) : super(balance);
}

class BalanceUpdated extends RewardState {
  BalanceUpdated(int balance) : super(balance);
}

class RedemptionSuccess extends RewardState {
  RedemptionSuccess(int balance) : super(balance);
}

class RedemptionFailure extends RewardState {
  RedemptionFailure(int balance) : super(balance);
}
