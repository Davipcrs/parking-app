dateFormats(DateTime today) {
  String formatedDate = "";

  if (today.day < 10) {
    formatedDate = "${formatedDate}0${today.day}/";
  } else {
    formatedDate = "$formatedDate${today.day}/";
  }
  if (today.month < 10) {
    formatedDate = "${formatedDate}0${today.month}/";
  } else {
    formatedDate = "$formatedDate${today.month}/";
  }
  formatedDate = "$formatedDate${today.year}";

  return formatedDate;
}
