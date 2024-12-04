// {
//       "title": "별내행정복지센터",
//       "link": "",
//       "category": "공공,사회기관>행정복지센터",
//       "description": "",
//       "telephone": "",
//       "address": "경기도 남양주시 별내동 1028",
//       "roadAddress": "경기도 남양주시 별내3로 64-21",
//       "mapx": "1271220035",
//       "mapy": "376461793"
//     },

class Location {
  final String title;
  final String link;
  final String category;
  final String description;
  final String telephone;
  final String address;
  final String roadAddress;
  final String mapx;
  final String mapy;

  Location({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  Location.fromJson(Map<String, dynamic> json)
      : this(
          title: json["title"],
          link: json["link"],
          category: json["category"],
          description: json["description"],
          telephone: json["telephone"],
          address: json["address"],
          roadAddress: json["roadAddress"],
          mapx: json["mapx"],
          mapy: json["mapy"],
        );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "category": category,
        "description": description,
        "telephone": telephone,
        "address": address,
        "roadAddress": roadAddress,
        "mapx": mapx,
        "mapy": mapy,
      };
}
