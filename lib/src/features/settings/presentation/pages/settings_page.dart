import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasarruf/src/core/database/database_provider.dart';
import 'package:tasarruf/src/core/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            ),
            title: const Text('Tema'),
            subtitle: Text(
              themeMode == ThemeMode.dark ? 'Koyu Tema' : 'Açık Tema',
            ),
            onTap: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Tüm Verileri Sil'),
            subtitle: const Text('Bu işlem geri alınamaz'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Tüm Verileri Sil'),
                  content: const Text(
                    'Tüm verileriniz silinecek. Bu işlem geri alınamaz. Devam etmek istiyor musunuz?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('İptal'),
                    ),
                    FilledButton(
                      onPressed: () {
                        ref
                            .read(transactionNotifierProvider.notifier)
                            .deleteAllTransactions();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tüm veriler silindi'),
                          ),
                        );
                      },
                      child: const Text('Sil'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
