import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user_model.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Recuperar senha'),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 340,
            height: 190,
            child: Card(
              elevation: 20,
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
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
                    ),
                    const SizedBox(height: 30),
                    ScopedModelDescendant<UserModel>(builder: (context, child, model){
                      return Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          child: const Text(
                            'Enviar código',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              String email = _emailController.text;
                              model.sendResetPassEmail(email: email, onSuccess: _onSuccess, onFail: _onFail);
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Email de recuperação enviado!'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Falha ao enviar email de recuperação!', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
