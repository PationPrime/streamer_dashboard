part of 'app_window_title_bar.dart';

class _AppWindowButtons extends StatelessWidget {
  const _AppWindowButtons();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          IconButton(
            onPressed: windowManager.minimize,
            icon: Assets.icons.iconMinus.svg(
              colorFilter: ColorFilter.mode(
                context.color.primary,
                BlendMode.srcIn,
              ),
              height: 2,
              width: 13,
            ),
          ),
          IconButton(
            onPressed: () async {
              if (await windowManager.isMaximized()) {
                windowManager.unmaximize();
              } else {
                windowManager.maximize();
              }
            },
            icon: Center(
              child: Assets.icons.iconSquare.svg(
                colorFilter: ColorFilter.mode(
                  context.color.primary,
                  BlendMode.srcIn,
                ),
                height: 13,
                width: 13,
              ),
            ),
          ),
          IconButton(
            onPressed: windowManager.hide,
            icon: Center(
              child: Assets.icons.iconCloseCross.svg(
                colorFilter: ColorFilter.mode(
                  context.color.primary,
                  BlendMode.srcIn,
                ),
                height: 13,
                width: 13,
              ),
            ),
          )
        ],
      );
}
