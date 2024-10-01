import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/reposetry_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late RepoProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RepoProvider>(context, listen: false);
    provider.loadRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Task-1"),
      ),
      body: Consumer<RepoProvider>(
        builder: (context, provider, _) {
          if (provider.repos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.repos.length,
            itemBuilder: (context, index) {
              final repo = provider.repos[index];
              final commit = provider.commits[repo.name];

              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  title: Text(
                    repo.name,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repo.description,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      if (commit != null)
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Last commit: ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: commit.message,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const TextSpan(
                                text: ' on ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: commit.date,
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                  trailing: commit == null
                      ? const Icon(Icons.visibility,
                          color: Colors.white)
                      : const Icon(Icons.visibility_off, color: Colors.white),
                  // Show "viewed" icon
                  onTap: () => provider.loadLastCommit(repo.name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
