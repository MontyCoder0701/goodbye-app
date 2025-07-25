import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../models/lost_person.model.dart';

class MemoryDetailScreen extends StatelessWidget {
  final String lostPersonId;

  const MemoryDetailScreen({super.key, required this.lostPersonId});

  @override
  Widget build(BuildContext context) {
    final person = LostPerson(
      name: 'Dad',
      dateOfDeath: DateTime(2025, 2, 6),
      memorialLocation: '함백산 추모공원 9-5-182',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Memories')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                context.push('/lost_person/1');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        // backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person.name,
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge?.apply(fontWeightDelta: 2),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Date of Passing: ${DateFormat.yMMMMd().format(person.dateOfDeath)}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Memorial Site: ${person.memorialLocation}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Photos / Videos',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    context.push('/lost_person/1/item/1?item_type=media');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                      // image: DecorationImage(
                      //   image: NetworkImage('https://example.com/image_$i.jpg'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                );
              },
            ),
            Text('Written', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    context.push('/lost_person/1/item/1?item_type=written');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                      // image: DecorationImage(
                      //   image: NetworkImage('https://example.com/image_$i.jpg'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo),
                    title: const Text('Upload Photo'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: handle image upload
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.videocam),
                    title: const Text('Upload Video'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: handle video upload
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_page_outlined),
                    title: const Text('Upload a Written Memory'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: navigate to write screen
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
