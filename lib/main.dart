import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog/di/injection_container.dart' as di;
import 'package:blog/cubits/login_cubit.dart';
import 'package:blog/cubits/posts_cubit.dart';
import 'package:blog/ui/screens/login_screen.dart';
import 'package:blog/ui/screens/posts_screen.dart';
import 'package:blog/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.getIt<LoginCubit>()),
        BlocProvider(create: (_) => di.getIt<PostsCubit>()),
      ],
      child: MaterialApp(
        title: 'Blog',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FutureBuilder<bool>(
          future: di.getIt<AuthRepository>().isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            } else {
              final isLoggedIn = snapshot.data ?? false;
              return isLoggedIn ? const PostsScreen() : LoginScreen();
            }
          },
        ),
      ),
    );
  }
}