// The User model
class User {
  int userId;
  String firstname;
  String lastname;
  String email;
  String phone;
  String jobTitle;
  String deptId;
  String roleId;
  String groupId;
  String token;
  String renewalToken;

  User(
      {this.userId,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.jobTitle,
      //this.deptId,
      //this.roleId,
      //this.groupId,
      this.token,
      this.renewalToken});

  // translate Json data to user model
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        firstname: responseData['firstname'],
        lastname: responseData['lastname'],
        email: responseData['email'],
        phone: responseData['phone'],
        jobTitle: responseData['jobTitle'],
        //deptId: responseData['deptId'],
        //roleId: responseData['roleId'],
        //groupId: responseData['groupId'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']);
  }
}
