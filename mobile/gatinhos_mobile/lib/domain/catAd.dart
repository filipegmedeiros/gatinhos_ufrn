class CatAd {
  int id;
  String img; // image path
  String catName;
  String catAge;
  String description;
  String sex;
  List<String> healthTags;

  CatAd(
      {this.id,
      this.img,
      this.catName,
      this.catAge,
      this.description,
      this.sex,
      this.healthTags}) {
    // ensure list was initialized
    if (this.healthTags == null) {
      this.healthTags = List.empty(growable: true);
    }
  }

  @override
  String toString() {
    return "Contact(id: ${id}, img: ${img}, name: ${catName}, email: ${catAge}, phone: ${description}, sex: ${sex}, healthTags: ${healthTags.toString()}))";
  }
}
