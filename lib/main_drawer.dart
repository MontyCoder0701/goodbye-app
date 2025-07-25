import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          final version = snapshot.hasData ? snapshot.data!.version : '-';
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Row(
                  children: [
                    Text(
                      'Version $version',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Licenses'),
                onTap: () {
                  showLicensePage(
                    context: context,
                    applicationName: 'Memories App',
                    applicationVersion: version,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('Contact Developer'),
                onTap: () async {
                  await launchUrl(
                    Uri.parse('https://github.com/MontyCoder0701'),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
