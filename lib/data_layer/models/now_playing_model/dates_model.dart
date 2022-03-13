class Dates {
  late final String maximum;
  late final String minimum;
  Dates.fromJson(Map<String, dynamic> json){
    maximum = json['maximum'];
    minimum = json['minimum'];
  }
}