// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:pos_flutter/core/config/environment_config.dart' as _i1044;
import 'package:pos_flutter/core/config/environment_repository.dart' as _i310;
import 'package:pos_flutter/core/network/network_info.dart' as _i40;
import 'package:pos_flutter/core/services/api/caisse_api_client.dart' as _i784;
import 'package:pos_flutter/core/services/api/order_api_client.dart' as _i482;
import 'package:pos_flutter/core/services/api/payment_api_client.dart' as _i577;
import 'package:pos_flutter/core/services/api/product_api_client.dart' as _i303;
import 'package:pos_flutter/core/services/api/statistique_order_api_client.dart'
    as _i187;
import 'package:pos_flutter/core/services/api/user_api_client.dart' as _i324;
import 'package:pos_flutter/core/services/data_sources/local/caisse_local_data_source.dart'
    as _i1030;
import 'package:pos_flutter/core/services/data_sources/local/cart_local_data_source.dart'
    as _i531;
import 'package:pos_flutter/core/services/data_sources/local/order_local_data_source.dart'
    as _i339;
import 'package:pos_flutter/core/services/data_sources/local/payment_local_data_source.dart'
    as _i489;
import 'package:pos_flutter/core/services/data_sources/local/product_local_data_source.dart'
    as _i628;
import 'package:pos_flutter/core/services/data_sources/local/user_local_data_source.dart'
    as _i381;
import 'package:pos_flutter/core/services/data_sources/remote/caisse_remote_datat_source.dart'
    as _i517;
import 'package:pos_flutter/core/services/data_sources/remote/order_remote_data_source.dart'
    as _i950;
import 'package:pos_flutter/core/services/data_sources/remote/payment_remote_data_source.dart'
    as _i807;
import 'package:pos_flutter/core/services/data_sources/remote/product_remote-data_sourceImpl.dart'
    as _i308;
import 'package:pos_flutter/core/services/data_sources/remote/user_remote_data_source.dart'
    as _i1036;
import 'package:pos_flutter/di/register_module.dart' as _i93;
import 'package:pos_flutter/features/authentification/application/blocs/auth_bloc.dart'
    as _i644;
import 'package:pos_flutter/features/authentification/application/viewmodels/signin_viewmodel.dart'
    as _i229;
import 'package:pos_flutter/features/authentification/domain/repositories/auth_repository.dart'
    as _i40;
import 'package:pos_flutter/features/authentification/domain/usecases/is_signed_usecase.dart'
    as _i935;
import 'package:pos_flutter/features/authentification/domain/usecases/sign_in_usecase.dart'
    as _i112;
import 'package:pos_flutter/features/authentification/domain/usecases/sign_out_usecase.dart'
    as _i360;
import 'package:pos_flutter/features/authentification/infrastucture/repositories/auth_repository_impl.dart'
    as _i750;
import 'package:pos_flutter/features/Caisse/application/blocs/caisse_bloc.dart'
    as _i13;
import 'package:pos_flutter/features/Caisse/domain/repositories/caisse_repository.dart'
    as _i402;
import 'package:pos_flutter/features/Caisse/domain/usecases/clear_local_caisse_use_case.dart'
    as _i712;
import 'package:pos_flutter/features/Caisse/domain/usecases/close_caisse_use_case.dart'
    as _i360;
import 'package:pos_flutter/features/Caisse/domain/usecases/deposit_caisse_use_case.dart'
    as _i951;
import 'package:pos_flutter/features/Caisse/domain/usecases/get_cached_caisse_use_case.dart'
    as _i525;
import 'package:pos_flutter/features/Caisse/domain/usecases/get_remote_caisse_use_case.dart'
    as _i594;
import 'package:pos_flutter/features/Caisse/domain/usecases/open_caisse_use_case.dart'
    as _i925;
import 'package:pos_flutter/features/Caisse/domain/usecases/with_draw_caisse_use_case.dart'
    as _i722;
import 'package:pos_flutter/features/Caisse/infrastucture/repositories/caisse_repository_impl.dart'
    as _i283;
import 'package:pos_flutter/features/cart/application/blocs/cart_bloc.dart'
    as _i734;
import 'package:pos_flutter/features/cart/domain/repositories/cart_repository.dart'
    as _i571;
