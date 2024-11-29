import 'package:flutter/material.dart';
import 'package:quizzy/constants.dart';

class LeaderboardScreen extends StatelessWidget {
  // Contoh data leaderboard
  final List<Map<String, dynamic>> leaderboardData = [
    {"name": "Ipin", "score": 6},
    {"name": "Rangga", "score": 5},
    {"name": "Evans", "score": 3},
    {"name": "Yesua", "score": 2},
    {"name": "Nico", "score": 1},
  ];

  LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard',style: TextStyle(color: neutral),),
        backgroundColor: background, // Warna utama aplikasi
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Players',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final player = leaderboardData[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF6C63FF),
                        child: Text(
                          '#${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        player['name'],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '${player['score']} pts',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
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
    );
  }
}
