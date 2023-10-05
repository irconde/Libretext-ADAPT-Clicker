
import '../main.dart';
import 'app_state.dart';

class QuestionManager {

  static void createQuestionUrls(List<dynamic> questions) {
    // create an empty list of strings to store the urls
    List<String> urls = [];
    int id = 0;

    if(AppState().assignmentId != 0) {
      id = AppState().assignmentId;
    } else {
      id = AppState().view['questions'][0]['pivot']['assignment_id'];
    }
    // loop through each question in the list
    for (var question in questions) {
      // get the question id from the json
      var questionID = question['id'];



      // construct the url using string interpolation
      var url =
          'https://adapt.libretexts.org/assignments/$id/questions/view/$questionID';

      // add the url to the list
      urls.add(url);
    }

    AppState().urls = urls;
  }

}