import 'package:pos_flutter/features/cart/domain/usecases/add_cart_item_usecase.dart'
    as _i143;
import 'package:pos_flutter/features/cart/domain/usecases/clear_cart_usecase.dart'
    as _i801;
import 'package:pos_flutter/features/cart/domain/usecases/get_cached_cart_usecase.dart'
    as _i148;
import 'package:pos_flutter/features/cart/domain/usecases/remove_cart_usecase.dart'
    as _i300;
import 'package:pos_flutter/features/cart/infrastucture/repositories/cart_repository_impl.dart'
    as _i290;
import 'package:pos_flutter/features/order/application/blocs/order_bloc/order_bloc.dart'
    as _i20;
import 'package:pos_flutter/features/order/application/blocs/revenu_statistique_bloc/revenue_statistics_bloc.dart'
    as _i319;
import 'package:pos_flutter/features/order/application/blocs/statistique_order/statistique_order_bloc.dart'
    as _i243;
import 'package:pos_flutter/features/order/domain/repositories/order_repository.dart'
    as _i342;
import 'package:pos_flutter/features/order/domain/usecases/add_order_usecase.dart'
    as _i434;
import 'package:pos_flutter/features/order/domain/usecases/clear_local_order_usecase.dart'
    as _i767;
import 'package:pos_flutter/features/order/domain/usecases/clear_local_revenue_statistics_useCase.dart'
    as _i975;
import 'package:pos_flutter/features/order/domain/usecases/clear_local_statistique_order_useCase.dart'
    as _i224;
import 'package:pos_flutter/features/order/domain/usecases/get_cached_orders_usecase.dart'
    as _i739;
import 'package:pos_flutter/features/order/domain/usecases/get_cached_revenue_statistics_useCase.dart'
    as _i721;
import 'package:pos_flutter/features/order/domain/usecases/get_cached_statistique_order_useCase.dart'
    as _i684;
import 'package:pos_flutter/features/order/domain/usecases/get_remote_orders_usecase.dart'
    as _i555;
import 'package:pos_flutter/features/order/domain/usecases/get_remote_revenue_statistics_useCase.dart'
    as _i933;
import 'package:pos_flutter/features/order/domain/usecases/get_remote_statistique_order_UseCase.dart'
    as _i966;
import 'package:pos_flutter/features/order/infrastucture/repositories/order_repository_impl.dart'
    as _i263;
import 'package:pos_flutter/features/payment/application/blocs/Payment_bloc/payment_bloc.dart'
    as _i145;
import 'package:pos_flutter/features/payment/application/blocs/payment_statistic_bloc/payment_statistic_bloc.dart'
    as _i58;
import 'package:pos_flutter/features/payment/domain/repositories/payment_repository.dart'
    as _i660;
import 'package:pos_flutter/features/payment/domain/usecases/clear_cached_payment_statistic_useCase.dart'
    as _i874;
import 'package:pos_flutter/features/payment/domain/usecases/get_cached_payment_statistic_useCase.dart'
    as _i564;
import 'package:pos_flutter/features/payment/domain/usecases/get_cached_payment_usecase.dart'
    as _i974;
import 'package:pos_flutter/features/payment/domain/usecases/get_remote_payment_statistic_useCase.dart'
    as _i880;
import 'package:pos_flutter/features/payment/domain/usecases/get_remote_payment_usecase.dart'
    as _i510;
import 'package:pos_flutter/features/payment/infrastucture/repositories/payment_repository_impl.dart'
    as _i805;
import 'package:pos_flutter/features/products/application/blocs/product_bloc.dart'
    as _i117;
import 'package:pos_flutter/features/products/domain/repositories/product_repository.dart'
    as _i116;
import 'package:pos_flutter/features/products/domain/usecases/get_product_usecase.dart'
    as _i323;
