import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipes_app/models/receipe.dart';
import 'package:receipes_app/providers/receipe_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReceipeItem extends StatelessWidget {
  final Receipe receipe;

  const ReceipeItem({super.key, required this.receipe});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReceipeProvider>(context);

    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(receipe.imageUrl),
        ),
        title: Text(receipe.title),
        subtitle: Text(receipe.description),
        trailing: Wrap(
         children: [
           IconButton(onPressed: () {
             provider.toggleFavourite(receipe.id);
           },
               icon: Icon(receipe.isFavorite ? Icons.star : Icons.star_border_rounded,
                 color: receipe.isFavorite ? Colors.yellow : null,
               )
           ),
           IconButton(onPressed: () {
             Share.share(
               '¡Mira esta receta! ${receipe.title}\n${receipe.description}'
             );
           },
               icon: Icon(Icons.share)),
           IconButton(onPressed: () {
             provider.deleteReceipe(receipe.id);
           },
               icon: Icon(Icons.delete)),
         ],
        ),
      ),
    );
  }
}
