import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router.dart';
import 'theme.dart';
import '../features/profile/providers/profile_provider.dart';

class NitaraApp extends StatefulWidget {
  const NitaraApp({super.key});

  @override
  State<NitaraApp> createState() => _NitaraAppState();
}

class _NitaraAppState extends State<NitaraApp> {
  late final _router = buildRouter(context);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return MaterialApp.router(
          title: 'Nitara',
          debugShowCheckedModeBanner: false,
          theme: NitaraTheme.light,
          darkTheme: NitaraTheme.dark,
          themeMode: profileProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routerConfig: _router,
        );
      },
    );
  }
}
