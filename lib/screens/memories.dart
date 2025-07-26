import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/main_drawer.dart';
import '/screens/create_lost_person.modal.dart';
import '../models/lost_person.model.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({super.key});

  @override
  State<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  final List<LostPerson> _persons = [];

  void _openCreateLostPersonModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CreateLostPersonModal(
        onCreated: (newPerson) {
          setState(() {
            _persons.add(newPerson);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: const Text('Memories')),
      body: _persons.isEmpty
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.primary.withAlpha(5),
                    colorScheme.primary.withAlpha(100),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 48,
                      color: colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Save Your Memories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add someone to save their memories.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _openCreateLostPersonModal(context),
                      child: const Text('Add Someone'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              padding: const EdgeInsets.all(16),
              itemCount: _persons.length,
              itemBuilder: (context, index) {
                final person = _persons[index];
                return InkWell(
                  onTap: () {
                    context.push('/lost_person/${index + 1}/memories');
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: person.displayDateOfDeath != null
                                ? Text(
                                    '~ ${person.displayDateOfDeath}',
                                    style: TextStyle(
                                      color: colorScheme.tertiary,
                                    ),
                                  )
                                : null,
                            trailing: !person.hasMemories
                                ? ElevatedButton(
                                    onPressed: () {
                                      context.push(
                                        '/lost_person/${index + 1}/memories?open_modal=true',
                                      );
                                    },
                                    child: Text('Add Memories'),
                                  )
                                : Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: colorScheme.tertiary,
                                  ),
                          ),
                          if (person.hasMemories) ...{
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
                                    // Add image here if needed
                                  ),
                                );
                              },
                            ),
                          },
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateLostPersonModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
