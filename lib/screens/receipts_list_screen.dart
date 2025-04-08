import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipes_app/providers/receipe_provider.dart';
import 'package:receipes_app/screens/add_receipe_screen.dart';

import '../widgets/receipe_item.dart';

class ReceiptsListScreen extends StatefulWidget {
  const ReceiptsListScreen({super.key});

  @override
  State<ReceiptsListScreen> createState() => _ReceiptsListScreenState();
}

class _ReceiptsListScreenState extends State<ReceiptsListScreen> {
  String _searchQuery = '';
  bool _showFavorite = false;
  
  @override
  Widget build(BuildContext context) {
    final receipProvider = Provider.of<ReceipeProvider>(context);
    final receipes = _showFavorite ? receipProvider.favoriteReceipe()
        : receipProvider.searchBy(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas'),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              _showFavorite = !_showFavorite;
            });
          },
              icon: Icon(_showFavorite ? Icons.star : Icons.star_border_rounded))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar recetas...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder()
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          Expanded(
            child: receipes.isEmpty
                ? const Center(
              child: Text('No hay recetas'),
            )
                : ListView.builder(
              itemCount: receipes.length,
              itemBuilder: (context, index) {
                return ReceipeItem(receipe: receipes[index]);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddReceipeScreen())
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
