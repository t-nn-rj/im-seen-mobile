// The User model
class User {
  //String userId;
  //String firstname;
  //String lastname;
  String email;
  //String phone;
  //String jobTitle;
  String token;
  String refreshToken;
  //String expiresIn;

  User({
    //this.userId,
    //this.firstname,
    //this.lastname,
    required this.email,
    //this.phone,
    //this.jobTitle,
    required this.token,
    required this.refreshToken,
    //this.expiresIn,
  });

  // translate Json data to user model
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      //userId: responseData['id'],
      //firstname: responseData['firstname'],
      //lastname: responseData['lastname'],
      email: responseData['email'],
      //phone: responseData['phone'],
      //jobTitle: responseData['jobTitle'],
      token: responseData['token'],
      refreshToken: responseData['refreshToken'],
      //expiresIn: responseData['expiresIn'],
    );
  }
}
