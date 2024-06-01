import 'package:flareline_uikit/components/forms/outborder_text_form_field.dart';
import 'package:flareline/entity/user_entity.dart';
import 'package:flareline/provider/store_provider.dart';
import 'package:flareline/provider/theme_provider.dart';
import 'package:flareline_uikit/components/badge/anim_badge.dart';
import 'package:flareline_uikit/components/buttons/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flareline/provider/localization_provider.dart';
import 'package:flareline/core/theme/global_colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToolBarWidget extends StatelessWidget {
  bool? showMore;
  bool? showChangeTheme;
  final Widget? userInfoWidget;

  ToolBarWidget({super.key, this.showMore, this.showChangeTheme,this.userInfoWidget});

  @override
  Widget build(BuildContext context) {
    return _toolsBarWidget(context);
  }

  _toolsBarWidget(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        ResponsiveBuilder(builder: (context, sizingInformation) {
          // Check the sizing information here and return your UI
          if ((showMore ?? false) ||
              sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
            return InkWell(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                alignment: Alignment.center,
                child: const Icon(Icons.more_vert),
              ),
              onTap: () {
                if (Scaffold.of(context).isDrawerOpen) {
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                Scaffold.of(context).openDrawer();
              },
            );
          }

          return const SizedBox();
        }),
        ResponsiveBuilder(builder: (context, sizingInformation) {
          // Check the sizing information here and return your UI
          if (!(showMore ?? false) &&
              sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return Container(
              margin: EdgeInsets.only(left: 10),
              width: 280,
              child: OutBorderTextFormField(
                icon: Icon(
                  Icons.search_rounded,
                  color: Color(
                    0xFF68738D,
                  ),
                  size: 24,
                ),
                hintText: 'Search or type keyword',
              ),
            );
          }

          return const SizedBox();
        }),
        const Spacer(),
        if (showChangeTheme ?? false) const ToggleWidget(),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: GlobalColors.background, shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/toolbar/alarm.svg',
                      width: 18, height: 18)),
              const Align(
                child: AnimBadge(),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: GlobalColors.background, shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/toolbar/message.svg',
                      width: 18, height: 18)),
              const Align(
                child: AnimBadge(),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        if(userInfoWidget!=null)
          userInfoWidget!,
        InkWell(
          child: Container(
            margin: const EdgeInsets.only(left: 6),
            child: const Icon(Icons.arrow_drop_down),
          ),
          onTap: () async {
            await showMenu(
              color: Colors.white,
              context: context,
              position: RelativeRect.fromLTRB(
                  MediaQuery.of(context).size.width - 100, 80, 0, 0),
              items: <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                  value: 'value01',
                  child: Text('My Profile'),
                  onTap: () async {
                    onProfileClick(context);
                  },
                ),
                PopupMenuItem<String>(
                  value: 'value02',
                  child: Text('My Contacts'),
                  onTap: () async {
                    onContactClick(context);
                  },
                ),
                PopupMenuItem<String>(
                  value: 'value03',
                  child: Text('Settings'),
                  onTap: () async {

                  },
                ),
                PopupMenuItem<String>(
                    enabled: false,
                    value: 'value04',
                    child: _languagesWidget(context)),
                PopupMenuItem<String>(
                  value: 'value05',
                  child: Text('Log out'),
                  onTap: () {
                    onLogoutClick(context);
                  },
                )
              ],
            );
          },
        )
      ]),
    );
  }

  void onProfileClick(BuildContext context){
    Navigator.of(context).popAndPushNamed('/profile');
  }

  void onContactClick(BuildContext context){
    Navigator.of(context).popAndPushNamed('/contacts');
  }

  void onSettingClick(BuildContext context){
    Navigator.of(context).popAndPushNamed('/settings');
  }

  Future<void> onLogoutClick(BuildContext context) async {
    await context.read<StoreProvider>().logout();
    Navigator.of(context).popAndPushNamed('/signIn');
  }

  Widget _languagesWidget(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AppLocalizations.supportedLocales.map((e) {
        return SizedBox(
          width: 50,
          height: 20,
          child:
              Consumer<LocalizationProvider>(builder: (ctx, provider, child) {
            return ButtonWidget(
              btnText: e.languageCode,
              type: e.languageCode == provider.languageCode
                  ? ButtonType.primary.type
                  : null,
              onTap: () {
                context.read<LocalizationProvider>().locale = e;
              },
            );
          }),
        );
      }).toList(),
    );
  }


}

class ToggleWidget extends StatelessWidget {
  const ToggleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDark;
    return InkWell(
      child: Container(
          padding: const EdgeInsets.all(1),
          width: 85,
          height: 34,
          decoration: BoxDecoration(
              color: GlobalColors.background,
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: isDark ? Colors.transparent : Colors.white,
                child: SvgPicture.asset('assets/toolbar/sun.svg',
                    width: 18,
                    height: 18,
                    color: isDark
                        ? GlobalColors.darkTextBody
                        : GlobalColors.primary),
              ),
              CircleAvatar(
                backgroundColor: isDark ? Colors.white : Colors.transparent,
                child: SvgPicture.asset('assets/toolbar/moon.svg',
                    width: 18,
                    height: 18,
                    color: isDark
                        ? GlobalColors.primary
                        : GlobalColors.darkTextBody),
              ),
            ],
          )),
      onTap: () {
        context.read<ThemeProvider>().toggleThemeMode();
      },
    );
  }
}
