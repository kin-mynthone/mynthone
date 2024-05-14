class SignInResponse {
  final String accessToken;
  final String tokenType;

  SignInResponse({
    required this.accessToken,
    required this.tokenType,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }

  factory SignInResponse.fromMap(Map<String, dynamic> map) {
    return SignInResponse(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
    );
  }

  @override
  String toString() =>
      'AccessToken(accessToken: $accessToken, tokenType: $tokenType)';
}
