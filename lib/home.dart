import 'package:favorite_word/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';  // Importing the english_words package
import 'screen/favorite.dart';
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>FavoriteProvider(),
      child: MaterialApp(
        title: 'Random Word Generation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RandomWordApp(),  // Using the correct constructor
      ),
    );
  }
}

class RandomWordApp extends StatelessWidget {  // Ensure this class is properly defined
  const RandomWordApp({super.key});  // Ensure the constructor matches how you call it

  @override
  Widget build(BuildContext context) {
    final words = nouns.take(50).toList();
    final provider = Provider.of<FavoriteProvider>(context);
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Random Word Generation",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.blue[600],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          final word = words[index];
          return ListTile(
            title: Text(word),
            trailing: IconButton(
              onPressed: () {
                provider.toggleFavorite(word);
              },
              icon: provider.isFavorite(word)
              ? const Icon(
                Icons.favorite,
                color: Colors.red
              )
              : const Icon(Icons.favorite_outline),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          final route = MaterialPageRoute(builder: (context) => const FavoritePage());
          Navigator.push(context, route);
        },
        label: const Text(
          "Favorite Words",
          style:  TextStyle(
            color: Colors.white,
          ),
          ),
          backgroundColor: Colors.blue[600],
      ),
    );
  }
}
