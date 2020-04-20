import 'MetaData.dart';
import 'Sections.dart';

class Audit {
  // info
  String name;

  // Subtrees
  List<Section> sections = [];

  // display info
  bool completed; // Indicates audit is completed

  // additional info
  List<MetaData> metadata;

  List<Map<String, List<Map<String, dynamic>>>> received;

  Audit(this.received) {
    for (Map<String, List<Map<String, dynamic>>> section in received) {
      sections.add(Section(section: section));

      print(sections);
    }
  }
}
