import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';
import 'package:streamer_dashboard/src/app/lang/locale_keys.g.dart';
import 'package:streamer_dashboard/src/app/tools/app_logger.dart';

part 'animated_navigaion_bar_parent_data.dart';
part 'animated_navigation_bar_item.dart';
part 'animated_navigation_bar_item_widget.dart';
part 'animated_navigation_bar_render_box.dart';
part 'animated_navigation_bar_render_object_widget.dart';
part 'animated_navigation_bar_selection_style.dart';

class AnimatedNavigationBar extends StatefulWidget {
  final Function(int)? onItemSelected;
  final AnimatedNavigationBarSelectionStyle selectionStyle;

  const AnimatedNavigationBar({
    super.key,
    this.onItemSelected,
    this.selectionStyle = const AnimatedNavigationBarSelectionStyle(),
  });

  @override
  State<AnimatedNavigationBar> createState() => _AnimatedNavigationBarState();
}

class _AnimatedNavigationBarState extends State<AnimatedNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> _highlightTween;
  late Animation<double> _highlightAnimation;

  void _startAnimation() => _animationController.forward(
        from: 0.0,
      );

  void _initAnimation() {
    _animationController = AnimationController(
      duration: widget.selectionStyle.animationDuration,
      vsync: this,
    );

    _highlightTween = Tween<double>(begin: 0, end: 1);

    _highlightAnimation = _highlightTween.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _startAnimation();
  }

  void _disposeAnimation() {
    _animationController.dispose();
  }

  int _selectedIndex = 0;

  void _select(int index) {
    _startAnimation();

    setState(
      () => _selectedIndex = index,
    );

    widget.onItemSelected?.call(
      _selectedIndex,
    );
  }

  @override
  void initState() {
    super.initState();

    _initAnimation();
  }

  @override
  void dispose() {
    _disposeAnimation();
    super.dispose();
  }

  void onExit(PointerExitEvent event) =>
      SystemChannels.mouseCursor.invokeMethod<void>(
        'activateSystemCursor',
        {
          'kind': 'basic',
        },
      );

  @override
  Widget build(BuildContext context) => MouseRegion(
        onExit: onExit,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 225,
            child: AnimatedNavigationBarRenderObjectWidget(
              selectionStyle: widget.selectionStyle,
              highlightAnimation: _highlightAnimation,
              selectedIndex: _selectedIndex,
              onItemSelected: _select,
              children: [
                AnimatedNavigationBarItemWidget(
                  barItem: AnimatedNavigationBarItem(
                    leftIcon: Icon(Icons.dashboard),
                    title: LocaleKeys.navigation_bar_dashboard.tr(),
                  ),
                ),
                AnimatedNavigationBarItemWidget(
                  barItem: AnimatedNavigationBarItem(
                    title: LocaleKeys.navigation_bar_donations.tr(),
                  ),
                ),
                AnimatedNavigationBarItemWidget(
                  barItem: AnimatedNavigationBarItem(
                    title: LocaleKeys.navigation_bar_streams.tr(),
                  ),
                ),
                AnimatedNavigationBarItemWidget(
                  barItem: AnimatedNavigationBarItem(
                    title: LocaleKeys.navigation_bar_authentication.tr(),
                  ),
                ),
                AnimatedNavigationBarItemWidget(
                  barItem: AnimatedNavigationBarItem(
                    title: LocaleKeys.navigation_bar_accounts.tr(),
                  ),
                ),
                AnimatedNavigationBarItemWidget(
                  barItem: AnimatedNavigationBarItem(
                    title: LocaleKeys.navigation_bar_chatbot.tr(),
                  ),
                ),
                AnimatedNavigationBarItemWidget(
                  barItem: AnimatedNavigationBarItem(
                    title: LocaleKeys.navigation_bar_stream_widgets.tr(),
                  ),
                ),
                AnimatedNavigationBarItemWidget(
                  barItem: AnimatedNavigationBarItem(
                    title: LocaleKeys.navigation_bar_settings.tr(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
