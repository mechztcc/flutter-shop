import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    final _priceFocus = FocusNode();
    final _descriptionFocus = FocusNode();
    final _urlFocus = FocusNode();

    final _imageUrlController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    final _formData = Map<String, Object>();

    void updateImage() {
      setState(() {});
    }

    void _submitForm() {
      _formKey.currentState?.save();

      final isValid = _formKey.currentState?.validate() ?? false;

      if (!isValid) {
        return;
      }

      final newProduct = Product(
        id: Random().nextDouble().toString(),
        name: _formData['name'].toString(),
        description: _formData['description'].toString(),
        price: double.parse(_formData['price'].toString()),
        imageUrl: _formData['url'].toString(),
      );
    }

    bool isValidImageUrl(String url) {
      bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
      bool endsWithFile = url.toLowerCase().endsWith('.png') ||
          url.toLowerCase().endsWith('jpg');

      return isValidUrl && endsWithFile;
    }

    @override
    void initState() {
      super.initState();
      _urlFocus.addListener(updateImage);
    }

    @override
    void dispose() {
      super.dispose();
      _priceFocus.dispose();
      _descriptionFocus.dispose();
      _urlFocus.removeListener(updateImage);
      _urlFocus.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_nome) {
                  final nome = _nome ?? '';

                  if (nome.trim().isEmpty) {
                    return 'Nome é Obrigatório';
                  }

                  if (nome.trim().length < 3) {
                    return 'Nome precisa ter no mínimo 3 letras';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
                focusNode: _priceFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (preco) =>
                    _formData['preco'] = double.parse(preco ?? '0'),
                validator: (_price) {
                  final priceString = _price ?? '';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) {
                    return 'Informe um preço válido';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descrição',
                ),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                maxLines: 3,
                validator: (_descritpion) {
                  final description = _descritpion ?? '';

                  if (description.trim().isEmpty) {
                    return 'Descrição é Obrigatório';
                  }

                  if (description.trim().length < 10) {
                    return 'Descrição precisa ter no mínimo 10 letras';
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Url da Imagem',
                      ),
                      focusNode: _urlFocus,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (url) => _formData['url'] = url ?? '',
                      validator: (_url) {
                        final imageUrl = _url ?? '';
                        if (!isValidImageUrl(imageUrl)) {
                          return 'Informe uma URL válida.';
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informa a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
