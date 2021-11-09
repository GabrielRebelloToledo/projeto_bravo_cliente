
import 'package:bravo_cliente/models/user_register.dart';
import 'package:bravo_cliente/provider/user_register_provider.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _nameFocus = FocusNode();
  final _sexFocus = FocusNode();
  final _birthDayFocus = FocusNode();
  final _naturalidadeFocus = FocusNode();
  final _escolaridadeFocus = FocusNode();
  final _nameMotherFocus = FocusNode();
  final _nameFatherFocus = FocusNode();
  final _cepFocus = FocusNode();
  final _enderecoFocus = FocusNode();
  final _complementoFocus = FocusNode();
  final _bairroFocus = FocusNode();
  final _cidadeFocus = FocusNode();
  final _unidadefederativaFocus = FocusNode();
  final _cpfFocus = FocusNode();
  final _identidadeFocus = FocusNode();
  final _emissorFocus = FocusNode();
  final _dateEmissaoFocus = FocusNode();
  final _dddFocus = FocusNode();
  final _numbertelephoneFocus = FocusNode();
  final _emailFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;
  String termosString = 'Aceito';
  bool termosBool = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final useRegister = arg as UserRegister;
        _formData['id'] = useRegister.id;
        _formData['name'] = useRegister.name;
        _formData['sex'] = useRegister.sex;
        _formData['birthDay'] = useRegister.birthDay;
        _formData['naturalidade'] = useRegister.naturalidade;
        _formData['escolaridade'] = useRegister.escolaridade;
        _formData['nameMother'] = useRegister.nameMother;
        _formData['nameFather'] = useRegister.nameFather;
        _formData['cep'] = useRegister.cep;
        _formData['endereco'] = useRegister.endereco;
        _formData['complemento'] = useRegister.complemento;
        _formData['bairro'] = useRegister.bairro;
        _formData['cidade'] = useRegister.cidade;
        _formData['unidadefederativa'] = useRegister.unidadefederativa;
        _formData['cpf'] = useRegister.cpf;
        _formData['identidade'] = useRegister.identidade;
        _formData['emissor'] = useRegister.emissor;
        _formData['dateEmissao'] = useRegister.dateEmissao;
        _formData['ddd'] = useRegister.ddd;
        _formData['numbertelephone'] = useRegister.numbertelephone;
        _formData['email'] = useRegister.email;
        _formData['termos'] = useRegister.termos;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _sexFocus.dispose();
    _birthDayFocus.dispose();
    _naturalidadeFocus.dispose();
    _escolaridadeFocus.dispose();
    _nameMotherFocus.dispose();
    _nameFatherFocus.dispose();
    _cepFocus.dispose();
    _enderecoFocus.dispose();
    _complementoFocus.dispose();
    _bairroFocus.dispose();
    _cidadeFocus.dispose();
    _unidadefederativaFocus.dispose();
    _cpfFocus.dispose();
    _identidadeFocus.dispose();
    _emissorFocus.dispose();
    _dateEmissaoFocus.dispose();
    _dddFocus.dispose();
    _numbertelephoneFocus.dispose();
    _emailFocus.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<UserRegisterProvider>(
        context,
        listen: false,
      ).saveProduct(_formData);

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar o produto.'),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário do Entregador'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Termos e Serviços',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  value: termosBool,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      termosBool = value!;
                                      print(value);
                                      if (value == true) {
                                        print('Aqui');
                                        termosString = 'Aceito';
                                      }
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('Você aceita os termos e Serviços ?'),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            Routes.termos,
                                          );
                                        },
                                        child: Text(
                                          'Ler termos',
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                            padding: EdgeInsets.all(3)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Nome completo',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_nameFocus);
                        },
                        onSaved: (name) => _formData['name'] = name ?? '',
                        validator: (_name) {
                          final name = _name ?? '';

                          if (name.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }

                          if (name.trim().length < 3) {
                            return 'Nome precisa no mínimo de 3 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['sex']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Sexo:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_sexFocus);
                        },
                        onSaved: (sex) => _formData['sex'] = sex ?? '',
                        validator: (_sex) {
                          final sex = _sex ?? '';

                          if (sex.trim().isEmpty) {
                            return 'Sexo é obrigatório(Masculino ou Feminino) ';
                          }

                          if (sex.trim().length < 3) {
                            return 'Sexo precisa no mínimo de 3 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['birthDay']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Data de Aniversário:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_birthDayFocus);
                        },
                        onSaved: (birthDay) =>
                            _formData['birthDay'] = birthDay ?? '',
                        validator: (_birthDay) {
                          final birthDay = _birthDay ?? '';

                          if (birthDay.trim().isEmpty) {
                            return 'Data de Nascimento é obrigatória';
                          }

                          if (birthDay.trim().length < 10) {
                            return 'Data de Nascimento deve conter XX/XX/XXXX';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['naturalidade']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Naturalidade:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_naturalidadeFocus);
                        },
                        onSaved: (naturalidade) =>
                            _formData['naturalidade'] = naturalidade ?? '',
                        validator: (_naturalidade) {
                          final naturalidade = _naturalidade ?? '';

                          if (naturalidade.trim().isEmpty) {
                            return 'Naturalidade é obrigatório';
                          }

                          if (naturalidade.trim().length < 2) {
                            return 'Naturalidade precisa no mínimo de 2 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['escolaridade']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Escolaridade:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_escolaridadeFocus);
                        },
                        onSaved: (escolaridade) =>
                            _formData['escolaridade'] = escolaridade ?? '',
                        validator: (_escolaridade) {
                          final escolaridade = _escolaridade ?? '';

                          if (escolaridade.trim().isEmpty) {
                            return 'Escolaridade é obrigatório';
                          }

                          if (escolaridade.trim().length < 5) {
                            return 'Escolaridade precisa no mínimo de 5 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['nameMother']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Nome completo da Mãe:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_nameMotherFocus);
                        },
                        onSaved: (nameMother) =>
                            _formData['nameMother'] = nameMother ?? '',
                        validator: (_nameMother) {
                          final nameMother = _nameMother ?? '';

                          if (nameMother.trim().isEmpty) {
                            return 'Nome completo da Mãe é obrigatório';
                          }

                          if (nameMother.trim().length < 20) {
                            return 'Nome completo da Mãe precisa no mínimo de 20 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['nameFather']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Nome completo do Pai:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_nameFatherFocus);
                        },
                        onSaved: (nameFather) =>
                            _formData['nameFather'] = nameFather ?? '',
                        validator: (_nameFather) {
                          final nameFather = _nameFather ?? '';

                          if (nameFather.trim().isEmpty) {
                            return 'Nome completo dO Pai é obrigatório';
                          }

                          if (nameFather.trim().length < 20) {
                            return 'Nome completo dO Pai precisa no mínimo de 20 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['cep']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'CEP:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_cepFocus);
                        },
                        onSaved: (cep) => _formData['cep'] = cep ?? '',
                        validator: (_cep) {
                          final cep = _cep ?? '';

                          if (cep.trim().isEmpty) {
                            return 'CEP é obrigatório';
                          }

                          if (cep.trim().length < 14) {
                            return 'CEP precisa no mínimo de 20 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['endereco']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Endereço:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_enderecoFocus);
                        },
                        onSaved: (endereco) =>
                            _formData['endereco'] = endereco ?? '',
                        validator: (_endereco) {
                          final endereco = _endereco ?? '';

                          if (endereco.trim().isEmpty) {
                            return 'Endereço é obrigatório';
                          }

                          if (endereco.trim().length < 20) {
                            return 'Endereço precisa no mínimo de 20 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['complemento']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Complemento:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_complementoFocus);
                        },
                        onSaved: (complemento) =>
                            _formData['complemento'] = complemento ?? '',
                        validator: (_complemento) {
                          final complemento = _complemento ?? '';

                          if (complemento.trim().isEmpty) {
                            return 'Complemento é obrigatório';
                          }

                          if (complemento.trim().length < 1) {
                            return 'Complemento precisa no mínimo de 1 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['bairro']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Bairro:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_bairroFocus);
                        },
                        onSaved: (bairro) => _formData['bairro'] = bairro ?? '',
                        validator: (_bairro) {
                          final bairro = _bairro ?? '';

                          if (bairro.trim().isEmpty) {
                            return 'Bairro é obrigatório';
                          }

                          if (bairro.trim().length < 10) {
                            return 'Bairro precisa no mínimo de 10 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['cidade']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Cidade:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_cidadeFocus);
                        },
                        onSaved: (cidade) => _formData['cidade'] = cidade ?? '',
                        validator: (_cidade) {
                          final cidade = _cidade ?? '';

                          if (cidade.trim().isEmpty) {
                            return 'Cidade é obrigatório';
                          }

                          if (cidade.trim().length < 10) {
                            return 'Nome precisa no mínimo de 10 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue:
                            _formData['unidadefederativa']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Unidade Federativa: ',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_unidadefederativaFocus);
                        },
                        onSaved: (unidadefederativa) =>
                            _formData['unidadefederativa'] =
                                unidadefederativa ?? '',
                        validator: (_unidadefederativa) {
                          final unidadefederativa = _unidadefederativa ?? '';

                          if (unidadefederativa.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }

                          if (unidadefederativa.trim().length < 3) {
                            return 'Nome precisa no mínimo de 3 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['cpf']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'CPF: ',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_cpfFocus);
                        },
                        onSaved: (cpf) => _formData['cpf'] = cpf ?? '',
                        validator: (_cpf) {
                          final cpf = _cpf ?? '';

                          if (cpf.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }

                          if (cpf.trim().length < 10) {
                            return 'Nome precisa no mínimo de 10 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['identidade']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Identidade:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_identidadeFocus);
                        },
                        onSaved: (identidade) =>
                            _formData['identidade'] = identidade ?? '',
                        validator: (_identidade) {
                          final identidade = _identidade ?? '';

                          if (identidade.trim().isEmpty) {
                            return 'Identidade é obrigatório';
                          }

                          if (identidade.trim().length < 10) {
                            return 'Identidade precisa no mínimo de 10 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['emissor']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Emissor:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emissorFocus);
                        },
                        onSaved: (emissor) =>
                            _formData['emissor'] = emissor ?? '',
                        validator: (_emissor) {
                          final emissor = _emissor ?? '';

                          if (emissor.trim().isEmpty) {
                            return 'Emissor é obrigatório';
                          }

                          if (emissor.trim().length < 3) {
                            return 'Emissor precisa no mínimo de 3 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['dateEmissao']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Data da Emissão:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_dateEmissaoFocus);
                        },
                        onSaved: (dateEmissao) =>
                            _formData['dateEmissao'] = dateEmissao ?? '',
                        validator: (_dateEmissao) {
                          final dateEmissao = _dateEmissao ?? '';

                          if (dateEmissao.trim().isEmpty) {
                            return 'Data de Emissão é obrigatório';
                          }

                          if (dateEmissao.trim().length < 10) {
                            return 'Data de Emissão deve conter XX/XX/XXXX';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['ddd']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'DDD:',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_dddFocus);
                        },
                        onSaved: (ddd) => _formData['ddd'] = ddd ?? '',
                        validator: (_ddd) {
                          final ddd = _ddd ?? '';

                          if (ddd.trim().isEmpty) {
                            return 'DDD é obrigatório';
                          }

                          if (ddd.trim().length < 3) {
                            return 'DDD precisa no mínimo de 3 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['numbertelephone']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Numero de telefone: ',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_numbertelephoneFocus);
                        },
                        onSaved: (numbertelephone) =>
                            _formData['numbertelephone'] =
                                numbertelephone ?? '',
                        validator: (_numbertelephone) {
                          final numbertelephone = _numbertelephone ?? '';

                          if (numbertelephone.trim().isEmpty) {
                            return 'DDD é obrigatório';
                          }

                          if (numbertelephone.trim().length < 3) {
                            return 'DDD precisa no mínimo de 3 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['email']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'E-mail: ',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocus);
                        },
                        onSaved: (email) => _formData['email'] = email ?? '',
                        validator: (_email) {
                          final email = _email ?? '';

                          if (email.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }

                          if (email.trim().length < 5) {
                            return 'Nome precisa no mínimo de 5 letras.';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: _formData['termos']?.toString(),
                        decoration: InputDecoration(
                          
                          labelText: 'Termos de Serviços: ',
                        ),
                        onSaved: (termos) => _formData['termos'] = termosString,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
