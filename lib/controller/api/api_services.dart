import 'package:dio/dio.dart';
import 'package:parking_app/model/subscriber_model.dart';
import 'package:parking_app/model/veicule_model.dart';

final dio = Dio();

class ApiServices {
  static const __serverIP = "192.168.0.2";
  //static const __serverHostname = "";
  static const __port = 8000;
  final endpoint = "http://$__serverIP:$__port";

  getAllVeicules() async {
    final url = "$endpoint/veicule";
    Response response;
    response = await dio.get(url);
    if (response.statusCode == 200) {
      /*
      final List result = response.data;
      return result.map((e) => Veicule.fromJson(e)).toList();
      */
      final result = response.data as Map<String, dynamic>;
      List<Veicule> veiculeList = List.empty(growable: true);

      result.forEach(
        (key, value) {
          veiculeList.add(Veicule.fromJson(value));
        },
      );

      return veiculeList;
    } else {
      return;
    }
  }

  getVeiculeByDate() async {
    DateTime date = DateTime.now();
    var day = date.day.toString();
    var month = date.month.toString();
    if (date.day.toInt() < 10) {
      day = "0${date.day}";
    }

    if (date.month.toInt() < 10) {
      month = "0${date.month}";
    }

    final url = "$endpoint/veicule/date/$day-$month-${date.year}";
    Response response;
    response = await dio.get(url);
    if (response.statusCode == 200) {
      /*
      final List result = response.data;
      return result.map((e) => Veicule.fromJson(e)).toList();
      */
      final result = response.data as Map<String, dynamic>;
      List<Veicule> veiculeList = List.empty(growable: true);

      result.forEach(
        (key, value) {
          veiculeList.add(Veicule.fromJson(value));
        },
      );

      return veiculeList;
    } else {
      return;
    }
  }

  getAllSubscribers() async {
    final url = "$endpoint/subscriber";
    Response response;
    response = await dio.get(url);
    if (response.statusCode == 200) {
      /*
      final List result = response.data;
      return result.map((e) => Veicule.fromJson(e)).toList();
      */
      final result = response.data as Map<String, dynamic>;
      List<Subscriber> subscriberList = List.empty(growable: true);

      result.forEach(
        (key, value) {
          subscriberList.add(Subscriber.fromJson(value));
        },
      );

      return subscriberList;
    } else {
      return;
    }
  }

  postVeicule(Veicule veicule) async {
    final url = "$endpoint/veicule";
    Response response;
    response = await dio.post(
      url,
      data: veicule.toJson(),
    );
    if (response.statusCode == 200) {
      final result = response.data as Map<String, dynamic>;
      return Veicule.fromJson(result);
    } else {
      // raise error.
      return;
    }
  }

  patchVeicule(Veicule veicule) async {
    final url = "$endpoint/veicule";
    Response response;
    response = await dio.patch(
      url,
      data: veicule.toJson(),
    );
    if (response.statusCode == 200) {
      final result = response.data as Map<String, dynamic>;
      return Veicule.fromJson(result);
    } else {
      // raise error.
      return;
    }
  }
}
