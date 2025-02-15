
class NewsViewModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsViewModel({this.status, this.totalResults, this.articles});

  NewsViewModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    totalResults = json["totalResults"];
    articles = json["articles"] == null ? null : (json["articles"] as List).map((e) => Articles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["totalResults"] = totalResults;
    if(articles != null) {
      data["articles"] = articles?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles({this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source = json["source"] == Source() ? null : Source.fromJson(json["source"]);
    author = json["author"]??'';
    title = json["title"]??'';
    description = json["description"]??'';
    url = json["url"]??'';
    urlToImage = json["urlToImage"]??'';
    publishedAt = json["publishedAt"]??'';
    content = json["content"]??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(source != null) {
      data["source"] = source?.toJson();
    }
    data["author"] = author;
    data["title"] = title;
    data["description"] = description;
    data["url"] = url;
    data["urlToImage"] = urlToImage;
    data["publishedAt"] = publishedAt;
    data["content"] = content;
    return data;
  }
}

class Source {
  dynamic id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json["id"]??0;
    name = json["name"]??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}