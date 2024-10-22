import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog/cubits/login_cubit.dart';
import 'package:blog/ui/screens/posts_screen.dart';
import 'package:blog/ui/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  //LOGO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PostsScreen()));
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        //List
        //builder
        //items
        //--button, text , checkbox
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: _usernameController,
                  label: 'Username',
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 24),
                state is LoginLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().login(
                                _usernameController.text,
                                _passwordController.text,
                              );
                        },
                        child: Text('Login'),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}