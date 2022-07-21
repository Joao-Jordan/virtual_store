import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/screens/reset_pass_screen.dart';
import 'package:virtual_store/screens/signup_screen.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.account_circle,
                    color: primaryColor,
                    size: 150,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text!.isEmpty ||
                        !text.contains('@') ||
                        !text.contains('.com')) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    suffixIcon: IconButton(
                      icon: showPassword
                          ? const Icon(CupertinoIcons.eye)
                          : const Icon(CupertinoIcons.eye_slash),
                      color: showPassword ? primaryColor : Colors.grey,
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: showPassword ? false : true,
                  validator: (text) {
                    if (text!.isEmpty || text.length < 8) {
                      return "Senha inválida";
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ResetPassword()));
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    child: const Text(
                      'Entrar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passController.text;

                        model.signInWithEmail(
                          email: email,
                          password: password,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ainda não possui uma conta?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    TextButton(
                      child: Text(
                        'Criar conta',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ou, entre com o ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        model.signInWithGoogle(onSuccess: _onSuccess,onFail: _onFail);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image(
                          width: 80,
                          image: AssetImage('assets/images/google_logo.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _onSuccess() {
      Navigator.of(context).pop();
  }

  _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Falha ao Entrar', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
