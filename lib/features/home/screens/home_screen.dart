// HomeScreen.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:instagram_stories/constants/themes.dart';
import 'package:instagram_stories/features/home/provider/story_provider.dart';
import 'package:instagram_stories/features/home/screens/story_screen.dart';
import 'package:instagram_stories/features/home/utils/story_list.dart';
import 'package:instagram_stories/features/home/widgets/story_circles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  late StoryProvider storyProvider;
  bool isSwipingLeft = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    storyProvider = Provider.of<StoryProvider>(context);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity != null) {
      setState(() {
        if (details.primaryVelocity! < 0) {
          isSwipingLeft = true;
          storyProvider.nextStory();
        } else if (details.primaryVelocity! > 0) {
          isSwipingLeft = false;
          storyProvider.previousStory();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStory = storyProvider.currentStory;
    final currentIndex = storyProvider.currentItemIndex;
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onTapDown: (details) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final double dx = details.globalPosition.dx;
        setState(() {
          if (dx < screenWidth / 2) {
            storyProvider.previousItem();
          } else {
            storyProvider.nextItem();
          }
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const StoryScreen(), // Display story screen in the background
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.withOpacity(0.85),
                      Colors.grey.withOpacity(0.0),
                    ],
                    begin: Alignment.center,
                    end: Alignment.topCenter,
                    stops: const [0.0, 1.0],
                  ),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                              currentStory.storyItems[currentIndex].description,
                              style: AppTheme.f16w400
                                  .copyWith(color: Colors.white)),
                        ),
                        const Icon(
                          Icons.more_horiz_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Liked by ",
                             style: AppTheme.f11w400
                                  .copyWith(color: Colors.grey[300]),
                          ),
                           TextSpan(
                            text: "Calvin Wade",
                            style: AppTheme.f11w400
                                  .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<StoryProvider>(
                  builder: (context, storyProvider, child) {
                    // Sync the Carousel with the story index from the provider
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _carouselController
                          .jumpToPage(storyProvider.currentStoryIndex);
                    });

                    return CarouselSlider.builder(
                      itemCount: storyData.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        final story = storyData[index];
                        final isActive =
                            storyProvider.currentStoryIndex == index;
                        return StoryCircles(
                          onTap: () {
                            // storyProvider.setCurrentStoryIndex(index);
                            // _carouselController
                            //     .jumpToPage(index); // Sync carousel on tap
                          },
                          idName: story.idName,
                          profileUrl: story.profilePic,
                          isBig: true,
                          isActive: isActive,
                        );
                      },
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.25,
                        enableInfiniteScroll: true,
                      ),
                      carouselController: _carouselController,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
