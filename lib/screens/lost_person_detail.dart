import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/lost_person.model.dart';

class LostPersonDetailScreen extends StatelessWidget {
  final String lostPersonId;

  const LostPersonDetailScreen({super.key, required this.lostPersonId});

  @override
  Widget build(BuildContext context) {
    final person = LostPerson(
      name: 'Dad',
      dateOfDeath: DateTime(2025, 2, 6),
      memorialLocation: '함백산 추모공원 9-5-182',
    );

    return Scaffold(
      appBar: AppBar(title: Text(person.name)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  (person.profileImageUrl != null &&
                      person.profileImageUrl!.isNotEmpty)
                  ? NetworkImage(person.profileImageUrl!)
                  : null,
              child:
                  (person.profileImageUrl == null ||
                      person.profileImageUrl!.isEmpty)
                  ? const Icon(Icons.person, size: 48, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date of Passing',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.yMMMMd().format(person.dateOfDeath),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Memorial Site',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    person.memorialLocation ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
