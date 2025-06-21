class FavoriteMoviesResponse {
  FavoriteMoviesResponse({
      this.message, 
      this.data,});

  FavoriteMoviesResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataF.fromJson(v));
      });
    }
  }
  String? message;
  List<DataF>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DataF {
  DataF({
      this.movieId, 
      this.name, 
      this.rating, 
      this.imageURL,});

  DataF.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
  }
  String? movieId;
  String? name;
  num? rating;
  String? imageURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    return map;
  }

}