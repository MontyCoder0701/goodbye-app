import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/lost_person.model.dart';

class MemoryDetailScreen extends StatefulWidget {
  final String lostPersonId;
  final bool openModalOnLoad;

  const MemoryDetailScreen({
    super.key,
    required this.lostPersonId,
    this.openModalOnLoad = false,
  });

  @override
  State<MemoryDetailScreen> createState() => _MemoryDetailScreenState();
}

class _MemoryDetailScreenState extends State<MemoryDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.openModalOnLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showAddMemoryModal();
      });
    }
  }

  void _showAddMemoryModal() {
    showModalBottomSheet(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final person = LostPerson(
      name: 'Dad',
      dateOfDeath: DateTime(2025, 2, 6),
      memorialLocation: '함백산 추모공원 9-5-182',
    );

    return Scaffold(
      appBar: AppBar(title: Text("${person.displayName}'s Memories")),
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
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: colorScheme.outline,
                        backgroundImage:
                            (person.profileImageUrl != null &&
                                person.profileImageUrl!.isNotEmpty)
                            ? NetworkImage(person.profileImageUrl!)
                            : null,
                        child:
                            (person.profileImageUrl == null ||
                                person.profileImageUrl!.isEmpty)
                            ? const Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person.displayName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (person.displayDateOfDeath != null) ...{
                              const SizedBox(height: 4),
                              Text(
                                '~ ${person.displayDateOfDeath}',
                                style: TextStyle(color: colorScheme.tertiary),
                              ),
                            },
                            if (person.memorialLocation != null) ...{
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: colorScheme.tertiary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    person.memorialLocation!,
                                    style: TextStyle(
                                      color: colorScheme.tertiary,
                                    ),
                                  ),
                                ],
                              ),
                            },
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: colorScheme.tertiary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Icon(Icons.photo_library),
                const SizedBox(width: 8),
                const Text(
                  'Photos / Videos',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (person.photos.isEmpty && person.videos.isEmpty) ...{
              Text(
                'No Photos or Videos',
                style: TextStyle(color: colorScheme.tertiary),
              ),
            },
            if (person.photos.isNotEmpty || person.videos.isNotEmpty) ...{
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
                        color: colorScheme.outline,
                      ),
                    ),
                  );
                },
              ),
            },
            const SizedBox(height: 30),
            Row(
              children: [
                const Icon(Icons.edit_note),
                const SizedBox(width: 8),
                const Text(
                  'Written',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (person.notes.isEmpty) ...{
              Text(
                'No Written Memories',
                style: TextStyle(color: colorScheme.tertiary),
              ),
            },
            if (person.notes.isNotEmpty) ...{
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
                        color: colorScheme.outline,
                      ),
                    ),
                  );
                },
              ),
            },
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemoryModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
