import 'dart:convert';

class Training {
  final int id;
  final String title;

  Training({required this.id, required this.title});

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'],
      title: json['title'],
    );
  }
}

class ListTrainingModel {
  final String? message;
  final List<Training>? data;

  ListTrainingModel({this.message, this.data});

  factory ListTrainingModel.fromJson(String source) {
    final Map<String, dynamic> jsonMap = json.decode(source);
    return ListTrainingModel(
      message: jsonMap['message'],
      data: (jsonMap['data'] as List<dynamic>?)
          ?.map((e) => Training.fromJson(e))
          .toList(),
    );
  }
}