
import 'package:bravo_cliente/common/theme_helper.dart';
import 'package:bravo_cliente/exceptions/auth_exception.dart';
import 'package:bravo_cliente/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key? key,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        // Login
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Registrar
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: _isLogin() ? 310 : 400,
      width: deviceSize.width * 0.75,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
           _isLogin()? 'Entre com sua conta' : 'Crie sua conta',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              decoration: ThemeHelper().textInputDecoration(
                'E-mail',
                'Entre com seu E-mail',
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _authData['email'] = email ?? '',
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Informe um e-mail válido.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: ThemeHelper().textInputDecoration(
                'Senha',
                'Entre com sua senha',
              ),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              controller: _passwordController,
              onSaved: (password) => _authData['password'] = password ?? '',
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 5) {
                  return 'Informe uma senha válida';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            if (_isSignup())
              TextFormField(
                decoration: ThemeHelper().textInputDecoration(
                  'Confirmar Senha',
                  'Confirme sua senha',
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _isLogin()
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController.text) {
                          return 'Senhas informadas não conferem.';
                        }
                        return null;
                      },
              ),
            SizedBox(height: 7),
            if (_isLoading)
              CircularProgressIndicator()
            else
              Container(
                decoration: ThemeHelper().buttonBoxDecoration(context),
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      40,
                      10,
                      40,
                      10,
                    ),
                    child: Text(
                      _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  style: ThemeHelper().buttonStyle(),
                ),
              ),
            SizedBox(height: 7),
            TextButton(
              onPressed: _switchAuthMode,
              child: Text(
                _isLogin()
                    ? 'NÃO TEM UMA CONTA? CRIE AQUI!'
                    : 'JÁ POSSUI CONTA?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
