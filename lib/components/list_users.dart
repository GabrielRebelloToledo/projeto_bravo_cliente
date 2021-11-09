
import 'package:bravo_cliente/models/user_register.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';


class ListUsers extends StatefulWidget {
  final UserRegister users;

  const ListUsers({Key? key, required this.users}) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  bool analise = false;
  bool termos = false;

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);

    if (widget.users.termos == 'Aceito') {
      setState(() {
        termos = true;
      });
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Column(
            children: [
              analise
                  ? Text('Olá ' +
                      widget.users.name +
                      ',seu perfil ainda se encontra em análise, aguarde!')
                  : Text('Olá ' +
                      widget.users.name +
                      ',seu perfil está autorizado'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.name,
                        decoration: InputDecoration(
                          labelText: 'Nome completo',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.sex,
                        decoration: InputDecoration(
                          labelText: 'Sexo:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.birthDay,
                        decoration: InputDecoration(
                          labelText: 'Data de Aniversário:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.naturalidade,
                        decoration: InputDecoration(
                          labelText: 'Naturalidade:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.escolaridade,
                        decoration: InputDecoration(
                          labelText: 'Escolaridade',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.nameMother,
                        decoration: InputDecoration(
                          labelText: 'Nome completo da Mãe:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.nameFather,
                        decoration: InputDecoration(
                          labelText: 'Nome completo do Pai:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.cep,
                        decoration: InputDecoration(
                          labelText: 'CEP:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.endereco,
                        decoration: InputDecoration(
                          labelText: 'Endereço:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.complemento,
                        decoration: InputDecoration(
                          labelText: 'Complemento:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.bairro,
                        decoration: InputDecoration(
                          labelText: 'Bairro:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.cidade,
                        decoration: InputDecoration(
                          labelText: 'Cidade:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.unidadefederativa,
                        decoration: InputDecoration(
                          labelText: 'Unidade Federativa:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.cpf,
                        decoration: InputDecoration(
                          labelText: 'CPF:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.identidade,
                        decoration: InputDecoration(
                          labelText: 'Identidade:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.emissor,
                        decoration: InputDecoration(
                          labelText: 'Emissor:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.dateEmissao,
                        decoration: InputDecoration(
                          labelText: 'Data da Emissão:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.ddd,
                        decoration: InputDecoration(
                          labelText: 'DDD:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.numbertelephone,
                        decoration: InputDecoration(
                          labelText: 'Numero de telefone:',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: widget.users.email,
                        decoration: InputDecoration(
                          labelText: 'E-mail: ',
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Checkbox(
                              checkColor: Colors.white,
                              value: termos,
                              onChanged: (bool? value) {},
                            ),
                          ),
                          Expanded(
                              child: Text('Você aceitou os termos e serviços')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Routes.cadastro,
                        arguments: widget.users,
                      );
                    },
                  ),
                  Text('Editar perfil')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
