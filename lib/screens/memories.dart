import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/main_drawer.dart';
import '/screens/create_lost_person.modal.dart';
import '../models/lost_person.model.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final person = LostPerson(
      name: 'Dad',
      dateOfDeath: DateTime(2025, 2, 6),
      memorialLocation: '함백산 추모공원 9-5-182',
    );

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: const Text('Memories')),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20),
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.push('/lost_person/1/memories');
            },
            borderRadius: BorderRadius.circular(12),
            child: Card(
              elevation: 3,
              shadowColor: colorScheme.outline,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: colorScheme.outline,
                        backgroundImage: person.profileImageUrl != null
                            ? NetworkImage(person.profileImageUrl!)
                            : null,
                        child: person.profileImageUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      title: Text(
                        person.displayName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: person.displayDateOfDeath != null
                          ? Text(
                              '~ ${person.displayDateOfDeath}',
                              style: TextStyle(color: colorScheme.tertiary),
                            )
                          : null,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorScheme.outline,
                            // TODO: add image
                            // image: DecorationImage(
                            //   image: AssetImage('assets/sample_image.jpg'),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => const CreateLostPersonModal(),
          );
        },
      ),
    );
  }
}
