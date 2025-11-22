// Mock frame processor (Dart)
// Returns emotion_summary, activity_summary, wellbeing_score, events
import 'dart:math';
class FrameResult {
  final Map<String,dynamic> emotionSummary;
  final Map<String,dynamic> activitySummary;
  final int wellbeingScore;
  FrameResult({required this.emotionSummary, required this.activitySummary, required this.wellbeingScore});
}
class MockFrameProcessor {
  final Random _rng;
  MockFrameProcessor([int? seed]) : _rng = seed==null ? Random() : Random(seed);
  FrameResult processSingleFrame() {
    final happy = double.parse((0.5 + _rng.nextDouble()*0.4).toStringAsFixed(2));
    final sad = double.parse((0.1*_rng.nextDouble()).toStringAsFixed(2));
    final neutral = double.parse((1-happy-sad).toStringAsFixed(2));
    final emotion = {'dominant':'happy','distribution':{'happy':happy,'sad':sad,'neutral':neutral},'examples':[]};
    final activity = {'active_minutes': 10 + _rng.nextInt(50),'sedentary_minutes': 5 + _rng.nextInt(20),'events':[]};
    final wellbeing = (50 + (happy*50)).round();
    return FrameResult(emotionSummary: emotion, activitySummary: activity, wellbeingScore: wellbeing);
  }
}
