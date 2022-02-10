import 'package:dartz/dartz.dart';
import 'package:first_app/data/data_source/binding/remote/binding_remote.dart';
import 'package:first_app/data/data_source/common/base_datasource_factory.dart';
import 'package:first_app/data/data_source/datasource_factory.dart';
import 'package:first_app/data/mapper/mapper.dart';
import 'package:first_app/data/network/error_handler.dart';
import 'package:first_app/data/network/failure.dart';
import 'package:first_app/data/request/request.dart';
import 'package:first_app/domain/model/model.dart';
import 'package:first_app/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final BindingDataSourceFactory bindingDataSourceFactory;
  RepositoryImpl(this.bindingDataSourceFactory);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    BindingRemote? bindingRemote = bindingDataSourceFactory
        .createData(DataSourceState.network) as BindingRemote;

    if (await bindingRemote.isConnected()) {
      try {
        // its safe to call the API
        final response = await bindingRemote.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left

          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
