import 'MetaData.dart';
import 'Section.dart';

class Audit {
  String name;
  List<Section> sections = [];
  bool completed;
  List<MetaData> metadata;
  List<Map<String, List<Map<String, dynamic>>>> received;

  Audit(this.received) {
    for (Map<String, List<Map<String, dynamic>>> section in received) {
      sections.add(Section(section: section));
      print(sections);
    }
  }
}
