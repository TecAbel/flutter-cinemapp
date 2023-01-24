import 'package:json_annotation/json_annotation.dart';

import 'cast_model.dart';

part 'credits_response.g.dart';

@JsonSerializable()
class MovieCreditsResponse {
  MovieCreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory MovieCreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsResponseFromJson(json);
}
