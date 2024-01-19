import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_ui_challenge/features/main_screen/data/datasources/videos_datasource.dart';

void main() {
  test('Get movies json', () async {
    final datasource = VideosDataSource();
    final json = await datasource.getVideos();
    final a = jsonEncode(json);
    print(a);
  });
}
