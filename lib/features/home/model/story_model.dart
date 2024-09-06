class Story {
  final String profilePic;
  final String idName;

  final List<StoryItem> storyItems;

  Story({
    required this.profilePic,
    required this.idName,
    required this.storyItems,
  });
}

class StoryItem {
  final String imageUrl;
  final String description;
  final String time;

  StoryItem({
    required this.imageUrl,
    required this.description,
    required this.time,
  });
}
