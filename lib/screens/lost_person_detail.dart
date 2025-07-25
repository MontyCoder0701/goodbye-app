import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/lost_person.model.dart';

class LostPersonDetailScreen extends StatefulWidget {
  final String lostPersonId;

  const LostPersonDetailScreen({super.key, required this.lostPersonId});

  @override
  State<LostPersonDetailScreen> createState() => _LostPersonDetailScreenState();
}

class _LostPersonDetailScreenState extends State<LostPersonDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _nicknameController;
  late TextEditingController _locationController;

  bool _isEditingName = false;
  bool _isEditingNickname = false;
  bool _isEditingLocation = false;

  DateTime? _dateOfDeath;
  late DateTime _originalDateOfDeath;

  late String _originalName;
  late String? _originalNickname;
  late String _originalLocation;

  late LostPerson person;

  @override
  void initState() {
    super.initState();

    person = LostPerson(
      name: 'Dad',
      nickname: '아빠',
      dateOfDeath: DateTime(2025, 2, 6),
      memorialLocation: '함백산 추모공원 9-5-182',
    );

    _nameController = TextEditingController(text: person.name);
    _nicknameController = TextEditingController(text: person.nickname);
    _locationController = TextEditingController(text: person.memorialLocation);

    _originalName = person.name;
    _originalNickname = person.nickname;
    _originalLocation = person.memorialLocation ?? '';
    _dateOfDeath = person.dateOfDeath;
    _originalDateOfDeath = person.dateOfDeath!;
  }

  bool get _hasChanges =>
      _nameController.text != _originalName ||
      _nicknameController.text != _originalNickname ||
      _locationController.text != _originalLocation ||
      !_isSameDate(_dateOfDeath!, _originalDateOfDeath);

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Memorial Info')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
        child: ListView(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 48,
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: colorScheme.outline),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: colorScheme.tertiary,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                setState(() => _isEditingName = true);
              },
              child: _isEditingName
                  ? TextField(
                      controller: _nameController,
                      autofocus: true,
                      onSubmitted: (_) =>
                          setState(() => _isEditingName = false),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Name *',
                      ),
                    )
                  : Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 8),
                        Text(
                          _nameController.text,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                setState(() => _isEditingNickname = true);
              },
              child: _isEditingNickname
                  ? TextField(
                      controller: _nicknameController,
                      autofocus: true,
                      onSubmitted: (_) =>
                          setState(() => _isEditingNickname = false),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        labelText: 'Nickname',
                      ),
                    )
                  : Row(
                      children: [
                        const Icon(Icons.person_outline),
                        const SizedBox(width: 8),
                        Text(
                          _nicknameController.text,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                setState(() => _isEditingLocation = true);
              },
              child: _isEditingLocation
                  ? TextField(
                      controller: _locationController,
                      autofocus: true,
                      onSubmitted: (_) =>
                          setState(() => _isEditingLocation = false),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        labelText: 'Memorial Location',
                      ),
                    )
                  : Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            _locationController.text,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 30),
            Text(
              'Date of Passing',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.tertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _dateOfDeath!,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && !_isSameDate(picked, _dateOfDeath!)) {
                  setState(() => _dateOfDeath = picked);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat.yMMMMd().format(_dateOfDeath!),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            if (_hasChanges) ...{
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _originalName = _nameController.text;
                    _originalNickname = _nicknameController.text;
                    _originalLocation = _locationController.text;
                    _originalDateOfDeath = _dateOfDeath!;
                    _isEditingName = false;
                    _isEditingNickname = false;
                    _isEditingLocation = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changes saved')),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Changes'),
              ),
            },
          ],
        ),
      ),
    );
  }
}
