import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _titlesKey = "titles";
  static const String _descsKey = "descs";
  static const String _imageFileListKey = "imageFileList";

  Future<void> saveData(List<String> titles, List<String> descs,
      List<List<XFile>> imageFileList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_titlesKey, titles);
    await prefs.setStringList(_descsKey, descs);

    // Convert the nested List<List<XFile>> to List<String>
    List<String> imagePathLists = imageFileList
        .map((fileList) => fileList.map((file) => file.path).join(','))
        .toList();

    // Save the nested list as a single string
    await prefs.setStringList(_imageFileListKey, imagePathLists);
  }

  Future<Map<String, dynamic>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> titles = prefs.getStringList(_titlesKey) ?? [];
    List<String> descs = prefs.getStringList(_descsKey) ?? [];

    // Retrieve and parse the nested list string
    List<String> imagePathListString =
        prefs.getStringList(_imageFileListKey) ?? [];
    List<List<String>> imagePathLists = imagePathListString
        .map((listString) => listString.split(',').toList())
        .toList();

    // Convert the List<List<String>> back to List<List<XFile>>
    List<List<XFile>> imageFileList = imagePathLists
        .map((list) => list.map((path) => XFile(path)).toList())
        .toList();

    return {
      "titles": titles,
      "descs": descs,
      "imageFileList": imageFileList,
    };
  }
}
