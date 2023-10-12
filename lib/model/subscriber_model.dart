// ignore_for_file: non_constant_identifier_names

class Subscriber {
  Subscriber({
    this.id_mensalista,
    this.str_name,
    this.str_carmodel,
    this.str_initdate,
    this.str_enddate,
    this.str_license,
    this.str_weekdays,
    this.bool_ismensalist,
    this.bool_ismotorbike,
    this.str_contact,
  });

  late int? id_mensalista;
  late String? str_name;
  late String? str_carmodel;
  late String? str_initdate;
  late String? str_enddate;
  late String? str_license;
  late String? str_weekdays;
  late bool? bool_ismensalist;
  late bool? bool_ismotorbike;
  late String? str_contact;

  factory Subscriber.fromJson(json) {
    return Subscriber(
        id_mensalista: json["id_mensalista"],
        str_name: json["str_name"],
        str_carmodel: json["str_carmodel"],
        str_initdate: json["str_initdate"],
        str_enddate: json["str_enddate"],
        str_license: json["str_license"],
        str_weekdays: json["str_weekdays"],
        bool_ismensalist: json["bool_ismensalist"],
        bool_ismotorbike: json["bool_ismotorbike"],
        str_contact: json["str_contact"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_mensalista": id_mensalista,
      "str_name": str_name,
      "str_carmodel": str_carmodel,
      "str_initdate": str_initdate,
      "str_enddate": str_enddate,
      "str_license": str_license,
      "str_weekdays": str_weekdays,
      "bool_ismensalist": bool_ismensalist,
      "bool_ismotorbike": bool_ismotorbike,
      "str_contact": str_contact,
    };
  }
}
