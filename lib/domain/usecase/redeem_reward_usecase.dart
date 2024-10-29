import 'package:coin/data/repositories/reward_reposiory.dart';



class RedeemRewardUseCase {
  final RewardRepository repository;

  RedeemRewardUseCase(this.repository);

  bool redeem(int cost) {
    return repository.redeemReward(cost);
  }
}
