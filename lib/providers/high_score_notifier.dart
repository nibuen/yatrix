// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

@immutable
class ScoreItem {
  final String userName;
  final int points;
  final int rows;
  const ScoreItem({
    required this.userName,
    required this.points,
    required this.rows,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'points': points,
      'rows': rows,
    };
  }

  factory ScoreItem.fromMap(Map<String, dynamic> map) {
    return ScoreItem(
      userName: map['userName'] as String,
      points: map['points'] as int,
      rows: map['rows'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoreItem.fromJson(String source) =>
      ScoreItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ScoreItem(userName: $userName, points: $points, rows: $rows)';

  @override
  bool operator ==(covariant ScoreItem other) {
    if (identical(this, other)) {
      return true;
    }

    return other.userName == userName &&
        other.points == points &&
        other.rows == rows;
  }

  @override
  int get hashCode => userName.hashCode ^ points.hashCode ^ rows.hashCode;
}

class HighScoreState {
  ScoreItem currentScore;
  List<ScoreItem> scores;
  String userName;

  HighScoreState({
    required this.currentScore,
    required this.scores,
    required this.userName,
  });

  HighScoreState copyWith({
    ScoreItem? currentScore,
    List<ScoreItem>? scores,
    String? userName,
  }) {
    return HighScoreState(
      currentScore: currentScore ?? this.currentScore,
      scores: scores ?? this.scores,
      userName: userName ?? this.userName,
    );
  }
}

class HighScoreNotifier extends Notifier<HighScoreState> {
  late PreferencesRepository _preferencesRepository;

  @override
  HighScoreState build() {
    _preferencesRepository = ref.read(preferencesRepositoryProvider);
    return HighScoreState(
      currentScore: ScoreItem(
        userName: _preferencesRepository.userName,
        points: 0,
        rows: 0,
      ),
      scores: _preferencesRepository.scores.map(ScoreItem.fromJson).toList()
        ..sort(
          (e1, e2) => e2.points.compareTo(e1.points),
        ),
      userName: _preferencesRepository.userName,
    );
  }

  /// called from TetrisGame when ever the score changes in a running game
  void setScoreValues(int points, int rows) {
    state = state.copyWith(
      currentScore: ScoreItem(
        userName: _preferencesRepository.userName,
        points: points,
        rows: rows,
      ),
    );
  }

  /// called on HighScorePage
  Future<void> setuserName(String name) async {
    await _preferencesRepository.setUserName(name);
    state = state.copyWith(userName: name);
  }

  /// called on HighScorePage
  Future<void> addCurrentScoreFor({required String userName}) async {
    await setuserName(userName);
    await _preferencesRepository.addScore(state.currentScore.toJson());
    state = HighScoreState(
      userName: userName,
      currentScore: state.currentScore,
      scores: _preferencesRepository.scores.map(ScoreItem.fromJson).toList()
        ..sort(
          (e1, e2) => e2.points.compareTo(e1.points),
        ),
    );
  }
}

final highScoreNotifier =
    NotifierProvider<HighScoreNotifier, HighScoreState>(HighScoreNotifier.new);
