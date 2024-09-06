import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:instagram_stories/constants/themes.dart';

class StoryCircles extends StatelessWidget {
  final void Function()? onTap;
  final String idName;
  final String profileUrl;
  final bool isBig;
  final String? time;
  final bool isActive; // Add this parameter to control animation

  const StoryCircles({
    super.key,
    required this.onTap,
    required this.idName,
    required this.profileUrl,
    required this.isBig,
    this.time,
    this.isActive = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    return isBig
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Stack(
                  children: [
                    Container(
                      width: 85, // Static size for the container
                      height: 85, // Static size for the container
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                        border: GradientBoxBorder(
                          width: 4,
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.purple,
                              Colors.pink,
                            ],
                          ),
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          profileUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (isActive)
                      Positioned(
                        right: 5,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 5, end: 30),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          builder: (context, size, child) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle),
                              width: size,
                              height: size,
                              child: Center(
                                child: ClipOval(
                                  child: Image.network(
                                    "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTExL3JtNTg2YmF0Y2gyLWVtb2ppLTAwNi5wbmc.png",
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  idName,
                  style: AppTheme.f14w400.copyWith(
                      color: Colors.white, overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          )
        : Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                width: 30,
                height: 30,
                child: ClipOval(
                  child: Image.network(
                    profileUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                idName,
                style: AppTheme.f14w400.copyWith(
                    color: Colors.white, overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                time ?? "",
                style: AppTheme.f14w400.copyWith(
                    color: Colors.white, overflow: TextOverflow.ellipsis),
              ),
            ],
          );
  }
}
