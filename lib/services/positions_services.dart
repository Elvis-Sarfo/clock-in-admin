class PositionsService {
  static final List<String> cities = [
    'HEAD MISTRESS/MASTER',
    'ASSISTANT HEAD MISTRESS/MASTER ADMINITRATION',
    'ASSISTANT HEAD MISTRESS/MASTER ACADEMICS',
    'ASSISTANT HEAD MISTRESS/MASTER DOMESTICS',
    'SENIOR HOUSE MISTRESS/MASTER',
    'HOUSE MISTRESS/MASTER',
    'FORM TEACHER',
    'ADMINITRATOR',
    'BURZOR',
    'ACCOUNTANT',
    'ACCOUNT OFFICIAL',
    'LIBRARIAN',
    'SECETATRY',
    'MATRON',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
