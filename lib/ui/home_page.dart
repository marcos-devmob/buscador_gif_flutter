import 'dart:convert';
import 'package:buscador_gifs/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String? _search;
  int _offset = 0;

  Future<Map<String, dynamic>?> _getGifs() async {
    const apiKey = "iHwzNGKH1HxejrEVd1hBpbzNRu9bC4um";
    const baseUrl = "https://api.giphy.com/v1/gifs";

    Uri url;

    if (_search == null || _search!.isEmpty) {
      url = Uri.parse(
        "$baseUrl/trending?api_key=$apiKey&limit=20&offset=&rating=g&bundle=messaging_non_clips",
      );
    } else {
      url = Uri.parse(
        "$baseUrl/search?api_key=$apiKey&q=$_search&limit=19&offset=$_offset&rating=g&lang=en&bundle=messaging_non_clips",
      );
    }

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        debugPrint("❌ Erro: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("⚠️ Exceção ao buscar GIFs: $e");
      return null;
    }
  }

  late Future<Map<String, dynamic>?> _futureGifs;

  @override
  void initState() {
    super.initState();
    _futureGifs = _getGifs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
          "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif",
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise Aqui",
                labelStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _futureGifs = _getGifs();
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _futureGifs,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    } else {
                      return _createGifTable(context, snapshot);
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        if (_search == null || index < snapshot.data["data"].length) {
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image:
                  snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GifPage(snapshot.data["data"][index]),
                ),
              );
            },
            onLongPress: () {
              Share.share(
                snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              );
            },
          );
        } else {
          return GestureDetector(
            onTap: () {
              setState(() {
                _offset += 19;
                _futureGifs = _getGifs();
              });
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 60.0),
                Text(
                  "Carregar mais...",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
