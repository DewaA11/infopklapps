class Questionnaire {
  String id;
  String title;
  List<Question> questions;

  Questionnaire(
      {required this.id, required this.title, required this.questions});
}

class Question {
  String id;
  String text;
  List<String> options;
  int selectedOptionIndex;

  Question(
      {required this.id,
      required this.text,
      required this.options,
      required this.selectedOptionIndex});
}
