import 'package:flutter/foundation.dart';
import 'package:tp_connects/businees_logic/model/post_details.dart';
import 'package:tp_connects/businees_logic/model/user_details.dart';
import 'package:tp_connects/businees_logic/view_models/login_viewmodel.dart';
import 'package:tp_connects/service/rest/RestAPI.dart';

class HomeViewModel extends ChangeNotifier {
  UserDetailsModel _userDetails;
  var page = 1;
  var endReached = false;
  var postDatum = List<PostDatum>();

  Future<void> getPostList() async {
    if (_userDetails == null) {
      _userDetails = await LoginViewModel().getUserDetails();
    }
    try {
      var response = await RestAPI().get(RestAPI.getPosts, params: {
        "user_token": _userDetails.userToken,
        "page": page,
        "user_only": int.parse(_userDetails.profileId),
      });
      var _postDetailsModel = PostDetailsModel.fromJson(response).data;
      if (page == 1)
        postDatum = _postDetailsModel;
      else
        postDatum.addAll(_postDetailsModel);
      endReached = _postDetailsModel.isEmpty;
      print("POST_DATUM :: $postDatum");
      notifyListeners();
    } on Exception catch (e) {
      throw e;
    }
  }
}
