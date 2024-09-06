import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instagram_stories/features/home/provider/story_provider.dart';
import 'package:instagram_stories/features/home/widgets/story_bars.dart';
import 'package:instagram_stories/features/home/widgets/story_circles.dart';
import '../widgets/custom_page_transition.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late StoryProvider storyProvider;
  bool isSwipingLeft = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    storyProvider = Provider.of<StoryProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentStory = storyProvider.currentStory;
    final currentIndex = storyProvider.currentItemIndex;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Fullscreen background image
        Image.network(
          currentStory.storyItems[currentIndex].imageUrl,
          fit: BoxFit.cover,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: CustomPageTransition(
            key: ValueKey<int>(storyProvider.currentStoryIndex),
            isSwipingLeft: isSwipingLeft,
            animation: const AlwaysStoppedAnimation(1.0),
            child: Column(
              key: ValueKey<int>(currentIndex),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: StoryBars(
                      percentWatchedList: storyProvider.percentageWatched),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Row(
                    children: [
                      StoryCircles(
                        onTap: () {},
                        idName: currentStory.idName,
                        profileUrl: currentStory.profilePic,
                        isBig: false,
                        time: currentStory.storyItems[currentIndex].time,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.more_horiz_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                      const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 35,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
