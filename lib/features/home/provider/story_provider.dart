// StoryProvider.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:instagram_stories/features/home/model/story_model.dart';
import 'package:instagram_stories/features/home/utils/story_list.dart';

class StoryProvider with ChangeNotifier {
  List<Story> _stories = storyData;
  int _currentStoryIndex = 0;
  int _currentItemIndex = 0;
  List<double> _percentageWatched = [];
  Timer? _timer;

  List<Story> get stories => _stories;

  int get currentStoryIndex => _currentStoryIndex;

  Story get currentStory => _stories.isNotEmpty
      ? _stories[_currentStoryIndex]
      : Story(
          profilePic: '',
          idName: '',
          storyItems: [],
        );

  int get currentItemIndex => _currentItemIndex;

  List<double> get percentageWatched => _percentageWatched;

  StoryProvider() {
    if (_stories.isNotEmpty) {
      _resetStoryProgress();
      _startWatching();
    }
  }

  void setCurrentStoryIndex(int index) {
    _currentStoryIndex = index;
    _currentItemIndex = 0;
    _resetStoryProgress();
    _startWatching();
    notifyListeners();
  }

  // Call this method when swiping on the StoryScreen
  void updateStoryAndCarouselIndex(int index) {
    _currentStoryIndex = index;
    notifyListeners(); // This will notify HomeScreen to update the Carousel
  }

  void _resetStoryProgress() {
    if (_stories[_currentStoryIndex].storyItems.isNotEmpty) {
      _percentageWatched =
          List.filled(_stories[_currentStoryIndex].storyItems.length, 0);
    } else {
      _percentageWatched = [];
    }
  }

  void _startWatching() {
    _timer?.cancel();
    if (_percentageWatched.isEmpty) return;

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_currentItemIndex < _percentageWatched.length &&
          _percentageWatched[_currentItemIndex] < 1) {
        _percentageWatched[_currentItemIndex] =
            min(_percentageWatched[_currentItemIndex] + 0.01, 1.0);
      } else {
        _timer?.cancel();
        _moveToNextItem();
      }
      notifyListeners();
    });
  }

  void _moveToNextItem() {
    if (_currentItemIndex < _percentageWatched.length - 1) {
      _currentItemIndex++;
      _startWatching();
    } else {
      nextStory(); // Move to the next story if items are finished
    }
    notifyListeners();
  }

  void stopWatching() {
    _timer?.cancel();
    notifyListeners();
  }

  void previousItem() {
    if (_currentItemIndex > 0) {
      _percentageWatched[_currentItemIndex - 1] = 0;
      _percentageWatched[_currentItemIndex] = 0;
      _currentItemIndex--;
      _startWatching();
    }
    notifyListeners();
  }

  void nextItem() {
    if (_currentItemIndex < _percentageWatched.length - 1) {
      _percentageWatched[_currentItemIndex] = 1;
      _currentItemIndex++;
      _startWatching();
    } else {
      _percentageWatched[_currentItemIndex] = 1;
      _moveToNextItem(); // Move to next story if items are completed
    }
    notifyListeners();
  }

  void nextStory() {
    if (_currentStoryIndex < _stories.length - 1) {
      _currentStoryIndex++;
      _currentItemIndex = 0;
      _resetStoryProgress();
      _startWatching();
    } else {
      // Loop back to the first story or stop
      _currentStoryIndex = 0;
      _currentItemIndex = 0;
      _resetStoryProgress();
      _startWatching();
    }
    notifyListeners();
  }

  void previousStory() {
    if (_currentStoryIndex > 0) {
      _currentStoryIndex--;
      _currentItemIndex = 0;
      _resetStoryProgress();
      _startWatching();
    } else {
      // Optionally go to the last story
      _currentStoryIndex = _stories.length - 1;
      _currentItemIndex = 0;
      _resetStoryProgress();
      _startWatching();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
