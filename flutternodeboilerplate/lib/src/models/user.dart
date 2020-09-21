

class User {
  String key;
  String name;
  String gender;
  String mobile;
  String password;
  String email;
  String address;

  User(
      this.name,
      this.mobile,
      this.password,
      this.gender,
      this.email, this.address);
  //User(this.mobile,this.password);

//  User.fromSnapshot(DataSnapshot snapshot)
//      : key = snapshot.key,
//        username = snapshot.value["username"],
//        gender = snapshot.value["gender"],
//        institution = snapshot.value["institution"],
//        department = snapshot.value["department"],
//        area = snapshot.value["area"],
//        address = snapshot.value["address"],
//        mobile = snapshot.value["mobile"],
//        password = snapshot.value["password"],
//        email = snapshot.value["email"],
//        rating = snapshot.value["rating"],
//        number = snapshot.value["number"],
//        subject = snapshot.value["subject"],
//        notification = snapshot.value["notification"];
  toJson() {
    return {
      "username": name,
      "mobile": mobile,
      "password": password,
      "gender": gender,
      "email": email,
      "address":address,

    };
  }
}
