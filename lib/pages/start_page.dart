import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import '../tetris_game.dart';

import '../components/rounded_button.dart';

class StartPage extends Component with HasGameRef<TetrisGame> {
  late final TextComponent _logo;
  late final RoundedButton _playButton;
  late final RoundedButton _constructButton;
  late final RoundedButton _settingsButton;
  late final RoundedButton _highScoreButton;
  late final RoundedButton _helpButton;
  late final RoundedButton _creditsButton;

  static const yStartOffset = 100;
  static const yDelta = 60;

  StartPage() {
    addAll([
      _logo = TextComponent(
        text: '[YaTriX]',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFC8FFF5),
            fontWeight: FontWeight.w800,
          ),
        ),
        anchor: Anchor.center,
      ),
      _playButton = RoundedButton(
        text: 'Play',
        action: () => gameRef.router.pushNamed('play'),
        color: const Color(0xffadde6c),
        borderColor: const Color(0xfffff4c7),
        size: Vector2(150, 40),
      ),
      _constructButton = RoundedButton(
        text: 'Construct',
        action: () => gameRef.router.pushNamed('construct'),
        color: const Color(0xffdebe6c),
        borderColor: const Color(0xffedffab),
        size: Vector2(150, 40),
      ),
      _settingsButton = RoundedButton(
        text: 'Settings',
        action: () => gameRef.router.pushNamed('settings'),
        color: const Color(0xffdebe6c),
        borderColor: const Color(0xfffff4c7),
        size: Vector2(150, 40),
      ),
      _highScoreButton = RoundedButton(
        text: 'High Score',
        action: () => gameRef.router.pushNamed('highScore'),
        color: const Color(0xffdebe6c),
        borderColor: const Color(0xfffff4c7),
        size: Vector2(150, 40),
      ),
      _helpButton = RoundedButton(
        text: 'Info',
        action: () => gameRef.router.pushNamed('info'),
        color: const Color(0xffdebe6c),
        borderColor: const Color(0xfffff4c7),
        size: Vector2(150, 40),
      ),
      _creditsButton = RoundedButton(
        text: 'Credits',
        action: () => gameRef.router.pushNamed('credits'),
        color: const Color(0xffdebe6c),
        borderColor: const Color(0xfffff4c7),
        size: Vector2(150, 40),
      ),

    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    double yPosition = size.y / 4;
    _logo.position = Vector2(size.x / 2, yPosition);
    _playButton.position = Vector2(size.x / 2, yPosition += yStartOffset);
    _constructButton.position = Vector2(size.x / 2, yPosition += yDelta);
    _highScoreButton.position = Vector2(size.x / 2, yPosition += yDelta);
    _settingsButton.position = Vector2(size.x / 2, yPosition += yDelta);
    _helpButton.position = Vector2(size.x / 2, yPosition += yDelta);
    _creditsButton.position = Vector2(size.x / 2, yPosition += yDelta);
  }
}
