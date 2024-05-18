import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/login_bloc.dart';

class LoginPinForm extends StatelessWidget {
  const LoginPinForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PinCodeInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _AuthenticateButton(),
          ],
        ),
      ),
    );
  }
}

class _PinCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.pinCode != current.pinCode,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (pinCode) =>
              context.read<LoginBloc>().add(LoginPinCodeChanged(pinCode)),
          decoration: InputDecoration(
            labelText: 'pinCode',
            errorText:
            state.pinCode.displayError != null ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _AuthenticateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          onPressed: state.isValid
              ? () {
            context.read<LoginBloc>().add(const PinSubmitted());
          }
              : null,
          child: const Text('Authenticate'),
        );
      },
    );
  }
}