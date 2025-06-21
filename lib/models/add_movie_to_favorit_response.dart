class AddMovieToFavoritResponse {
  AddMovieToFavoritResponse({
      this.message, 
      this.data,});

  AddMovieToFavoritResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.movieId, 
      this.name, 
      this.rating, 
      this.imageURL,});

  Data.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
  }
  String? movieId;
  String? name;
  double? rating;
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