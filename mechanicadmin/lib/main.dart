import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mechanicadmin/splashscreen.dart';

const String SETTINGS_BOX = 'settings';
const String API_BOX = 'api_data';
const String FAVOURITES_BOX = 'favourites';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(SETTINGS_BOX);
  await Hive.openBox(FAVOURITES_BOX);
  await Hive.openBox(API_BOX);

  runApp(SplashApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {'favourites':(_)=>FavouritesPage()},
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Hive.box(SETTINGS_BOX).get('welcome_shown'));
    return ValueListenableBuilder(
      builder: (_, box, child) => box.get('welcome_shown', defaultValue: true)
          ? MyHomePage()
          : WelcomePage(),
      valueListenable: Hive.box(SETTINGS_BOX).listenable(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Page'),
            ElevatedButton(
                onPressed: () async {
                  var box = Hive.box(SETTINGS_BOX);
                  box.put('welcome_shown', true);
                },
                child: Text('Get Started'))
          ],
        ),
      ),
    );
  }
}

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    super.initState();
    // getBooks();
  }

  getBooks() async {
    final books = await Hive.box(API_BOX).get('books', defaultValue: []);
    if (books.isNotEmpty) return books['items'];
    var url = 'https://www.googleapis.com/books/v1/volumes?q={http}';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Hive.box(API_BOX).put('books', jsonResponse);
      //var itemCount = jsonResponse['totalItems'];
      // print('Number of books about http: $itemCount.');
      // print(jsonResponse['totalItems']);
      // print(jsonResponse['items']['id']);
      return jsonResponse['items'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getBooks(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final b00ks = snapshot.data;
              print(b00ks.length);

              return ListView(
                children: [
                  Text('Categories'),
                  ...b00ks.map((p) => ListTile(
                        onTap: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(p['volumeInfo']),
                          ));
                        },
                        title: Text(p['volumeInfo']['title']),
                      ))
                ],
              );
            } else
              return Center(child: Text('No data found'));
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'favourites');
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: ApiService().getPosts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final posts = snapshot.data;

          return ValueListenableBuilder(
            valueListenable: Hive.box(FAVOURITES_BOX).listenable(),
            builder: (context,box, snapshot) {
              return ListView(padding: EdgeInsets.all(16), children: [
                Text('HomePage'),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BookPage()));
                    },
                    child: Text('Books')),
                ...posts.map((p) => ListTile(
                    onTap: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(p['body']),
                      ));
                    },
                    title: Text(p['title']),
                    trailing: IconButton(
                      icon:box.containsKey(p['id']) ?Icon(Icons.favorite):Icon(Icons.favorite_border),
                      onPressed: () {
                        if(box.containsKey(p['id'])
                        )
                        box.delete(p['id']);
                        else
                        box.put(p['id'], p);
                      },
                    )))
              ]);
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Hive.box(SETTINGS_BOX).put('welcome_shown', false);
          print(Hive.box(SETTINGS_BOX).get('welcome_shown'));
        },
        label: Row(
          children: [Text('Logout')],
        ),
      ),
    );
  }
}

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites Page'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(FAVOURITES_BOX).listenable(),
        builder: (context, box, snapshot) {
          // if (!snapshot.hasData) {
          //   return CircularProgressIndicator();
          // }
          List posts = List.from(box.values ?? []);

          ListView(padding: EdgeInsets.all(16), children: [
            Text('HomePage'),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BookPage()));
                },
                child: Text('Books')),
            ...posts.map((p) => ListTile(
                onTap: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(p['body']),
                  ));
                },
                title: Text(p['title']),
                trailing: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    box.delete(p['id']);
                  },
                )))
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Hive.box(SETTINGS_BOX).put('welcome_shown', false);
          print(Hive.box(SETTINGS_BOX).get('welcome_shown'));
        },
        label: Row(
          children: [Text('Logout')],
        ),
      ),
    );
  }
}

class ApiService {
  Future<void> getPosts() async {
    try {
      final posts = await Hive.box(API_BOX).get('posts', defaultValue: []);
      //print(posts);
      if (posts.isNotEmpty)
        return posts;
      else {
        var url = "https://jsonplaceholder.typicode.com/posts";
        final http.Response res = await http.get(url);
        final restjson = jsonDecode(res.body);
        Hive.box(API_BOX).put('posts', restjson);
        return restjson;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
