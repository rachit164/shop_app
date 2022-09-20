import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageurlcontroller = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null.toString(),
    description: '',
    title: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      _updateImageUrl();
    });
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageurlcontroller.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(() {
      _updateImageUrl();
    });
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.save),
          )
        ],
        title: const Text('Edit Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null.toString(),
                    description: _editedProduct.description,
                    title: value!,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                  );
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide value.";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null.toString(),
                    description: _editedProduct.description,
                    title: _editedProduct.title,
                    imageUrl: _editedProduct.imageUrl,
                    price: double.parse(value!),
                  );
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(
                    (_descriptionFocusNode),
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than 0';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: null.toString(),
                      description: value!,
                      title: _editedProduct.title,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageurlcontroller.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageurlcontroller.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageurlcontroller,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a image url';
                        }
                        if (!value.startsWith('http') &&
                            value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: null.toString(),
                            description: _editedProduct.description,
                            title: _editedProduct.title,
                            imageUrl: value!,
                            price: _editedProduct.price);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
