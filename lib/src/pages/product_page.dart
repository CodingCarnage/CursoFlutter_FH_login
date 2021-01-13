import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:login/src/models/product_model.dart';

import 'package:login/src/providers/product_provider.dart';

import 'package:login/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductProvider productProvider = new ProductProvider();

  ProductModel product = new ProductModel();
  bool _isSaving = false;
  File image;

  @override
  Widget build(BuildContext context) {
    final ProductModel productData = ModalRoute.of(context).settings.arguments;
    if (productData != null) {
      product = productData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Product Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectImage,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takeImage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _showImage(),
                _createName(),
                _createCost(),
                _createAvailable(),
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
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Colors.deepPurpleAccent,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      onSaved: (String value) => product.title = value,
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
      initialValue: product.value != null ? product.value.toString() : '',
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      cursorColor: Colors.deepPurpleAccent,
      decoration: InputDecoration(
        labelText: 'Cost',
        hintText: "0.0",
      ),
      onSaved: (String value) => product.value = double.parse(value),
      validator: (String value) {
        if (value.length <= 0) {
          return 'Enter cost';
        } else if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Only numbers';
        }
      },
    );
  }

  Widget _createAvailable() {
    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      onChanged: (bool value) => setState(() => product.available = value),
    );
  }

  Widget _createButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: _isSaving ? null : _submit,
      child: Text('Save'),
      textColor: Colors.white,
      color: Colors.deepPurpleAccent,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _isSaving = true;
    });

    if (image != null) {
      product.imageUrl = await productProvider.uploadImage(image);
    }

    if (product.id == null) {
      productProvider.createProduct(product);
    } else {
      productProvider.editProduct(product);
    }
    
    showSnackBar('Registro exitoso');

    Navigator.pop(context);
  }

  void showSnackBar(String message) {
    final SnackBar snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _showImage() {
    if (product.imageUrl != null) {
      // TODO: I need to maker this,
      return Container();
    } else {
      return Image(
        image: image != null ? FileImage(image) : AssetImage('assets/images/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }
  
  _selectImage() async {
    _processImage(ImageSource.gallery);
  }

  _takeImage() async {
    _processImage(ImageSource.camera);
  }

  _processImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final PickedFile pickedFile = await imagePicker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
