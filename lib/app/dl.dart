import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:first_app/app/app_pref.dart';
import 'package:first_app/data/data_source/binding/local/binding_local.dart';
import 'package:first_app/data/data_source/binding/remote/binding_remote.dart';
import 'package:first_app/data/data_source/datasource_factory.dart';
import 'package:first_app/domain/usecase/login_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_app/data/data_source/remote_data_source.dart';
import 'package:first_app/data/network/app_api.dart';
import 'package:first_app/data/network/dio_factory.dart';
import 'package:first_app/data/network/network_info.dart';
import 'package:first_app/data/repository/repository_impl.dart';
import 'package:first_app/domain/repository/repository.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance()));

  // Binding local
  instance
      .registerLazySingleton<BindingLocal>(() => BindingLocalImpl(instance()));

  // binding remote data source
  instance.registerLazySingleton<BindingRemote>(
      () => BindingRemoteImpl(instance(), instance()));

  ///[Repository]
  instance.registerFactory<BindingDataSourceFactory>(
    () => BindingDataSourceFactory(
        bindingLocal: instance(), bindingRemote: instance()),
  );
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  }
}
