import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reward_bloc.dart';
import '../bloc/reward_event.dart';
import '../bloc/reward_state.dart';
import 'redemption_store_screen.dart';
import 'history_screen.dart';
import '../widgets/balance_widget.dart';
import '../widgets/scratch_card_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reward Coins"),
        centerTitle: true,
      ),
      body: BlocBuilder<RewardBloc, RewardState>(
        builder: (context, state) {
          if (state is RewardInitial || state is BalanceUpdated || state is RedemptionSuccess || state is RedemptionFailure) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BalanceWidget(balance: state.balance),
                  SizedBox(height: 20),
                  ScratchCardWidget(),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RedemptionStoreScreen()),
                    ),
                    icon: Icon(Icons.card_giftcard),
                    label: Text("Redeem Rewards"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()),
                    ),
                    icon: Icon(Icons.history),
                    label: Text("View History"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}