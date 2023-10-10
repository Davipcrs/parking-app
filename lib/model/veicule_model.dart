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
    return Veicule(
      id_veiculo: json["id_veiculo"] as int,
      str_license: json["str_license"] as String,
      str_timein: json["str_timein"] as String,
      str_timeout: json["str_timeout"] as String,
      bool_issubscriber: json["bool_issubscriber"] as bool,
      bool_haskey: json["bool_haskey"] as bool,
      bool_ismotorbike: json["bool_ismotorbike"] as bool,
      str_date: json["str_date"] as String,
      bool_haspaidearly: json["bool_haspaidearly"],
    );
  }
}
