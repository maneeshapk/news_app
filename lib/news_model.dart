class News {
  
  final String Sourcename;
  final String Title;
  final String Author;
  final String Description;
  final String url;
  final String UrlToImage;
  final String publishedAt;
  final String content;

  News({
    
    required this.Sourcename,
    required this.Title,
    required this.Author,
    required this.Description,
    required this.url,
    required this.UrlToImage,
    required this.content,
    required this.publishedAt,
  });
  factory News.fromMap(Map<String, dynamic> json) {
    return News(
      Sourcename: json['source']['name']??"",
      Author: json['author']??"",
      Title: json['title']??"",
      Description: json['description']??"",
      url: json['url']??"",
      UrlToImage: json['urlToImage']??"",
      publishedAt: json['publishedAt']??"",
      content: json['content']??"",
    );
  }}