class Channel{

  String? name;
  String? url;
  int? id ;
  String? logo;
  bool? chosen ;
  Channel({this.name,this.id,this.url,this.logo,this.chosen});

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    id: json["id"],
    name: json["name"]??'',
    url:json["url"]??' ',
  );
}