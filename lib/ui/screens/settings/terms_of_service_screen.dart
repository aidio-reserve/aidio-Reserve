import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aitrip/ui/screens/drawer/setting_screen.dart';

class TermsOfServiceScreen extends ConsumerWidget {
  const TermsOfServiceScreen({super.key});
  static const routeName = '/terms_of_service';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingScreen()),
              );
            },
          ),
          title: const Text(
            '利用規約',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
      ),
      body: const Center(
        child: Text('これは利用規約スクリーンです。'),
      ),
    );
  }
}
