import 'package:dartz/dartz.dart';
import 'package:first_app/data/network/failure.dart';
import 'package:first_app/data/request/request.dart';
import 'package:first_app/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
