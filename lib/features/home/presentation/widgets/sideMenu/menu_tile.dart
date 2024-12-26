import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_flutter/features/home/application/blocs/side_menu_bloc.dart';
import 'package:pos_flutter/features/home/infrastucture/models/menu_item.dart';

import '../../../../../design/design.dart';

class MenuTile extends StatelessWidget {
  final MenuItemModel menu;

  const MenuTile({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideMenuBloc, SideMenuState>(
      builder: (context, state) {
        final bool isCollapsed = state.isCollapsed;
        final int selectedMenu = state.selectedMenuIndex;

        return Material(
          color: Colors.transparent,
          child: ListTile(
            contentPadding: const EdgeInsets.only(
              top: Units.edgeInsetsSmall,
              bottom: Units.edgeInsetsSmall,
            ),
            selected: menu.index == selectedMenu,
            onTap: () {
              context.read<SideMenuBloc>().add(SelectMenuItemEvent(menu.index));
            },
            selectedTileColor: Colours.colorsButtonMenu,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Units.radiusXXXXXLarge),
            ),
            leading: Padding(
              padding: EdgeInsets.only(
                  left: isCollapsed
                      ? Units.edgeInsetsXXXLarge
                      : Units.edgeInsetsLarge),
              child: SvgPicture.asset(
                menu.icon,
                color: menu.index == selectedMenu
                    ? Colours.white
                    : Colours.colorsButtonMenu,
              ),
            ),
            title: isCollapsed
                ? null
                : Text(
                    menu.title,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyles.interRegularTiny,
                  ),
          ),
        );
      },
    );
  }
}
