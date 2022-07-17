import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtual_store/screens/home_screen.dart';
import 'package:virtual_store/service/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confpassController = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Nome',
              ),
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Digite um nome válido';
                }
              },
            ),
            const SizedBox(height: 25),
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
                  return "Digite uma senha válida";
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confpassController,
              decoration: InputDecoration(
                hintText: 'Confirme a senha',
                suffixIcon: IconButton(
                  icon: showConfirmPassword
                      ? const Icon(CupertinoIcons.eye)
                      : const Icon(CupertinoIcons.eye_slash),
                  color: showConfirmPassword ? primaryColor : Colors.grey,
                  onPressed: () {
                    setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    });
                  },
                ),
              ),
              obscureText: showConfirmPassword ? false : true,
              validator: (text1) {
                if (text1!.isEmpty || text1.length < 8) {
                  return "Confirme a senha";
                } else if (_passController.text != _confpassController.text){
                  return "As senhas não coincidem";
                }
              },
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              width: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                child: const Text(
                  'Criar conta',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final email = _emailController.text;
                    final password = _passController.text;

                    AuthService().createUser(
                        name: name,
                        email: email,
                        password: password,
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
