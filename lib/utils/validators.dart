//? dialogを表示するための関数を定義
//? imports ====================================================

//* ------------------------------------------------------------
// メールアドレスのバリデーションを行う関数

bool validateEmail(String email) {
  final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$');
  return regex.hasMatch(email);
}

// *************************************************************
// パスワードのバリデーションを行う関数
bool validatePassword(String password) {
  // パスワードは8文字以上で、英字と数字を含む必要がある
  final regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}\$');
  return regex.hasMatch(password);
}
// *************************************************************
// 電話番号のバリデーションを行う関数 → ハイフンなし

bool validatePhoneNumber(String phoneNumber) {
  // 電話番号は数字のみで、10桁または11桁である必要がある
  final regex = RegExp(r'^\d{10,11}\$');
  return regex.hasMatch(phoneNumber);
}

// *************************************************************
// 郵便番号のバリデーションを行う関数 → ハイフンなし

bool validatePostalCodeNoHyphen(String postal) {
  final regex = RegExp(r'^\d{7}$');
  return regex.hasMatch(postal);
}

// *************************************************************
// URLのバリデーションを行う関数

bool validateUrl(String url) {
  final regex = RegExp(r'^(https?):\/\/[^\s/$.?#].[^\s]*$');
  return regex.hasMatch(url);
}

// *************************************************************
