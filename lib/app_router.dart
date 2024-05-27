import 'package:go_router/go_router.dart';
import 'package:sqflite_app/add_user_info_notes.dart';
import 'package:sqflite_app/edit_user_info.dart';
import 'package:sqflite_app/home_page.dart';

abstract class AppRouter {
  static const khomePage = '/';
  static const kaddUserInfoNotes = '/addUserInfoNotes';
  static const keditUserInfoNotes = '/editUserInfoNotes';
  static final route = GoRouter(
    routes: [
      GoRoute(
        path: khomePage,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: kaddUserInfoNotes,
        builder: (context, state) => const AddUserInfoNotes(),
      ),
      GoRoute(
        path: keditUserInfoNotes,
        builder: (context, state) => EditUserInfo(
          id: state.extra,
          title: state.extra,
          description: state.extra,
        ),
      ),
    ],
  );
}
