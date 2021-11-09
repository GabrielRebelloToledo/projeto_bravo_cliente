import 'dart:convert';
import 'dart:math';
import 'package:bravo_cliente/exceptions/http_exception.dart';
import 'package:bravo_cliente/models/user_register.dart';
import 'package:bravo_cliente/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserRegisterProvider with ChangeNotifier {
  final String _token;
  final String _userId;
  List<UserRegister> _items = [];

  List<UserRegister> get items => [..._items];

  UserRegisterProvider([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.USERS_BASE_URL}/$_userId.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constants.USERS_BASE_URL}/.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((userId, userData) {
      final isFavorite = favData[userId] ?? false;
      _items.add(
        UserRegister(
          id: userId,
          name: userData['name'],
          sex: userData['sex'],
          birthDay: userData['birthDay'],
          naturalidade: userData['naturalidade'],
          escolaridade: userData['escolaridade'],
          nameMother: userData['nameMother'],
          nameFather: userData['nameFather'],
          cep: userData['cep'],
          endereco: userData['endereco'],
          complemento: userData['complemento'],
          bairro: userData['bairro'],
          cidade: userData['cidade'],
          unidadefederativa: userData['unidadefederativa'],
          cpf: userData['cpf'],
          identidade: userData['identidade'],
          emissor: userData['emissor'],
          dateEmissao: userData['dateEmissao'],
          ddd: userData['ddd'],
          numbertelephone: userData['numbertelephone'],
          email: userData['email'],
          termos: userData['termos'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> loadNewUser() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.ORDER_BASE_URL}.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constants.USERS_BASE_URL}/.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((userId, userData) {
      final isFavorite = favData[userId] ?? false;
      _items.add(
        UserRegister(
          id: userId,
          name: userData['name'],
          sex: userData['sex'],
          birthDay: userData['birthDay'],
          naturalidade: userData['naturalidade'],
          escolaridade: userData['escolaridade'],
          nameMother: userData['nameMother'],
          nameFather: userData['nameFather'],
          cep: userData['cep'],
          endereco: userData['endereco'],
          complemento: userData['complemento'],
          bairro: userData['bairro'],
          cidade: userData['cidade'],
          unidadefederativa: userData['unidadefederativa'],
          cpf: userData['cpf'],
          identidade: userData['identidade'],
          emissor: userData['emissor'],
          dateEmissao: userData['dateEmissao'],
          ddd: userData['ddd'],
          numbertelephone: userData['numbertelephone'],
          email: userData['email'],
          termos: userData['termos'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final user = UserRegister(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      sex: data['sex'] as String,
      birthDay: data['birthDay'] as String,
      naturalidade: data['naturalidade'] as String,
      escolaridade: data['escolaridade'] as String,
      nameMother: data['nameMother'] as String,
      nameFather: data['nameFather'] as String,
      cep: data['cep'] as String,
      endereco: data['endereco'] as String,
      complemento: data['complemento'] as String,
      bairro: data['bairro'] as String,
      cidade: data['cidade'] as String,
      unidadefederativa: data['unidadefederativa'] as String,
      cpf: data['cpf'] as String,
      identidade: data['identidade'] as String,
      emissor: data['emissor'] as String,
      dateEmissao: data['dateEmissao'] as String,
      ddd: data['ddd'] as String,
      numbertelephone: data['numbertelephone'] as String,
      email: data['email'] as String,
      termos: data['termos'] as String,
    );

    if (hasId) {
      return updateProduct(user);
    } else {
      return addProduct(user);
    }
  }

  Future<void> addProduct(UserRegister users) async {
    final response = await http.post(
      Uri.parse("${Constants.USERS_BASE_URL}/$_userId.json?auth=$_token"),
      body: jsonEncode(
        {
          "name": users.name,
          "sex": users.sex,
          "birthDay": users.birthDay,
          "naturalidade": users.naturalidade,
          "escolaridade": users.escolaridade,
          "nameMother": users.nameMother,
          "nameFather": users.nameFather,
          "cep": users.cep,
          "endereco": users.endereco,
          "complemento": users.complemento,
          "bairro": users.bairro,
          "cidade": users.cidade,
          "unidadefederativa": users.unidadefederativa,
          "cpf": users.cpf,
          "identidade": users.identidade,
          "emissor": users.emissor,
          "dateEmissao": users.dateEmissao,
          "ddd": users.ddd,
          "numbertelephone": users.numbertelephone,
          "email": users.email,
          "termos": users.termos
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(UserRegister(
        id: id,
        name: users.name,
        sex: users.sex,
        birthDay: users.birthDay,
        naturalidade: users.naturalidade,
        escolaridade: users.escolaridade,
        nameMother: users.nameMother,
        nameFather: users.nameFather,
        cep: users.cep,
        endereco: users.endereco,
        complemento: users.complemento,
        bairro: users.bairro,
        cidade: users.cidade,
        unidadefederativa: users.unidadefederativa,
        cpf: users.cpf,
        identidade: users.identidade,
        emissor: users.emissor,
        dateEmissao: users.dateEmissao,
        ddd: users.ddd,
        numbertelephone: users.numbertelephone,
        email: users.email,
        termos: users.termos));
    notifyListeners();
  }

  Future<void> updateProduct(UserRegister users) async {
    int index = _items.indexWhere((u) => u.id == users.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.USERS_BASE_URL}/${users.id}.json?auth=$_token',
        ),
        body: jsonEncode(
          {
            "name": users.name,
            "sex": users.sex,
            "birthDay": users.birthDay,
            "naturalidade": users.naturalidade,
            "escolaridade": users.escolaridade,
            "nameMother": users.nameMother,
            "nameFather": users.nameFather,
            "cep": users.cep,
            "endereco": users.endereco,
            "complemento": users.complemento,
            "bairro": users.bairro,
            "cidade": users.cidade,
            "unidadefederativa": users.unidadefederativa,
            "cpf": users.cpf,
            "identidade": users.identidade,
            "emissor": users.emissor,
            "dateEmissao": users.dateEmissao,
            "ddd": users.ddd,
            "numbertelephone": users.numbertelephone,
            "email": users.email
          },
        ),
      );

      _items[index] = users;
      notifyListeners();
    }
  }

  Future<void> removeProduct(UserRegister users) async {
    int index = _items.indexWhere((p) => p.id == users.id);

    if (index >= 0) {
      final users = _items[index];
      _items.remove(users);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
          '${Constants.USERS_BASE_URL}/${users.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, users);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
