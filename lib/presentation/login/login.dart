import 'package:first_app/app/dl.dart';
import 'package:first_app/domain/usecase/login_usecase.dart';
import 'package:first_app/presentation/login/bloc/login_bloc.dart';
import 'package:first_app/presentation/resources/color_manager.dart';
import 'package:first_app/presentation/resources/strings_manager.dart';
import 'package:first_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginUseCase _useCase = instance<LoginUseCase>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: BlocProvider(
          create: (context) => LoginBloc(_useCase),
          child: BlocBuilder<LoginBloc, LoginState>(builder: (ctx, state) {
            if (state is LoginLoadingState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: CircularProgressIndicator()),
                  Text(state.loadingStatus),
                  if (state.icon != null)
                    Icon(
                      state.icon,
                      size: 30,
                    )
                ],
              );
            } else if (state is LoginLoadedState) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                showInSnackBar(context, AppStrings.loginSuccessMsg);
              });
              return _getContentWidget(ctx);
            } else {
              return _getContentWidget(ctx);
            }
          }),
        ));
  }

  showInSnackBar(BuildContext cxt, String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  Widget _getContentWidget(BuildContext cxt) {
    return Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: AppSize.s100),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        hintText: AppStrings.username,
                        labelText: AppStrings.username,
                      )),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: AppStrings.password,
                      labelText: AppStrings.password,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: ElevatedButton(
                        onPressed: () => BlocProvider.of<LoginBloc>(cxt)
                            .add(LoginApiCallEvent()),
                        child: const Text(AppStrings.login)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
