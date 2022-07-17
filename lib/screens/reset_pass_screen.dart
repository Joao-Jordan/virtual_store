import 'package:flutter/material.dart';
import 'package:virtual_store/service/auth_service.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key? key}) : super(key: key);

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
          title: Text('Recuperar senha'),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 340,
            height: 190,
            child: Card(
              elevation: 20,
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.center,
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
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
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
                            AuthService().sendResetPassEmail(email: email);

                            Navigator.of(context).pop();
                          }

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
