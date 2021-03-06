import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ),
              );
            },
            child: Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 15.0),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                (materialState) => Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return "E-mail inválido!";
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida!";
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: InkWell(
                      onTap: () {
                        if (_emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Insira seu email para recuperar a senha!'),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        else {
                          model.recoverPass(_emailController.text);

                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('Confira seu email!'),
                              backgroundColor: Theme.of(context).primaryColor,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        style: TextStyle(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (materialState) => Theme.of(context).primaryColor,
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (materialState) => Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}

                      model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Falha ao entrar!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
