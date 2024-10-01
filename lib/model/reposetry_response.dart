class Repository {
  final String name;
  final String description;
  final String language;

  Repository({required this.name, required this.description, required this.language});

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      description: json['description'] ?? 'No description',
      language: json['language'] ?? 'N/A',
    );
  }
}

class Commit {
  final String message;
  final String date;

  Commit({required this.message, required this.date});

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      message: json['commit']['message'],
      date: json['commit']['committer']['date'],
    );
  }
}
