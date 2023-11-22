import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:interview_flutter/src/models/response/person.dart';
import 'package:interview_flutter/src/services/base_client.dart';
import 'package:interview_flutter/src/views/person_detail_screen.dart';
import 'package:interview_flutter/utils/constants.dart';

class PersonController extends GetxController {
  final scrollController = ScrollController();

  final _listPersons = <Person>[].obs;
  List<Person> get listPersons => _listPersons;

  final _limit = RxInt(10);
  int get limit => _limit.value;

  final _loading = RxBool(true);
  bool get loading => _loading.value;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDataPersons();
      scrollController.addListener(_scrollController);
    });
    super.onInit();
  }

  @override
  void onClose() {
    PersonController().dispose();
    super.onClose();
  }

  // handle scroll
  void _scrollController() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (_listPersons.length < 70) {
        _limit.value = limit + 20;
        _getDataPersons();
      } else {
        Get.snackbar("No more data !", "", snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
  // refresh

  Future<void> refreshList() async {
    _limit.value = 10;
    _getDataPersons();
  }

  // go to Detail
  void goToDetail(Person data) {
    Get.to(() => PersonDetailScreen(data: data));
  }

  void setLoading(bool value) {
    _loading.value = value;
    update(['person_list']);
  }

  /// get api
  Future<void> _getDataPersons() async {
    setLoading(true);
    await BaseClient.safeApiCall(
      Constants.personApi,
      RequestType.get,
      queryParameters: {
        '_quantity': limit,
      },
      onSuccess: (response) async {
        final res = PersonResponse.fromJson(response.data);
        _listPersons.value = res.data ?? [];
        setLoading(false);
      },
    );
  }
}
