import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
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
              decoration: InputDecoration(hintText: 'Senha'),
              obscureText: true,
              validator: (text) {
                if (text.isEmpty || text.length < 6) return "Senha inválida!";
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: InkWell(
                  onTap: () {},
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}