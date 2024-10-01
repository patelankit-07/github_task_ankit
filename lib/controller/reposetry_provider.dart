import 'package:flutter/material.dart';

import '../github_service/service.dart';
import '../model/reposetry_response.dart';


class RepoProvider with ChangeNotifier {
  final GitHubService _service = GitHubService();
  List<Repository> _repos = [];
  final Map<String, Commit> _commits = {};

  List<Repository> get repos => _repos;
  Map<String, Commit> get commits => _commits;

  Future<void> loadRepositories() async {
    _repos = await _service.fetchRepositories();
    notifyListeners();
  }

  Future<void> loadLastCommit(String repoName) async {
    try {
      final commit = await _service.fetchLastCommit(repoName);
      _commits[repoName] = commit;
      notifyListeners();
    } catch (e) {
      print('Error loading commit for $repoName: $e');

    }
  }

}