import 'package:pos_flutter/features/products/infrastucture/repositories/product_repository_impl.dart'
    as _i980;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => registerModule.internetConnectionChecker);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => registerModule.secureStorage);
    gh.lazySingleton<_i519.Client>(() => registerModule.httpClient);
    gh.lazySingleton<_i310.EnvironmentRepository>(
        () => _i310.EnvironmentRepository());
    gh.lazySingleton<_i381.UserLocalDataSource>(
        () => _i381.UserLocalDataSourceImpl(
              sharedPreferences: gh<_i460.SharedPreferences>(),
              secureStorage: gh<_i558.FlutterSecureStorage>(),
            ));
    gh.lazySingleton<_i40.NetworkInfo>(
        () => _i40.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
    gh.lazySingleton<_i339.OrderLocalDataSource>(() =>
        _i339.OrderLocalDataSourceImpl(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i628.ProductLocalDataSource>(() =>
        _i628.ProductLocalDataSourceImpl(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i531.CartLocalDataSource>(() =>
        _i531.CartLocalDataSourceImpl(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i489.PaymentLocalDataSource>(() =>
        _i489.PaymentLocalDataSourceImpl(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i1030.CaisseLocalDataSOurce>(() =>
        _i1030.CaisseLocalDataSOurceImpl(
            sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i1044.EnvironmentConfig>(
        () => _i1044.EnvironmentConfig(gh<_i310.EnvironmentRepository>()));
    gh.lazySingleton<_i571.CartRepository>(() => _i290.CartRepositoryImpl(
          localDataSource: gh<_i531.CartLocalDataSource>(),
          userLocalDataSource: gh<_i381.UserLocalDataSource>(),
          networkInfo: gh<_i40.NetworkInfo>(),
        ));
    gh.lazySingleton<_i300.RemoveCartUseCase>(
        () => _i300.RemoveCartUseCase(gh<_i571.CartRepository>()));
    gh.lazySingleton<_i148.GetCachedCartUseCase>(
        () => _i148.GetCachedCartUseCase(gh<_i571.CartRepository>()));
    gh.lazySingleton<_i143.AddCartUseCase>(
        () => _i143.AddCartUseCase(gh<_i571.CartRepository>()));
    gh.lazySingleton<_i801.ClearCartUseCase>(
        () => _i801.ClearCartUseCase(gh<_i571.CartRepository>()));
    gh.factory<_i734.CartBloc>(() => _i734.CartBloc(
          gh<_i148.GetCachedCartUseCase>(),
          gh<_i143.AddCartUseCase>(),
          gh<_i801.ClearCartUseCase>(),
          gh<_i300.RemoveCartUseCase>(),
        ));
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio(
          gh<_i381.UserLocalDataSource>(),
          gh<_i1044.EnvironmentConfig>(),
        ));
    gh.lazySingleton<_i324.UserApiClient>(
        () => registerModule.userApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i303.ProductApiClient>(
        () => registerModule.productApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i482.OrderApiClient>(
        () => registerModule.orderApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i784.CaisseApiClient>(
        () => registerModule.caisseApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i577.PaymentApiClient>(
        () => registerModule.paymentApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i187.StatistiqueOrderApiClient>(
        () => registerModule.statistiqueOrderApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i807.PaymentRemoteDataSource>(() =>
        _i807.PaymentRemoteDataSourceImpl(
            apiClient: gh<_i577.PaymentApiClient>()));
    gh.lazySingleton<_i1036.UserRemoteDataSource>(
        () => _i1036.UserRemoteDataSourceImpl(
              apiClient: gh<_i324.UserApiClient>(),
              userLocalDataSource: gh<_i381.UserLocalDataSource>(),
            ));
    gh.lazySingleton<_i308.ProductRemoteDataSource>(() =>
        _i308.ProductRemoteDataSourceImpl(
            apiClient: gh<_i303.ProductApiClient>()));
    gh.lazySingleton<_i517.CaisseRemoteDataSource>(() =>
        _i517.CaisseRemoteDataSourceImpl(
            apiClient: gh<_i784.CaisseApiClient>()));
    gh.lazySingleton<_i40.AuthRepository>(() => _i750.AuthRepositoryImpl(
          remoteDataSource: gh<_i1036.UserRemoteDataSource>(),
          localDataSource: gh<_i381.UserLocalDataSource>(),
          networkInfo: gh<_i40.NetworkInfo>(),
        ));
    gh.lazySingleton<_i116.ProductRepository>(() => _i980.ProductRepositoryImpl(
          remoteDataSource: gh<_i308.ProductRemoteDataSource>(),
          localDataSource: gh<_i628.ProductLocalDataSource>(),
          networkInfo: gh<_i40.NetworkInfo>(),
        ));
    gh.lazySingleton<_i402.CaisseRepository>(() => _i283.CaisseRepositoryImpl(
          remoteDataSource: gh<_i517.CaisseRemoteDataSource>(),
          localDataSource: gh<_i1030.CaisseLocalDataSOurce>(),
          networkInfo: gh<_i40.NetworkInfo>(),
          userLocalDataSource: gh<_i381.UserLocalDataSource>(),
        ));
    gh.lazySingleton<_i950.OrderRemoteDataSource>(
        () => _i950.OrderRemoteDataSourceImpl(
              gh<_i187.StatistiqueOrderApiClient>(),
              apiClient: gh<_i482.OrderApiClient>(),
            ));
    gh.lazySingleton<_i342.OrderRepository>(() => _i263.OrderRepositoryImpl(
          remoteDataSource: gh<_i950.OrderRemoteDataSource>(),
          localDataSource: gh<_i339.OrderLocalDataSource>(),
          userLocalDataSource: gh<_i381.UserLocalDataSource>(),
          networkInfo: gh<_i40.NetworkInfo>(),
        ));
    gh.lazySingleton<_i660.PaymentRepository>(() => _i805.PaymentRepositoryImpl(
          gh<_i381.UserLocalDataSource>(),
          remoteDataSource: gh<_i807.PaymentRemoteDataSource>(),
          localDataSource: gh<_i489.PaymentLocalDataSource>(),
          networkInfo: gh<_i40.NetworkInfo>(),
        ));
    gh.lazySingleton<_i323.GetProductUseCase>(
        () => _i323.GetProductUseCase(gh<_i116.ProductRepository>()));
    gh.lazySingleton<_i510.GetRemotePaymentUsecase>(
        () => _i510.GetRemotePaymentUsecase(gh<_i660.PaymentRepository>()));
    gh.lazySingleton<_i564.GetCachedPaymentStatisticUsecase>(() =>
        _i564.GetCachedPaymentStatisticUsecase(gh<_i660.PaymentRepository>()));
    gh.lazySingleton<_i874.ClearCachedPaymentStatisticUseCase>(() =>
        _i874.ClearCachedPaymentStatisticUseCase(
            gh<_i660.PaymentRepository>()));
    gh.lazySingleton<_i974.GetCachedPaymentUsecase>(
        () => _i974.GetCachedPaymentUsecase(gh<_i660.PaymentRepository>()));
    gh.lazySingleton<_i880.GetRemotePaymentStatisticUsecase>(() =>
        _i880.GetRemotePaymentStatisticUsecase(gh<_i660.PaymentRepository>()));
    gh.lazySingleton<_i966.GetRemoteStatistiqueOrderUseCase>(() =>
        _i966.GetRemoteStatistiqueOrderUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i434.AddOrderUseCase>(
        () => _i434.AddOrderUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i555.GetRemoteOrdersUseCase>(
        () => _i555.GetRemoteOrdersUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i684.GetCachedStatisticsOrderUseCase>(() =>
        _i684.GetCachedStatisticsOrderUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i933.GetRemoteRevenueStatisticsUseCase>(() =>
        _i933.GetRemoteRevenueStatisticsUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i767.ClearLocalOrdersUseCase>(
        () => _i767.ClearLocalOrdersUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i721.GetCachedRevenueStatisticsUseCase>(() =>
        _i721.GetCachedRevenueStatisticsUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i739.GetCachedOrdersUseCase>(
        () => _i739.GetCachedOrdersUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i224.ClearLocalStatisticsOrderUseCase>(() =>
        _i224.ClearLocalStatisticsOrderUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i975.ClearLocalRevenueStatisticsUseCase>(() =>
        _i975.ClearLocalRevenueStatisticsUseCase(gh<_i342.OrderRepository>()));
    gh.lazySingleton<_i935.CheckTokenValidityUseCase>(
        () => _i935.CheckTokenValidityUseCase(gh<_i40.AuthRepository>()));
    gh.lazySingleton<_i112.SignInUseCase>(
        () => _i112.SignInUseCase(gh<_i40.AuthRepository>()));
    gh.lazySingleton<_i360.SignOutUseCase>(
        () => _i360.SignOutUseCase(gh<_i40.AuthRepository>()));
    gh.factory<_i644.AuthBloc>(() => _i644.AuthBloc(
          checkTokenValidityUseCase: gh<_i935.CheckTokenValidityUseCase>(),
          signInUseCase: gh<_i112.SignInUseCase>(),
          localDataSource: gh<_i381.UserLocalDataSource>(),
          signOutUseCase: gh<_i360.SignOutUseCase>(),
        ));
    gh.factory<_i117.ProductBloc>(
        () => _i117.ProductBloc(gh<_i323.GetProductUseCase>()));
    gh.factory<_i58.PaymentStatisticBlocBloc>(
        () => _i58.PaymentStatisticBlocBloc(
              gh<_i880.GetRemotePaymentStatisticUsecase>(),
              gh<_i564.GetCachedPaymentStatisticUsecase>(),
              gh<_i874.ClearCachedPaymentStatisticUseCase>(),
            ));
    gh.lazySingleton<_i951.DepositCaisseUseCase>(
        () => _i951.DepositCaisseUseCase(gh<_i402.CaisseRepository>()));
    gh.lazySingleton<_i925.OpenCaisseUseCase>(
        () => _i925.OpenCaisseUseCase(gh<_i402.CaisseRepository>()));
    gh.lazySingleton<_i525.GetCachedCaisseUseCase>(
        () => _i525.GetCachedCaisseUseCase(gh<_i402.CaisseRepository>()));
    gh.lazySingleton<_i360.CloseCaisseUseCase>(
        () => _i360.CloseCaisseUseCase(gh<_i402.CaisseRepository>()));
    gh.lazySingleton<_i722.WithDrawCaisseUseCase>(
        () => _i722.WithDrawCaisseUseCase(gh<_i402.CaisseRepository>()));
    gh.lazySingleton<_i712.ClearLocalCaisseUseCase>(
        () => _i712.ClearLocalCaisseUseCase(gh<_i402.CaisseRepository>()));
    gh.lazySingleton<_i594.GetRemoteCaisseUseCase>(
        () => _i594.GetRemoteCaisseUseCase(gh<_i402.CaisseRepository>()));
    gh.factory<_i13.CaisseBloc>(() => _i13.CaisseBloc(
          gh<_i594.GetRemoteCaisseUseCase>(),
          gh<_i525.GetCachedCaisseUseCase>(),
          gh<_i712.ClearLocalCaisseUseCase>(),
          gh<_i360.CloseCaisseUseCase>(),
          gh<_i925.OpenCaisseUseCase>(),
          gh<_i722.WithDrawCaisseUseCase>(),
          gh<_i951.DepositCaisseUseCase>(),
        ));
    gh.factory<_i243.StatistiqueOrderBloc>(() => _i243.StatistiqueOrderBloc(
          gh<_i966.GetRemoteStatistiqueOrderUseCase>(),
          gh<_i684.GetCachedStatisticsOrderUseCase>(),
          gh<_i224.ClearLocalStatisticsOrderUseCase>(),
        ));
    gh.factory<_i20.OrderBloc>(() => _i20.OrderBloc(
          gh<_i555.GetRemoteOrdersUseCase>(),
          gh<_i739.GetCachedOrdersUseCase>(),
          gh<_i767.ClearLocalOrdersUseCase>(),
          gh<_i434.AddOrderUseCase>(),
        ));
    gh.factory<_i145.PaymentBloc>(() => _i145.PaymentBloc(
          gh<_i510.GetRemotePaymentUsecase>(),
          gh<_i974.GetCachedPaymentUsecase>(),
        ));
    gh.factory<_i229.SignInViewModel>(
        () => _i229.SignInViewModel(gh<_i644.AuthBloc>()));
    gh.factory<_i319.RevenueStatisticsBloc>(() => _i319.RevenueStatisticsBloc(
          gh<_i933.GetRemoteRevenueStatisticsUseCase>(),
          gh<_i721.GetCachedRevenueStatisticsUseCase>(),
          gh<_i975.ClearLocalRevenueStatisticsUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i93.RegisterModule {}
