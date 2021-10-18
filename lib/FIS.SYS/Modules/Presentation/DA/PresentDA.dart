import 'dart:convert';

import '../../../Core/BaseDA.dart';
import '../../../Core/BaseResponse.dart';
import '../../ConfigKhaoThi.dart';
import '../../Students/StudentItem.dart';
import '../AnswerPresentation.dart';
import '../ClassPresentModel.dart';
import '../PresentRequest.dart';
import '../PresentationModel.dart';
import '../Question.dart';

class PresentDA extends BaseDA {
  Future<ClassPresentModel> getClassHasPresent() async {
    const url = ConfigAPI.getClassHasPresent;
    final result = await get(url, ClassPresentModel());

    return result;
  }

  // get presentation
  Future<PresentationModel> getPresentationActiveByClassId(
      int classId, int pageId, int pageSize, List<int> status) async {
    final url = ConfigAPI.getPresentsByClass;
    var st = '';
    for (var i = 0; i < status.length; i++) {
      // ignore: use_string_buffers
      st = '$st${'&status[]=${status[i]}'}';
    }
    final PresentationModel result = await get(
        '$url?class_id=$classId&page=$pageId&page_size=$pageSize$st',
        PresentationModel());
    if (result.code == 200) {
      for (final present in result.presents) {
        final question = await getQuestionsFromCache(present.testFormId);

        if (question.code == 200 &&
            question.items.length == present.totalItems) {
          present.items = question.items;
        }

        present.questionScanedIds = await loadQuestionScanedIds(present.id);
      }
    }
    return result;
  }

  Future<List<int>> loadQuestionScanedIds(int presentId) async {
    final presentCache =
        await BaseDA.storage.read(key: 'PresentQuestionScaned$presentId');

    var questions = <int>[];
    if (presentCache != null) {
      questions = presentCache.split(',').map(int.parse).toList();
    }
    return questions;
  }

  Future<void> saveQuestion(int questionId, int presentId) async {
    final presentCache =
        await BaseDA.storage.read(key: 'PresentQuestionScaned$presentId');

    var questions = <int>[];
    if (presentCache != null) {
      questions = presentCache.split(',').map(int.parse).toList();
    }

    if (!questions.contains(questionId)) {
      questions.add(questionId);
    }

    final result = questions.join(',');

    await BaseDA.storage
        .write(key: 'PresentQuestionScaned$presentId', value: result);
  }

  Future<PresentRequest> getPresentFromCache(int presentId) async {
    final presentCache =
        await BaseDA.storage.read(key: 'PresentRequest$presentId');
    var present = PresentRequest(id: presentId, answerData: <AnswerData>[]);
    if (presentCache != null) {
      present = PresentRequest.fromJson(json.decode(presentCache));
    }
    return present;
  }

  Future<bool> saveAnswer(
      List<StudentItem> students, int questionId, int presentId) async {
    final present = await getPresentFromCache(presentId);

    final answerData = present.answerData;

    // ignore: void_checks
    students.forEach((student) {
      if (student.answer == null) {
        return true;
      }
      final answerexist = present.answerData.firstWhere(
          (element) =>
              element.studentId == student.id && element.itemId == questionId,
          orElse: () => null);

      if (answerexist == null) {
        answerData.add(AnswerData(
            studentId: student.id,
            itemId: questionId,
            answer: int.parse(student.answer)));
      } else {
        answerexist.answer = int.parse(student.answer);
      }
    });
    present.answerData = answerData;
    await BaseDA.storage.write(
        key: 'PresentRequest$presentId', value: json.encode(present.toJson()));
    return true;
  }

  Future<PresentationModel> submitAnswer(int presentId) async {
    var present = await BaseDA.storage.read(key: 'PresentRequest$presentId');

    present ??= '{"id":$presentId,"answer_data":[]}';
    final url = ConfigAPI.postAnswer;

    final result = await postData(url, present, PresentationModel());
    return result;
  }

  Future resetAnwer(int presentId, int questionId) async {
    final presentCache =
        await BaseDA.storage.read(key: 'PresentRequest$presentId');
    var present = PresentRequest(id: presentId, answerData: <AnswerData>[]);
    if (presentCache == null) {
      return;
    }
    present = PresentRequest.fromJson(json.decode(presentCache));
    present.answerData = present.answerData
        .where((element) => element.itemId != questionId)
        .toList();
    present.answerData.forEach((element) {
      element.answer = null;
    });
    await BaseDA.storage.write(
        key: 'PresentRequest$presentId', value: json.encode(present.toJson()));
  }

  Future<BasicResponse> startPresent(int presentId) async {
    final url = ConfigAPI.postStartPresentation;
    return await post('$url?id=$presentId', BasicResponse());
  }

  List dataMap;
  Future<QuestionModel> getQuestions(int presentId) async {
    // var url = ConfigAPI.getQuestionInPresentation;
    // return await get("$url?id=$presentId", QuestionModel());
    var response = QuestionModel();
    final url = ConfigAPI.getQuestionInPresentation;
    response = await get('$url?id=$presentId', QuestionModel());
    if (response.code == 200) {
      dataMap = response.items.map((e) => e.toJson()).toList();
      // final jsonValue = json.encode(dataMap);
      await BaseDA.storage.write(
          key: 'getQuestionsFromCache$presentId', value: jsonEncode(dataMap));
    }
    return response;
  }

  Future<QuestionModel> getQuestionsFromCache(int presentId) async {
    // BaseDA.storage.delete(key: "getQuestionsFromCache$presentId");
    // final jsonCache =
    // await BaseDA.storage.read(key: 'getQuestionsFromCache$presentId');
    // final dataMap = jsonDecode(jsonCache);
    final response = QuestionModel();
    if (dataMap == null) {
      return response..code = -1;
    }
    final questions = dataMap.map((e) => Question.fromJson(e)).toList();
    response.code = 200;
    response.items = questions;
    return response;
  }

  // get presentation
  Future<PresentationModel> getHistoryPresentationActiveByClassId(
      int classId, int pageId, int pageSize, List<int> status) async {
    final url = ConfigAPI.getHistoryPresentsByClass;

    final PresentationModel result = await get(
        '$url?class_id=$classId&page=$pageId&page_size=$pageSize',
        PresentationModel());

    if (result.code == 200) {
      for (final present in result.presents) {
        final question = await getQuestionsFromCache(present.testFormId);

        if (question.code == 200 &&
            question.items.length == present.totalItems) {
          present.items = question.items;
        }
      }
    }
    return result;
  }

  // get presentation
  Future<AnswerPresentationModel> getAnswer(
    int id,
  ) async {
    final url = ConfigAPI.getAnswerForPresentation;

    final AnswerPresentationModel result =
        await get('$url?id=$id', AnswerPresentationModel());

    return result;
  }
}
