// import 'package:flutter/material.dart';
// import 'package:instagram_stories/features/home/widgets/progress_bar.dart';

// // ignore: must_be_immutable
// class StoryBars extends StatelessWidget {
//   List<double> percentWatchedList = [];
//   StoryBars({super.key, required this.percentWatchedList});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 60),
//       child: Row(
//         children: [
//           Expanded(
//             child: ProgressBar(percentWatched: percentWatchedList[0]),
//           ),
//           Expanded(
//             child: ProgressBar(percentWatched: percentWatchedList[1]),
//           ),
//           Expanded(
//             child: ProgressBar(percentWatched: percentWatchedList[2]),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:instagram_stories/features/home/widgets/progress_bar.dart';

class StoryBars extends StatelessWidget {
  final List<double> percentWatchedList;

  const StoryBars({super.key, required this.percentWatchedList});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: percentWatchedList.map((percentWatched) {
        return Expanded(child: ProgressBar(percentWatched: percentWatched));
      }).toList(),
    
    );
  }
}
