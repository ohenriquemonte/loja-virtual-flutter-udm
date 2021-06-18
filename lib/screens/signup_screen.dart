import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Conta'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Nome Completo'),
              validator: (text) {
                if (text.isEmpty) return "Nome Completo inválido!";
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(hintText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text.isEmpty || !text.contains('@'))
                  return "E-mail inválido";
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
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(hintText: 'Endereço'),
              validator: (text) {
                if (text.isEmpty) return "Endereço inválido!";
                return null;
              },
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                child: Text(
                  'Criar Conta',
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
