import 'package:flutter/material.dart';
import 'package:streamer_dashboard/src/app/extensions/extensions.dart';

import '../../device/device_size_data.dart';
import '../buttons/buttons.dart';
import 'app_navigation_bar_item.dart';

class AppNavigationBar extends StatefulWidget {
  final List<AppNavigationBarItem> items;
  final int activeIndex;
  final void Function(int)? onActiveIndexChanged;
  final double landscapeWidth;
  final double portraitHeight;
  final Color? backgroundColor;
  final EdgeInsetsGeometry landscapeMargin;
  final EdgeInsetsGeometry portraitMargin;
  final EdgeInsetsGeometry contentPadding;
  final BorderRadius portraitBorderRadius;
  final BorderRadius landscapeBorderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final double buttonVerticalButtonBottomPadding;
  final Widget? logo;
  final List<AppNavigationBarItem>? additionalItems;
  final double additionalButtonVerticalBottomPadding;
  final EdgeInsetsGeometry additionalItemsMargin;
  final Color? additionalItemsDividerColor;

  const AppNavigationBar({
    super.key,
    required this.items,
    this.activeIndex = 0,
    this.onActiveIndexChanged,
    this.landscapeWidth = 220,
    this.portraitHeight = 70,
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.only(),
    this.landscapeMargin = const EdgeInsets.only(
      top: 25,
      bottom: 25,
      left: 20,
      right: 10,
    ),
    this.portraitMargin = const EdgeInsets.fromLTRB(
      20,
      0,
      20,
      20,
    ),
    this.portraitBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    this.landscapeBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(14),
      topRight: Radius.circular(14),
      bottomLeft: Radius.circular(14),
      bottomRight: Radius.circular(14),
    ),
    this.boxShadow,
    this.border,
    this.buttonVerticalButtonBottomPadding = 20,
    this.logo,
    this.additionalItems,
    this.additionalButtonVerticalBottomPadding = 10,
    this.additionalItemsMargin = const EdgeInsets.only(
      top: 10,
      bottom: 10,
      left: 10,
      right: 10,
    ),
    this.additionalItemsDividerColor,
  });

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _activeIndex = 0;

  void _onActiveIndexChanged(int index) {
    if (_activeIndex == index) return;

    setState(
      () => _activeIndex = index,
    );

    widget.onActiveIndexChanged?.call(
      _activeIndex,
    );
  }

  @override
  void initState() {
    super.initState();

    _onActiveIndexChanged(widget.activeIndex);
  }

  @override
  void didUpdateWidget(covariant AppNavigationBar oldWidget) {
    if (oldWidget.activeIndex == widget.activeIndex) return;
    _onActiveIndexChanged(widget.activeIndex);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = DeviceSizeData.deviceType;

    final isPortrait = false;
    // MediaQuery.of(context).orientation == Orientation.portrait;

    return Align(
      alignment: isPortrait ? Alignment.bottomCenter : Alignment.centerLeft,
      child: Padding(
        padding: isPortrait ? widget.portraitMargin : widget.landscapeMargin,
        child: Container(
            width:
                //  isPortrait ? null :

                widget.landscapeWidth,
            height:

                //  isPortrait ?

                // widget.portraitHeight,
                null,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? context.color.background,
              border: widget.border,
              borderRadius: isPortrait
                  ? widget.portraitBorderRadius
                  : widget.landscapeBorderRadius,
              boxShadow: widget.boxShadow ??
                  [
                    BoxShadow(
                      color: context.color.lightBorder.withOpacity(0.2),
                      offset: const Offset(0, 0),
                      spreadRadius: 5,
                      blurRadius: 20,
                    ),
                  ],
            ),
            child:

                // !isPortrait
                // && !deviceType.isMobile
                // ?
                Column(
              children: [
                if (widget.logo is Widget) widget.logo!,
                Expanded(
                  flex: widget.additionalItems is! List<AppNavigationBarItem>
                      ? 1
                      : (widget.items.length + 7).clamp(1, 11),
                  child: ListView.separated(
                    padding: widget.contentPadding,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final isActive = index == _activeIndex;

                      return BouncyButtonWrapper(
                        onTap: () => _onActiveIndexChanged(
                          index,
                        ),
                        child: isActive
                            ? (item.activeIcon ?? item.inActiveIcon)
                            : item.inActiveIcon,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: widget.buttonVerticalButtonBottomPadding,
                    ),
                  ),
                ),
                if (widget.additionalItems is List<AppNavigationBarItem>)
                  Expanded(
                    flex: widget.additionalItems!.length,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 0.5,
                            color: widget.additionalItemsDividerColor ??
                                context.color.mainWhite,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: ListView.separated(
                        padding: widget.additionalItemsMargin,
                        itemCount: widget.additionalItems!.length,
                        itemBuilder: (context, index) {
                          final additionalItem = widget.additionalItems![index];

                          return BouncyButtonWrapper(
                            onTap: additionalItem.onTap,
                            child: additionalItem.inActiveIcon,
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: widget.additionalItems!.length - 1 == index
                              ? 0
                              : widget.additionalButtonVerticalBottomPadding,
                        ),
                      ),
                    ),
                  ),
              ],
            )
            // : Padding(
            //     padding: widget.contentPadding,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         for (final item in widget.items)
            //           Center(
            //             child: BouncyButtonWrapper(
            //               onTap: () => _onActiveIndexChanged(
            //                 widget.items.indexOf(item),
            //               ),
            //               child: item == widget.items[_activeIndex]
            //                   ? (item.activeIcon ?? item.inActiveIcon)
            //                   : item.inActiveIcon,
            //             ),
            //           ),
            //       ],
            //     ),
            //   ),
            ),
      ),
    );
  }
}
