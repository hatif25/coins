import 'package:coin/data/repositories/reward_reposiory.dart';
import 'package:coin/domain/usecase/redeem_reward_usecase.dart';
import 'package:coin/domain/usecase/scratch_card_usecase.dart';
import 'package:coin/presentaion/bloc/reward_bloc.dart';
import 'package:coin/presentaion/bloc/reward_event.dart';
import 'package:coin/presentaion/bloc/reward_state.dart';
import 'package:coin/presentaion/screens/history_screen.dart';
import 'package:coin/presentaion/screens/home_screen.dart';
import 'package:coin/presentaion/screens/redemption_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRewardBloc extends Mock implements RewardBloc {}

void main() {
  late RewardBloc rewardBloc;
  late ScratchCardUseCase scratchUseCase;
  late RedeemRewardUseCase redeemUseCase;
  late RewardRepository repository;

  setUp(() {
    repository = RewardRepository();
    scratchUseCase = ScratchCardUseCase();
    redeemUseCase = RedeemRewardUseCase(repository);
    rewardBloc = MockRewardBloc();
  });

  testWidgets('View History button shows No transactions available when transactions is null', (WidgetTester tester) async {
    when(() => rewardBloc.transactions).thenReturn([]);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RewardBloc>(
          create: (context) => rewardBloc,
          child: HistoryScreen(),
        ),
      ),
    );

    expect(find.text('Transaction History'), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.text('No transactions available'), findsOneWidget);
  });

  testWidgets('View History button shows transactions when not null', (WidgetTester tester) async {
    final mockTransactions = [
      {'type': 'Redeem', 'date': '2023-10-01', 'amount': 100},
      {'type': 'Scratch', 'date': '2023-10-02', 'amount': 50},
    ];
    when(() => rewardBloc.transactions).thenReturn(mockTransactions);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RewardBloc>(
          create: (context) => rewardBloc,
          child: HistoryScreen(),
        ),
      ),
    );

    expect(find.text('Transaction History'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Redeem'), findsOneWidget);
    expect(find.text('Scratch'), findsOneWidget);
  });

  testWidgets('Scratch Card button updates balance', (WidgetTester tester) async {
    when(() => rewardBloc.state).thenReturn(RewardInitial(balance: 1000));
    when(() => rewardBloc.scratchUseCase.scratch()).thenReturn(100);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RewardBloc>(
          create: (context) => rewardBloc,
          child: HomeScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Scratch Card'));
    await tester.pump();

    verify(() => rewardBloc.add(ScratchCardEvent())).called(1);
    expect(find.text('Balance: 1100 coins'), findsOneWidget);
  });

  testWidgets('Redeem Reward button updates balance on success', (WidgetTester tester) async {
    when(() => rewardBloc.state).thenReturn(RewardInitial(balance: 1000));
    when(() => rewardBloc.redeemUseCase.redeem(300)).thenReturn(true);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RewardBloc>(
          create: (context) => rewardBloc,
          child: RedemptionStoreScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Redeem').first);
    await tester.pump();

    verify(() => rewardBloc.add(RedeemRewardEvent(300))).called(1);
    expect(find.text('Balance: 700 coins'), findsOneWidget);
  });

  testWidgets('Redeem Reward button shows failure message on failure', (WidgetTester tester) async {
    when(() => rewardBloc.state).thenReturn(RewardInitial(balance: 1000));
    when(() => rewardBloc.redeemUseCase.redeem(300)).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RewardBloc>(
          create: (context) => rewardBloc,
          child: RedemptionStoreScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Redeem').first);
    await tester.pump();

    verify(() => rewardBloc.add(RedeemRewardEvent(300))).called(1);
    expect(find.text('Redemption failed'), findsOneWidget);
  });
}