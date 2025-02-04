import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pos_flutter/features/Caisse/application/blocs/caisse_bloc.dart';
import 'package:pos_flutter/features/cart/application/blocs/cart_bloc.dart';
import 'package:pos_flutter/features/home/application/blocs/side_menu_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/order_bloc/order_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/revenu_statistique_bloc/revenue_statistics_bloc.dart';
import 'package:pos_flutter/features/order/application/blocs/statistique_order/statistique_order_bloc.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/payment/application/blocs/payment_statistic_bloc/payment_statistic_bloc.dart';
import 'package:pos_flutter/features/products/application/blocs/product_bloc.dart';
import 'package:pos_flutter/features/products/application/scannerblocs/scanner_bloc.dart';
import 'package:pos_flutter/features/products/domain/entities/product/filter_product_params.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/core/router/app_router.dart';
import 'package:pos_flutter/di/injection_container.dart';
import 'package:pos_flutter/features/authentification/application/blocs/auth_bloc.dart';
import 'package:pos_flutter/features/authentification/application/viewmodels/signin_viewmodel.dart';
import 'package:pos_flutter/features/authentification/presentation/pages/sign_in_view_page.dart';
import 'package:pos_flutter/features/home/presentation/pages/MainViewPage.dart';

import 'features/payment/application/blocs/Payment_bloc/payment_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const envFile = String.fromEnvironment('ENV_FILE', defaultValue: ".env.prod");
  await dotenv.load(fileName: envFile);

  await configureDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              getIt<AuthBloc>()..add(CheckAuthenticationEvent()),
        ),
        provider.ChangeNotifierProvider<SignInViewModel>(
          create: (context) => SignInViewModel(getIt<AuthBloc>()),
        ),
        BlocProvider<SideMenuBloc>(
          create: (context) => SideMenuBloc(),
        ),
        BlocProvider(
          create: (context) => getIt<CartBloc>()..add(const GetCart()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<StatistiqueOrderBloc>()..add(const GetStatistiqueOrder()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<RevenueStatisticsBloc>()..add(const GetRevenueStatistics()),
        ),
        BlocProvider(
          create: (context) => getIt<PaymentStatisticBlocBloc>()
            ..add(const GetPaymentStatistic()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<OrderBloc>()..add(const GetOrders(FilterOrderParams())),
        ),
        BlocProvider(create: (context) => getIt<ScannerBloc>()),
        BlocProvider<CaisseBloc>(
          create: (context) =>
              getIt<CaisseBloc>()..add(const GetCaisse(days: 1)),
        ),
        BlocProvider(
          create: (context) => getIt<ProductBloc>()
            ..add(const GetProducts(FilterProductParams())),
        ),
        BlocProvider(
          create: (context) =>
              getIt<PaymentBloc>()..add(const GetPayments(FilterOrderParams())),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MaterialApp(
            title: 'POS Flutter',
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      constraints.maxWidth > 1280 ? 1920 : constraints.maxWidth,
                  maxHeight: constraints.maxHeight > 1024
                      ? 1080
                      : constraints.maxHeight,
                ),
                child: const AuthWrapper(),
              ),
            ),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          EasyLoading.dismiss();
          return const MainViewPage();
        } else if (state is Unauthenticated ||
            state is AuthFailure ||
            state is AuthLoggedOut) {
          EasyLoading.dismiss();
          return const SignInViewPage();
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
