import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopinglist/data/categories.dart';
import 'package:shopinglist/data/dummy_items.dart';
import 'package:shopinglist/models/category.dart';
import 'package:shopinglist/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
 var  _enterName = '';
 var _enterQuentity = 1;
 var _selectedCategory = categories[Categories.vegetables]!;
  final _formKey = GlobalKey<FormState>();

  void _saveItem(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
     Navigator.of(context).pop(GroceryItem(id: DateTime.now().toString(), name: _enterName, quantity: _enterQuentity, category: _selectedCategory));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new item'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length >= 50) {
                        return 'Must be between 1 or 50 character';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _enterName = value!;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text('Quantity')),
                          keyboardType: TextInputType.number,
                          initialValue: _enterQuentity.toString(),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value)! <= 0) {
                              return 'Must be valid positive number';
                            }
                            ;
                            return null;
                          },
                          onSaved: (value){
                            _enterQuentity = int.parse(value!);
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField(
                            value: _selectedCategory,
                            items: [
                          for (final categorynew in categories.entries)
                            DropdownMenuItem(
                                value: categorynew.value,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 16,
                                      width: 16,
                                      color: categorynew.value.color,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(categorynew.value.title)
                                  ],
                                ))
                        ], onChanged: (value) {
                              setState(() {
                                _selectedCategory = value!;

                              });
                        }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed:(){
                        _formKey.currentState!.reset();
                      }, child: Text('Reset')),
                      ElevatedButton(
                          onPressed: _saveItem, child: Text('Add items'))
                    ],
                  )
                ],
              ))),
    );
  }
}
