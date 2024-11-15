import 'package:flutter/material.dart';
import 'package:flutter_pockemon_app/providers/theme_provider.dart';
import 'package:flutter_pockemon_app/repos/hive_repo.dart';
import 'package:flutter_pockemon_app/theme/styles.dart';
import 'package:flutter_pockemon_app/ui/screens/all_pockemon_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveRepo().registerAdapter();
  runApp(ProviderScope(child: const PockemonApp()));
}

class PockemonApp extends ConsumerStatefulWidget {
const PockemonApp({ super.key });

  @override
  ConsumerState<PockemonApp> createState() => _PockemonAppState();
}

class _PockemonAppState extends ConsumerState<PockemonApp> {
  @override void initState() {
    super.initState();
    Future.microtask(() async{
        await ref.read(themeModeProvider.notifier).getTheme();
    });
  }
  @override
  Widget build(BuildContext context){
  final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      home: const AllPockemonScreen(),
      theme: themeMode ? Styles.themeData(isDarkTheme: false): Styles.themeData(isDarkTheme: true),
     // darkTheme: Styles.themeData(isDarkTheme: true),
   //  themeMode: themeMode ? :,
    );
  }
}

