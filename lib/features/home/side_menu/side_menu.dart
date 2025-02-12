import 'package:pos_flutter/core/router/app_router.dart';
import 'package:pos_flutter/features/authentification/application/blocs/auth_bloc.dart';
import 'package:pos_flutter/features/home/application/blocs/side_menu_bloc.dart';
import 'package:pos_flutter/features/home/presentation/widgets/sideMenu/hide_menu.dart';
import 'package:pos_flutter/features/home/presentation/widgets/sideMenu/menu_tile.dart';
import 'package:pos_flutter/features/home/presentation/widgets/sideMenu/profile_header.dart';
import 'package:pos_flutter/features/home/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../design/design.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isAdmin = false;
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      isAdmin = authState.user.roles.contains("ROLE_ADMIN");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.signIn,
            (Route<dynamic> route) => false,
          );
        }
        // if (state is Authenticated) {
        //   setState(() {
        //     isAdmin = state.user.roles.contains("ROLE_ADMIN");
        //   });
        // }
      },
      child: BlocBuilder<SideMenuBloc, SideMenuState>(
        builder: (context, state) {
          bool isCollapsed = state.isCollapsed;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isCollapsed ? 128 : 280,
            decoration: BoxDecoration(
              color: Colours.primaryPalette,
              borderRadius: BorderRadius.circular(Units.radiusXXXXXXLarge),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(Units.edgeInsetsLarge),
                      child: ProfileHeader(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Units.edgeInsetsXXLarge),
                      child: Divider(height: 0),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: Units.edgeInsetsLarge,
                          horizontal: Units.edgeInsetsXLarge,
                        ),
                        children: menuItems.map((item) {
                          bool disabled = false;
                          if ([1, 2, 3].contains(item.index) && !isAdmin) {
                            disabled = true;
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Units.edgeInsetsLarge),
                            child: MenuTile(menu: item, disabled: disabled),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  right: Units.position,
                  top: Units.positionXXXLarge,
                  child: HideMenu(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
