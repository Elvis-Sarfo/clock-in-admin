class DepartmentsService {
  static final List<String> cities = [
    'Social Sciences',
    'Mathematics',
    'Geography',
    'Business',
    'Home Sciences',
    'Visual Arts',
    'Science',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
