abstract class RewardEvent {}

class ScratchCardEvent extends RewardEvent {}

class RedeemRewardEvent extends RewardEvent {
  final int cost;

  RedeemRewardEvent(this.cost);
}
