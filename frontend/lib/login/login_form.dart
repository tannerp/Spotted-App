import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/login/bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Center(
            child: Container(
             alignment: Alignment.center,
             height: 250,
             width: 400,
             padding: EdgeInsets.all(30),
             decoration: BoxDecoration(
                border: Border.all(
                color: Colors.black,
               ),
                borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                new Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                  onPressed:
                      state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('Login'),
                   ),
                  RaisedButton(
                  onPressed:                  
                      () {
                        Navigator.pushNamed(context, "/register");
  
                        },
                  child: Text('Register'),
                )
                ]
                ),
                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          )));
        },
      ),
    );
  }
}
