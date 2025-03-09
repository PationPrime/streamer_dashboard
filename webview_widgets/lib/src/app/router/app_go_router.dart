import 'package:go_router/go_router.dart';
import '../../pages/pages.dart';
import 'navigation_path.dart';

class AppGoRouter {
  static final router = GoRouter(
    initialLocation: NavigationPath.root,
    errorBuilder: (context, state) => NotFound404(),
    routes: [
      GoRoute(
        path: NavigationPath.root,
        name: NavigationPath.root,
        builder: (context, state) => Welcome(),
      ),
      GoRoute(
        name: NavigationPath.subsGlass,
        path: '/${NavigationPath.subsGlass}',
        builder: (context, state) => const DefaultFallingBallsWidget(),
      ),
    ],
  );
}
