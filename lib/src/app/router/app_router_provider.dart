import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:streamer_dashboard/src/app/router/navigation_path.dart';
import 'package:streamer_dashboard/src/app/router/root_wrapper_route.dart';

import '../../modules/modules.dart';
import 'navigator_key_provider.dart';
import 'page_types/page_types.dart';

part 'app_go_router.dart';

class AppRouterProvider {
  static final GoRouter _instance = _AppGoRouter.router;
  static GoRouter get instance => _instance;

  AppRouterProvider._();
}
