import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/app/router/navigation_path.dart';
import 'package:streamer_dashboard/src/app/router/root_wrapper_route.dart';

import '../../modules/authentication/module.dart';
import '../../modules/dashboard/module.dart';
import '../../modules/donations/module.dart';
import '../../modules/live_streams/module.dart';
import '../../modules/settings/module.dart';
import 'navigator_key_provider.dart';
import 'page_types/page_types.dart';

part 'app_go_router.dart';

class AppRouterProvider {
  static final GoRouter _instance = _AppGoRouter.router;
  static GoRouter get instance => _instance;

  AppRouterProvider._();
}
