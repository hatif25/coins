import 'package:coin/data/repositories/reward_reposiory.dart';
import 'package:coin/domain/usecase/redeem_reward_usecase.dart';
import 'package:coin/domain/usecase/scratch_card_usecase.dart';
import 'package:coin/presentaion/bloc/reward_bloc.dart';
import 'package:coin/presentaion/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    final repository = RewardRepository();
    final scratchCardUseCase = ScratchCardUseCase();
    final redeemRewardUseCase = RedeemRewardUseCase(repository);
    return BlocProvider(
      create: (_) => RewardBloc(scratchCardUseCase, redeemRewardUseCase),
      child: MaterialApp(
        title: 'Reward Coins App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}