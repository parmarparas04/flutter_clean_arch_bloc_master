import 'package:first_app/data/data_source/binding/binding_datasource.dart';
import 'package:first_app/data/network/app_api.dart';
import 'package:first_app/data/request/request.dart';
import 'package:first_app/data/responses/responses.dart';

abstract class RemoteDataSource implements BindingDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, "", "");
  }
}
