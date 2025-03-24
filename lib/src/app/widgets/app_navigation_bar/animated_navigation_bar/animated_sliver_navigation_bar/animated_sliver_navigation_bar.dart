import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/app_theme_extension.dart';
import 'package:streamer_dashboard/src/app/lang/locale_keys.g.dart';
import 'package:streamer_dashboard/src/assets_gen/assets.gen.dart';

import '../animated_navigation_bar.dart';
import 'custom_animated_sliver.dart';

part 'animated_sliver_navigation_bar_item.dart';

class AnimatedSliverNavigationBar extends StatefulWidget {
  final void Function(int)? onSelected;
  final AnimatedNavigationBarSelectionStyle selectionStyle;
  final double width;
  final double? height;

  const AnimatedSliverNavigationBar({
    super.key,
    this.onSelected,
    this.selectionStyle = const AnimatedNavigationBarSelectionStyle(),
    this.height,
    this.width = 230,
  });

  @override
  State<AnimatedSliverNavigationBar> createState() =>
      _AnimatedSliverNavigationBarState();
}

class _AnimatedSliverNavigationBarState
    extends State<AnimatedSliverNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> _highlightTween;
  late Animation<double> _highlightAnimation;
  int _selectedIndex = 0;

  void _startAnimation() => _animationController.forward(
        from: 0.0,
      );

  void _initAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _highlightTween = Tween<double>(
      begin: 0,
      end: 1,
    );

    _highlightAnimation = _highlightTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _startAnimation();
  }

  void _disposeAnimation() => _animationController.dispose();

  void _select(int index) {
    _startAnimation();

    setState(
      () => _selectedIndex = index,
    );

    widget.onSelected?.call(
      index,
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

  @override
  Widget build(BuildContext context) => SizedBox(
        width: widget.width,
        height: widget.height,
        child: Material(
          color: context.color.navigationBar,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: CustomScrollView(
              slivers: [
                CustomSliverList(
                  selectedIndex: _selectedIndex,
                  highlightAnimation: _highlightAnimation,
                  selectionStyle: widget.selectionStyle.copyWith(
                    color: context.color.secondary,
                  ),
                  delegate: SliverChildListDelegate(
                    [
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(0),
                        title: LocaleKeys.dashboard_title.tr(),
                        selected: _selectedIndex == 0,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconActivityMonitoring.svg(
                          color: context.color.primary,
                        ),
                      ),
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(1),
                        title: LocaleKeys.donations_title.tr(),
                        selected: _selectedIndex == 1,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconHeartHand.svg(
                          color: context.color.primary,
                        ),
                      ),
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(2),
                        title: LocaleKeys.streams_title.tr(),
                        selected: _selectedIndex == 2,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconTv.svg(
                          color: context.color.primary,
                        ),
                      ),
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(3),
                        title: LocaleKeys.authentication_title.tr(),
                        selected: _selectedIndex == 3,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconUser.svg(
                          color: context.color.primary,
                        ),
                      ),
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(4),
                        title: LocaleKeys.accounts_title.tr(),
                        selected: _selectedIndex == 4,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconUsers.svg(
                          color: context.color.primary,
                        ),
                      ),
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(5),
                        title: LocaleKeys.chatbot_title.tr(),
                        selected: _selectedIndex == 5,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconChat.svg(
                          color: context.color.primary,
                        ),
                      ),
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(6),
                        title: LocaleKeys.stream_widgets_title.tr(),
                        selected: _selectedIndex == 6,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconOverlays.svg(
                          color: context.color.primary,
                        ),
                      ),
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(7),
                        title: LocaleKeys.settings_title.tr(),
                        selected: _selectedIndex == 7,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconSettings.svg(
                          color: context.color.primary,
                        ),
                      ),
                      AnimatedSliverNavigationBarItem(
                        onPressed: () => _select(8),
                        title: 'Test page',
                        selected: _selectedIndex == 8,
                        borderRadius: widget.selectionStyle.borderRadius,
                        leftIcon: Assets.icons.iconTool.svg(
                          color: context.color.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
