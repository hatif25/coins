import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc.dart';
import '../bloc/reward_event.dart';
import '../../data/models/reward_model.dart';

class RedemptionStoreScreen extends StatelessWidget {
  final List<RewardModel> rewards = [
    RewardModel(id: '1', name: 'Discount Coupon', coinCost: 300),
    RewardModel(id: '2', name: 'Gift Card', coinCost: 500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Rewards"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            final reward = rewards[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.card_giftcard, color: Colors.blue),
                title: Text(
                  reward.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${reward.coinCost} coins'),
                trailing: ElevatedButton(
                  onPressed: () => context.read<RewardBloc>().add(RedeemRewardEvent(reward.coinCost)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text("Redeem"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}