import 'package:flutter/material.dart';
import 'package:login/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: ProductPage.formKey,
            child: Column(
              children: <Widget>[
                _createName(),
                _createCost(),
                _createButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Colors.deepPurple,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      validator: (String value) {
        if (value.length < 3) {
          return 'Input name of the product';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createCost() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      cursorColor: Colors.deepPurple,
      decoration: InputDecoration(
        labelText: 'Cost',
      ),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Only numbers';
        }
      },
    );
  }

  Widget _createButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      onPressed: _submit,
      child: Text('Save'),
      textColor: Colors.white,
      color: Colors.deepPurple,
    );
  }

  void _submit() {
    if (!ProductPage.formKey.currentState.validate()) return;
    print('Form Valido');
  }
}
