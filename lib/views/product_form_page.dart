import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
              textInputAction: TextInputAction.next,
            ),
          ]),
        ),
      ),
    );
  }
}
