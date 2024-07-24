// ignore_for_file: avoid_print

import 'package:bbcnews/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => NewsProvider(),
    )
  ], child: const NewsReading()));
}

class NewsReading extends StatefulWidget {
  const NewsReading({super.key});

  @override
  State<NewsReading> createState() => _NewsReadingState();
}

class _NewsReadingState extends State<NewsReading> {
  final formKey = GlobalKey<FormState>();
  var searchData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<NewsProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          centerTitle: true,
          actions: const [
            Icon(
              Icons.notifications_active,
              color: Colors.white,
            )
          ],
          title: const Text(
            "NEWS APP",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.06,
                child: SearchBar(
                  controller: searchData,
                  leading: const Icon(Icons.search),
                  hintText: "Search a news",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    String searchContent = searchData.text.trim();

                    provider.getNews(searchContent);
                  },
                  child: const Text("click to search")),
              const Divider(thickness: 0.5, color: Colors.grey),
              SingleChildScrollView(
                child: Consumer<NewsProvider>(builder: (context, data, _) {
                  return Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: screenHeight * 0.9,
                        child: ListView(
                            children: data.searchNews.isNotEmpty
                                ? List.generate(data.searchNews.length,
                                    (index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image(
                                            image: NetworkImage(data
                                                .searchNews[index].UrlToImage)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Text(
                                            data.searchNews[index].Title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Center(
                                            child: Text(
                                          data.searchNews[index].Author,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          data.searchNews[index].Description,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data.searchNews[index].content,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Text(data
                                              .searchNews[index].publishedAt),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  })
                                : [
                                    const Text(
                                      "No data",
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                      )
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
