class VideosDataSource {
  Future<List<Map<String, dynamic>>> getVideos() async {
    Future.delayed(const Duration(seconds: 1));
    return [
      video2,
      video1,
      video2.map((key, value) => MapEntry(key, key == "id" ? 3 : value)),
      video1.map((key, value) => MapEntry(key, key == "id" ? 4 : value)),
      video2.map((key, value) => MapEntry(key, key == "id" ? 5 : value)),
      video1.map((key, value) => MapEntry(key, key == "id" ? 6 : value)),
    ];
  }
}

final userOne = {
  "id": 1,
  "name": "u/mo_alawad",
  "imageUrl":
      "https://www.redditstatic.com/avatars/defaults/v2/avatar_default_4.png",
};

final userTwo = {
  "id": 2,
  "name": "u/games",
  "imageUrl":
      "https://www.redditstatic.com/avatars/defaults/v2/avatar_default_4.png",
};

final comment1 = {
  "id": 1,
  "text": "90%+ of Dubai's population lives under 5k. Let that sink in",
  "dateTime": DateTime.now().toString(),
  "author": userOne,
  "upvotes": 20,
  "downvotes": 1,
  "replys": [
    {
      "id": 3,
      "text": "yes, 74% of newspaper said the same thing.",
      "dateTime": DateTime.now().toString(),
      "author": userTwo,
      "upvotes": 6,
      "downvotes": 0,
      "replys": [],
    }
  ],
};

final comment2 = {
  "id": 2,
  "text": "With less than 100k monthly is going to be very hard to survive",
  "dateTime": DateTime.now().toString(),
  "author": userOne,
  "upvotes": 3,
  "downvotes": 10,
  "replys": [],
};

final comment3 = {
  "id": 100,
  "text": "With less than 100k monthly is going to be very hard to survive",
  "dateTime": DateTime.now().toString(),
  "author": userOne,
  "upvotes": 3,
  "downvotes": 10,
  "replys": [
    {
      "id": 102,
      "text": "With less than 100k monthly is going to be very hard to survive",
      "dateTime": DateTime.now().toString(),
      "author": userOne,
      "upvotes": 3,
      "downvotes": 10,
      "replys": [],
    },
    {
      "id": 103,
      "text": "With less than 100k monthly is going to be very hard to survive",
      "dateTime": DateTime.now().toString(),
      "author": userOne,
      "upvotes": 3,
      "downvotes": 10,
      "replys": [
        {
          "id": 101,
          "text":
              "With less than 100k monthly is going to be very hard to survive",
          "dateTime": DateTime.now().toString(),
          "author": userOne,
          "upvotes": 3,
          "downvotes": 10,
          "replys": [],
        }
      ],
    }
  ],
};

final video1 = {
  "id": 1,
  "groupLogo":
      "https://i.redd.it/snoovatar/avatars/5a7e3aa9-eed4-45aa-b85a-7f7282bc5b5d.png",
  "groupName": "HelloAvatar",
  "user": userOne,
  "comments": [
    comment3,
    comment1,
    comment2,
    comment2.map((key, value) => MapEntry(key, key == "id" ? 3 : value)),
    comment1.map((key, value) => MapEntry(key, key == "id" ? 4 : value)),
    comment1.map((key, value) => MapEntry(key, key == "id" ? 5 : value)),
    comment2.map((key, value) => MapEntry(key, key == "id" ? 6 : value)),
  ],
  "commentsCount": 6,
  "downvotes": 1,
  "upvotes": 234,
  "upvoted": false,
  "downvoted": false,
  "videoTitle": "For Bigger Blazes",
  "videoUrl":
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
};

final video2 = {
  "id": 2,
  "groupLogo":
      "https://www.redditstatic.com/avatars/defaults/v2/avatar_default_4.png",
  "groupName": "u/samsunggulf",
  "user": userOne,
  "comments": [
    comment2.map((key, value) => MapEntry(key, key == "id" ? 7 : value)),
    comment1.map((key, value) => MapEntry(key, key == "id" ? 8 : value)),
    comment1.map((key, value) => MapEntry(
          key,
          key == "id" ? 9 : value,
        )),
    comment2.map((key, value) => MapEntry(key, key == "id" ? 10 : value)),
    comment2.map((key, value) => MapEntry(key, key == "id" ? 11 : value)),
    comment1.map((key, value) => MapEntry(key, key == "id" ? 12 : value)),
    comment1.map((key, value) => MapEntry(key, key == "id" ? 13 : value)),
    comment2.map((key, value) => MapEntry(key, key == "id" ? 14 : value)),
  ],
  "commentsCount": 8,
  "downvotes": 20,
  "upvotes": 100,
  "upvoted": false,
  "downvoted": false,
  "videoTitle": "Big Buck Bunny",
  "videoUrl":
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
};
