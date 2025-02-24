class InputModel {
  bool isValidInput;
  String error;

  InputModel({required this.error, required this.isValidInput});

  @override
  String toString() {
    return {"error": error, "isValidInput": isValidInput}.toString();
  }
}
