import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key}) : super(key: key);

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
    );
  }

  Widget _createCost() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      cursorColor: Colors.deepPurple,
      decoration: InputDecoration(
        labelText: 'Cost',
      ),
    );
  }

  Widget _createButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      onPressed: () {},
      child: Text('Save'),
      textColor: Colors.white,
      color: Colors.deepPurple,
    );
  }
}
