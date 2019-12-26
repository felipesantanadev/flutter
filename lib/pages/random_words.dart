import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordsState extends State<RandomWords> {
  //  Note: Prefixing an identifier with an underscore enforces privacy in the Dart language.
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup name generator"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
        ),
        body: _buildSuggestions()
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if(i.isOdd){
          return Divider();
        }

        /* 
        The expression i ~/ 2 divides i by 2 and returns an integer result. 
        For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2. 
        This calculates the actual number of word pairings in the ListView, 
        minus the divider widgets.
        */
        final index = i ~/ 2;

        if(index >= _suggestions.length){
          // If you’ve reached the end of the available word pairings, 
          // then generate 10 more and add them to the suggestions list.
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair word){
    final bool alreadySaved = _saved.contains(word);
    
    return ListTile(
      title: Text(
        word.asPascalCase,
        style: _biggerFont
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () => _toggleFavorites(word),
    );
  }

  void _toggleFavorites(WordPair word){
    // In Flutter's reactive style framework, calling setState() 
    // triggers a call to the build() method for the State object, 
    // resulting in an update to the UI.
    setState(() {
      if(_saved.contains(word)){
        _saved.remove(word);
      }
      else {
        _saved.add(word);
      }
    });
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _saved.map((WordPair word) {
            return ListTile(
              title: Text(word.asPascalCase, style: _biggerFont),
            );
          });

          final List<Widget> dived = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved names'),
            ),
            body: ListView(
              children: dived,
            )
          );
        }
      )
    );
  }
}

class RandomWords extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => RandomWordsState();

}