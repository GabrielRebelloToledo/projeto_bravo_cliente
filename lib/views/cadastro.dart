
import 'package:bravo_cliente/models/pessoa.dart';
import 'package:bravo_cliente/provider/pessoas.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _pessoasFocus = FocusNode();
  final _ObsFocus = FocusNode();
  final _contato = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  /* @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  } */

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Pessoa;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['dataReserva'] = product.datas;
        _formData['pessoas'] = product.pessoas;
        _formData['observation'] = product.observation;
        _formData['contato'] = product.contato;
        _formData['pagamento'] = product.pagamento;
        _formData['concluido'] = product.concluido;
       
        /* _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl; */
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _contato.dispose();
    _ObsFocus.dispose();
    _pessoasFocus.dispose();

    /* _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose(); */
  }

  /* void updateImage() {
    setState(() {});
  } */

  /* bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  } */

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductList>(
        context,
        listen: false,
      ).saveProduct(_formData);

      Navigator.of(context).pushReplacementNamed(Routes.splashScreen);
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar ao realizar a reserva.'),
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
        title: Text('Formulário da Reserva do Usuário'),
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
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: InputDecoration(
                          labelText: 'Nome: ',
                          hintText: 'Informe aqui seu nome completo'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
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
                      initialValue: _formData['dataReserva']?.toString(),
                      decoration: InputDecoration(
                          labelText: 'Data da reserva: ',
                          hintText: 'Informe uma data para sua reserva'),
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      onSaved: (dataReserva) =>
                          _formData['dataReserva'] = dataReserva ?? '',
                      validator: (_datas) {
                        final datas = _datas ?? '';

                        if (datas.trim().isEmpty) {
                          return 'Data é obrigatória.';
                        }

                        if (datas.trim().length == 9) {
                          return 'Data precisa no mínimo de 8 números e conter "/".';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['pessoas']?.toString(),
                      decoration: InputDecoration(
                        labelText: 'Quantidade de pessoas:',
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_pessoasFocus);
                      },
                      onSaved: (pessoas) =>
                          _formData['pessoas'] = double.parse(pessoas ?? '0'),
                      validator: (_pessoas) {
                        final priceString = _pessoas ?? '';
                        final pessoas = double.tryParse(priceString) ?? -1;

                        if (pessoas <= 0) {
                          return 'Informe um preço válido.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['observation']?.toString(),
                      decoration: InputDecoration(
                          labelText: 'Observação:',
                          hintText: 'A observação é opcional!'),
                      textInputAction: TextInputAction.next,
                      focusNode: _ObsFocus,
                      
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ObsFocus);
                      },
                      onSaved: (observation) =>
                          _formData['observation'] = observation ?? '',
                    ),
                    TextFormField(
                      initialValue: _formData['contato']?.toString(),
                      decoration: InputDecoration(
                          labelText: 'Telefone para contato:',
                          hintText: 'Informe aqui um telefone para contato'),
                      textInputAction: TextInputAction.next,
                      focusNode: _contato,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_contato);
                      },
                      onSaved: (contato) =>
                          _formData['contato'] = contato ?? '',
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: _formData['pagamento']?.toString(),
                      decoration: InputDecoration(
                          labelText: 'Situação de Pagamento:',
                          hintText: 'Pagamento em Análise!'),
                      onSaved: (pagamento) =>
                          _formData['pagamento'] = pagamento ?? '',
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: _formData['concluido']?.toString(),
                      decoration: InputDecoration(
                          labelText: 'Situação da reserva:',
                          hintText: 'Aguardando!'),
                      onSaved: (concluido) =>
                          _formData['concluido'] = concluido ?? '',
                    ),
                    
                    
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow),
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'Caro cliente, pedimos um pagamento antecipado de R\$20,00 para que a reserva seja feita, o valor será sera abatido no valor final da conta. Para mais informações clique na aba sobre!',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.yellow),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Faça sua reserva pelo PIX: 21.221.123/0009-34',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              final data =
                                  ClipboardData(text: '21.221.123/0009-34');
                              Clipboard.setData(data);
                              ClipboardStatus.pasteable.toString();
                            },
                            child: Text(
                              'Clique aqui para copiar',
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.home);
                        },
                        child: Icon(Icons.arrow_back))
                  ],
                ),
              ),
            ),
    );
  }
}
