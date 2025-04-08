import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipes_app/models/receipe.dart';
import 'package:receipes_app/providers/receipe_provider.dart';
import 'package:uuid/uuid.dart';

class AddReceipeScreen extends StatefulWidget {
  const AddReceipeScreen({super.key});

  @override
  State<AddReceipeScreen> createState() => _AddReceipeScreenState();
}

class _AddReceipeScreenState extends State<AddReceipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _imageUrlController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newReceipe = Receipe(
          id: Uuid().v4(),
          title: _titleController.text,
          description: _descriptionController.text,
          ingredients: _ingredientsController.text.split(','),
          imageUrl: _imageUrlController.text,
          isFavorite: false
      );
      Provider.of<ReceipeProvider>(context, listen: false).addReceipe(newReceipe);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir receta'),
      ),
      body:      Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título de la receta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserta el título.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción de la receta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserta una descripción.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(labelText: 'Proporciona los ingredientes separados por ,'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserta los ingredientes.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL de la imagend e la receta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserta una URL válida.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: _submitForm,
                  child: const Text('Añadir receta')
              )
            ],
          ),
        ),
      ),
    );
  }
}
