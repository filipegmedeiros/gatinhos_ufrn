class CatAd {
  String id;
  String img; // image path
  String catName;
  DateTime rescueDate;
  String description;
  String gender;
  List<String> healthTags;

  CatAd(
      {this.id,
      this.img,
      this.catName,
      this.rescueDate,
      this.description,
      this.gender,
      this.healthTags}) {
    // ensure list was initialized
    if (this.healthTags == null) {
      this.healthTags = List.empty(growable: true);
    }
  }

  factory CatAd.fromJson(Map<String, dynamic> parsedJson) {
    CatAd adRet = CatAd(
      id: parsedJson['id'].toString(),
      catName: parsedJson['name'].toString(),
      rescueDate: DateTime.parse(parsedJson['rescueDate'].toString()),
      description: parsedJson['description'].toString(),
      gender: parsedJson['gender'].toString(),
      img: "http://localhost:3001/api/v1/image/" +
          parsedJson['image'].toString(),
    );

    if (parsedJson['vaccines'].toString() == "true") {
      adRet.healthTags.add("Vacinado(a)");
    }

    if (parsedJson['castrate'].toString() == "false") {
      adRet.healthTags.add("Castrado(a)");
    }
    return adRet;
  }

  @override
  String toString() {
    return "Contact(id: ${id}, img: ${img}, name: ${catName}, email: ${rescueDate}, phone: ${description}, sex: ${gender}, healthTags: ${healthTags.toString()}))";
  }
}
