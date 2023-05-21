import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  String? name;
  String? image;
  String? email;
  String? youtube;
  String? facebook;
  String? twitter;
  String? instagram;

  User({
    this.uid,
    this.name,
    this.image,
    this.email,
    this.youtube,
    this.facebook,
    this.twitter,
    this.instagram,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "image": image,
        "email": email,
        "youtube": youtube,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
      };

  static User fromSnap(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      uid: dataSnapshot["uid"],
      name: dataSnapshot["name"],
      image: dataSnapshot["image"],
      email: dataSnapshot["email"],
      youtube: dataSnapshot["youtube"],
      facebook: dataSnapshot["facebook"],
      twitter: dataSnapshot["twitter"],
      instagram: dataSnapshot["instagram"],
    );
  }
}
