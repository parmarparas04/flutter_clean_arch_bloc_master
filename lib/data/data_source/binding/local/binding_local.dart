import 'package:first_app/app/constant.dart';
import 'package:first_app/data/data_source/binding/binding_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BindingLocal implements BindingDataSource {
  Future<bool> getBoolValue(String key);
  Future<String> getStringValue(String key);
}

class BindingLocalImpl implements BindingLocal {
  final SharedPreferences _sharedPreferences;

  BindingLocalImpl(this._sharedPreferences);
  @override
  Future<bool> getBoolValue(String key) async {
    return _sharedPreferences.getBool(key) ?? false;
  }

  @override
  Future<String> getStringValue(String key) async {
    return _sharedPreferences.getString(key) ?? EMPTY;
  }
}
