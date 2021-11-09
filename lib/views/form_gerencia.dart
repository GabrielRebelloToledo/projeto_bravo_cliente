import 'package:bravo_cliente/models/pessoa.dart';
import 'package:bravo_cliente/provider/pessoas.dart';
import 'package:bravo_cliente/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormGerencia extends StatefulWidget {
  const FormGerencia({ Key? key }) : super(key: key);

  @override
  _FormGerenciaState createState() => _FormGerenciaState();
}

class _FormGerenciaState extends State<FormGerencia> {
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

  
  }

  
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
        title: Text('Formulário da Reserva'),
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
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
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
                      
                      initialValue: _formData['pagamento']?.toString(),
                      decoration: InputDecoration(
                          labelText: 'pagamento:',
                          hintText: 'pagamento'),
                      textInputAction: TextInputAction.next,
                      
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ObsFocus);
                      },
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
