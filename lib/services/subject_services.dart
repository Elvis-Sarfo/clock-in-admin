class SubjectsService {
  static final List<String> cities = [
    'INTEGRATED SCIENCE',
    'MATHEMATICS',
    'ENGLISH',
    'SOCIAL STUDIES',
    'ELECTIVE MATHEMATICS',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
