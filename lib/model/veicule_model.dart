// ignore_for_file: non_constant_identifier_names

class Veicule {
  Veicule(
      {this.id_veiculo,
      this.str_license,
      this.str_timein,
      this.str_timeout,
      this.bool_issubscriber,
      this.bool_haskey,
      this.bool_ismotorbike,
      this.str_date,
      this.bool_haspaidearly});

  late int? id_veiculo;
  late String? str_license;
  late String? str_timein;
  late String? str_timeout;
  late bool? bool_issubscriber;
  late bool? bool_haskey;
  late bool? bool_ismotorbike;
  late String? str_date;
  late bool? bool_haspaidearly;

  //factory
  factory Veicule.fromJson(json) {
    late bool haspaidearly;
    if (json["bool_haspaidearly"] == null) {
      haspaidearly = false;
    } else {
      haspaidearly = json['bool_haspaidearly'] as bool;
    }

    return Veicule(
      id_veiculo: json["id_veiculo"] as int,
      str_license: json["str_license"] as String,
      str_timein: json["str_timein"] as String,
      str_timeout: json["str_timeout"] as String,
      bool_issubscriber: json["bool_issubscriber"] as bool,
      bool_haskey: json["bool_haskey"] as bool,
      bool_ismotorbike: json["bool_ismotorbike"] as bool,
      str_date: json["str_date"] as String,
      bool_haspaidearly: haspaidearly,
    );
  }

  // convert to json for the API Post.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id_veiculo": id_veiculo,
      "str_license": str_license,
      "str_timein": str_timein,
      "str_timeout": str_timeout,
      "bool_issubscriber": bool_issubscriber,
      "bool_haskey": bool_haskey,
      "bool_ismotorbike": bool_ismotorbike,
      "str_date": str_date,
      "bool_haspaidearly": bool_haspaidearly
    };

    return map;
  }
}
