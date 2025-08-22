class SignUpPayload {
  SignUpPayload({
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.primaryPhone,
    required this.primaryAddress,
    required this.city,
    required this.state,
    required this.country,
    required this.photo,
  });

  final String? role;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? passwordConfirm;
  final String? primaryPhone;
  final String? primaryAddress;
  final String? city;
  final String? state;
  final String? country;
  final String? photo;

  SignUpPayload copyWith({
    String? role,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? passwordConfirm,
    String? primaryPhone,
    String? primaryAddress,
    String? city,
    String? state,
    String? country,
    String? photo,
  }) {
    return SignUpPayload(
      role: role ?? this.role,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      photo: photo ?? this.photo,
    );
  }

  factory SignUpPayload.fromJson(Map<String, dynamic> json){
    return SignUpPayload(
      role: json["role"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      password: json["password"],
      passwordConfirm: json["passwordConfirm"],
      primaryPhone: json["primaryPhone"],
      primaryAddress: json["primaryAddress"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toJson() => {
    "role": role,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "passwordConfirm": passwordConfirm,
    "primaryPhone": primaryPhone,
    "primaryAddress": primaryAddress,
    "city": city,
    "state": state,
    "country": country,
    "photo": photo,
  };

  @override
  String toString(){
    return "$role, $firstName, $lastName, $email, $password, $passwordConfirm, $primaryPhone, $primaryAddress, $city, $state, $country, $photo, ";
  }
}
