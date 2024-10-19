import 'dart:convert';

import 'package:custome_mobile/constants/enums.dart';
import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/helpers/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesService {
  static Future<List<SectionNote>> getNotes(String id, NoteType type) async {
    var prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString("token");
    // ignore: prefer_typing_uninitialized_variables
    var rs;
    List<SectionNote> notes = [];

    switch (type) {
      case NoteType.Section:
        {
          rs = await HttpHelper.get("$SECTION_NOTES_ENDPOINT$id/",
              apiToken: jwt);
          break;
        }
      case NoteType.Chapter:
        {
          rs = await HttpHelper.get("$CHAPTER_NOTES_ENDPOINT$id/",
              apiToken: jwt);
          break;
        }
      case NoteType.SubChapter:
        {
          rs = await HttpHelper.get("$SUBCHAPTER_NOTES_ENDPOINT$id/",
              apiToken: jwt);
          break;
        }
      case NoteType.Fee:
        {
          rs = await HttpHelper.get("$FEE_NOTES_ENDPOINT$id/", apiToken: jwt);
          break;
        }
      default:
    }
    if (rs.statusCode == 200) {
      var myDataString = utf8.decode(rs.bodyBytes);

      var result = jsonDecode(myDataString);
      for (var element in result) {
        notes.add(SectionNote.fromJson(element));
      }
    }
    return notes;
  }
}
