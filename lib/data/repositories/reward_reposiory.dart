



import 'package:coin/data/models/reward_model.dart';
import '../models/transaction_model.dart';

class RewardRepository {
  int _balance = 1000;
  List<RewardModel> rewards = [
    RewardModel(id: '1', name: 'Discount Coupon', coinCost: 300),
    RewardModel(id: '2', name: 'Gift Card', coinCost: 500),
  ];

  List<TransactionModel> transactions = [];

  int getBalance() => _balance;

  List<RewardModel> getRewards() => rewards;

  List<TransactionModel> getTransactions() => transactions;

  bool redeemReward(int cost) {
    if (_balance >= cost) {
      _balance -= cost;
      transactions.add(TransactionModel(
        type: 'Redeemed Item',
        date: DateTime.now().toString(),
        amount: -cost,
      ));
      return true;
    }
    return false;
  }

  void addReward(int amount) {
    _balance += amount;
    transactions.add(TransactionModel(
      type: 'Scratch Card Reward',
      date: DateTime.now().toString(),
      amount: amount,
    ));
  }
}