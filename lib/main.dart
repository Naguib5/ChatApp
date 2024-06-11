import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/cubit/auth_cubit/auth_cubit.dart';
import 'package:chatapp/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(() {
    runApp(const ChatApp());
  });
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            LoginPage.id: (context) => LoginPage(),
            RegisterPage.id: (context) => RegisterPage(),
            ChatPage.id: (context) => ChatPage(),
          },
          initialRoute: LoginPage.id),
    );
  }
}
