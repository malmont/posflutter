import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/Caisse/presentation/pages/caisse_view_page.dart';
import 'package:pos_flutter/features/authentification/application/blocs/auth_bloc.dart';
import 'package:pos_flutter/features/authentification/presentation/pages/sign_in_view_page.dart';
import 'package:pos_flutter/features/dashboard/presentation/pages/dashboard_view_page.dart';
import 'package:pos_flutter/features/home/application/blocs/side_menu_bloc.dart';
import 'package:pos_flutter/features/home/presentation/widgets/sideMenu/animated_wave.dart';
import 'package:pos_flutter/features/home/side_menu/side_menu.dart';
import 'package:pos_flutter/features/order/presentation/pages/order_view.dart';
import 'package:pos_flutter/features/payment/presentation/pages/payement_view_page.dart';
import 'package:pos_flutter/features/products/presentation/pages/product_view_page.dart';
import 'package:pos_flutter/features/seeting/presentation/pages/seeting_view_page.dart';

class MainViewPage extends StatelessWidget {
  const MainViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    final List<Widget> pages = [
      const ProductViewPage(),
      const OrderView(),
      const CaisseView(),
      const PaymentViewPage(),
    ];

    return BlocBuilder<SideMenuBloc, SideMenuState>(
      builder: (context, state) {
        bool isCollapsed = state.isCollapsed;
        int selectedMenu = state.selectedMenuIndex;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      const AnimatedWave(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isCollapsed ? 128 : 280,
                          decoration: BoxDecoration(
                            color: colorScheme.background,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF1F1D2B),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const SideMenu(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Builder(
                  builder: (context) {
                    if (selectedMenu == 4) {
                      context.read<AuthBloc>().add(SignOutEvent());
                      context
                          .read<SideMenuBloc>()
                          .add(const ChangeMenuIndexEvent(0));
                      Future.microtask(() {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignInViewPage(),
                          ),
                        );
                      });
                      return const SizedBox.shrink();
                    } else {
                      return pages[selectedMenu];
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
