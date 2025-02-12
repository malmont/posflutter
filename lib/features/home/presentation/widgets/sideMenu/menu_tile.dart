import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_flutter/features/home/application/blocs/side_menu_bloc.dart';
import 'package:pos_flutter/features/home/infrastucture/models/menu_item.dart';
import '../../../../../design/design.dart';

class MenuTile extends StatelessWidget {
  final MenuItemModel menu;
  final bool disabled; // Ajout du paramètre disabled

  const MenuTile({Key? key, required this.menu, this.disabled = false})
      : super(key: key);

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
            // Si l'item est disabled, on ne lui assigne pas d'action
            onTap: disabled
                ? null
                : () {
                    context
                        .read<SideMenuBloc>()
                        .add(SelectMenuItemEvent(menu.index));
                  },
            // Couleur différente pour un tile désactivé (par exemple, gris clair)
            selectedTileColor:
                disabled ? Colors.grey[300] : Colours.colorsButtonMenu,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Units.radiusXXXXXLarge),
            ),
            leading: Padding(
              padding: EdgeInsets.only(
                left: isCollapsed
                    ? Units.edgeInsetsXXXLarge
                    : Units.edgeInsetsLarge,
              ),
              child: SvgPicture.asset(
                menu.icon,
                // Si disabled, on affiche l'icône en gris
                color: disabled
                    ? Colors.grey
                    : (menu.index == selectedMenu
                        ? Colours.white
                        : Colours.colorsButtonMenu),
              ),
            ),
            title: isCollapsed
                ? null
                : Text(
                    menu.title,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    // Appliquer un style grisé si disabled
                    style: disabled
                        ? TextStyles.interRegularTiny
                            .copyWith(color: Colors.grey)
                        : TextStyles.interRegularTiny,
                  ),
          ),
        );
      },
    );
  }
}
