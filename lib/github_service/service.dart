import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/reposetry_response.dart';

class GitHubService {
  final String baseUrl = 'https://api.github.com/users/freeCodeCamp';

  Future<List<Repository>> fetchRepositories() async {
    final response = await http.get(Uri.parse('$baseUrl/repos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((repo) => Repository.fromJson(repo)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  Future<Commit> fetchLastCommit(String repoName) async {
    final url = 'https://api.github.com/repos/freeCodeCamp/$repoName/commits';
    print('Requesting commits from: $url');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return Commit.fromJson(data.first);
    } else {
      print('Failed to load last commit: ${response.statusCode}');
      print('Response: ${response.body}');
      throw Exception('Failed to load last commit');
    }
  }


}
