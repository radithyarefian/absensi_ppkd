import 'dart:developer';
import 'package:absensi_ppkd/models/list_training_model.dart';
import 'package:http/http.dart' as http;

Future<List<Training>> getTrainingList() async {
  final response = await http.get(
    Uri.parse("https://appabsensi.mobileprojp.com/"), // endpoint API
    headers: {
      "x-api-key":
          "pro_5723ae342dcc2a529e67d531edc4eb99ef6c8cfdc86a49ecead23ea7e734cec3",
    },
  );

  log(response.body); // debug response

  if (response.statusCode == 200) {
    final model = ListTrainingModel.fromJson(response.body);
    return model.data ?? [];
  } else {
    throw Exception("Gagal memuat data");
  }
}