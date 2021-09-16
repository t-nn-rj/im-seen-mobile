// The User model
class User {
  String userId;
  String firstname;
  String lastname;
  String email;
  //String phone;
  String jobTitle;
  String token;
  String expiresIn;

  User(
      {this.userId,
      this.firstname,
      this.lastname,
      this.email,
      //this.phone,
      this.jobTitle,
      this.token,
      this.expiresIn});

  // translate Json data to user model
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      //userId: responseData['id'],
      firstname: responseData['firstname'],
      lastname: responseData['lastname'],
      email: responseData['email'],
      //phone: responseData['phone'],
      jobTitle: responseData['jobTitle'],
      token: responseData['access_token'],
      //expiresIn: responseData['expiresIn'],
    );
  }
}
