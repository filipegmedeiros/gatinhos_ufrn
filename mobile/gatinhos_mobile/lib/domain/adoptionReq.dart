class AdoptionReq {
  String id;
  String img;
  String personName;
  String phone;
  bool animals;
  bool safeGuard;
  bool isHouse;

  AdoptionReq(
      {this.id,
      this.img,
      this.personName,
      this.phone,
      this.animals,
      this.safeGuard,
      this.isHouse}) {}

  factory AdoptionReq.fromJson(Map<String, dynamic> parsedJson) {
    AdoptionReq adoptionReq = AdoptionReq(
        id: parsedJson['_id'].toString(),
        personName: parsedJson['name'].toString(),
        img: parsedJson['image'],
        phone: parsedJson['phone'].toString(),
        animals: parsedJson['animals'],
        safeGuard: parsedJson['safe_guard'],
        isHouse: parsedJson['isHouse']);
    return adoptionReq;
  }
}
