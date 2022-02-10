import 'package:first_app/data/data_source/binding/binding_datasource.dart';
import 'package:first_app/data/network/app_api.dart';
import 'package:first_app/data/network/network_info.dart';
import 'package:first_app/data/request/request.dart';
import 'package:first_app/data/responses/responses.dart';

abstract class BindingRemote implements BindingDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<bool> isConnected();
}

class BindingRemoteImpl implements BindingRemote {
  final AppServiceClient _appServiceClient;
  final NetworkInfo _networkInfo;
  BindingRemoteImpl(this._appServiceClient, this._networkInfo);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, "", "");
  }

  @override
  Future<bool> isConnected() async {
    return await _networkInfo.isConnected;
  }
}
