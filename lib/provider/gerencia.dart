import 'dart:convert';
import 'dart:math';
import 'package:bravo_cliente/exceptions/http_exception.dart';
import 'package:bravo_cliente/models/pessoa.dart';
import 'package:bravo_cliente/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GerenciaList with ChangeNotifier {
  final String _token;
  final String _userId;

  final String concluidors = "OK!";
  List<Pessoa> _items = [];

  List<Pessoa> get items => [..._items];

  GerenciaList([
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
      Uri.parse('${Constants.SolicitacoesdeReservas}.json?auth=$_token'),
    );
    if (response.body == 'null') return;
    final favResponse = await http.get(
      Uri.parse(
        '${Constants.USER_FAVORITES_URL}.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Pessoa(
            id: productId,
          name: productData['name'],
          userid: _userId,
          datas: productData['dataReserva'],
          pessoas: productData['pessoas'],
          observation: productData['observation'],
          contato: productData['contato'],
          pagamento: productData['pagamento'],
          concluido: productData['concluido'],)
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Pessoa(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      userid: _userId,
      datas: data['dataReserva'] as String,
      pessoas: data['pessoas'] as double,
      observation: data['observation'] as String,
      contato: data['contato'] as String,
      pagamento: data['pagamento'] as String,
      concluido: data['concluido'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Pessoa product) async {
    final response = await http.post(
      Uri.parse('${Constants.SolicitacoesdeReservas}.json?auth=$_token'),
      body: jsonEncode(
        {
         "name": product.name,
          "userid": _userId,
          "dataReserva": product.datas,
          "pessoas": product.pessoas,
          "observation": product.observation,
          "contato": product.contato,
          "pagamento": product.pagamento,
          "concluido": 'OK!',
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Pessoa(
      id: id,
      name: product.name,
      userid: _userId,
      datas: product.datas,
      pessoas: product.pessoas,
      observation: product.observation,
      contato: product.contato,
      pagamento: 'product.contato',
      concluido: 'OK!',
    ));

    notifyListeners();
  }

  Future<void> updateProduct(Pessoa product) async {
    int index = _items.indexWhere((p) => p.id != product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.SolicitacoesdeReservas}/${product.id}.json?auth=$_token',
        ),
        body: jsonEncode(
          {
           "name": product.name,
            "userid": _userId,
            "dataReserva": product.datas,
            "pessoas": product.pessoas,
            "observation": product.observation,
            "contato": product.contato,
            "pagamento": product.pagamento,
            "concluido": 'OK!',
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Pessoa product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
          '${Constants.SolicitacoesdeReservas}/${product.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
