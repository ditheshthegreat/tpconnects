import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tp_connects/businees_logic/model/post_details.dart';
import 'package:tp_connects/businees_logic/view_models/home_view_model.dart';
import 'package:tp_connects/businees_logic/view_models/login_viewmodel.dart';
import 'package:tp_connects/ui/view/login_view.dart';
import 'package:tp_connects/ui/widget/multi_media.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _homeViewModel = HomeViewModel();
  var _scrollController = ScrollController();

  @override
  void initState() {
    _homeViewModel.getPostList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Feeds"),
            actions: [
              GestureDetector(
                onTap: () async {
                  await LoginViewModel().deleteUserDatabase();
                  Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginView()), (route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (t) {
                  if (t.metrics.atEdge) {
                    print("End Reached::");
                    if (!model.endReached) {
                      model.page = model.page + 1;
                      model.getPostList();
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                    controller: _scrollController,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: model.postDatum.length,
                    itemBuilder: (context, index) {
                      var postData = model.postDatum[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                          ListTile(
                            visualDensity: VisualDensity.comfortable,
                            dense: true,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(postData.details.image),
                            ),
                            title: RichText(
                              text: TextSpan(
                                text: "${postData.details.name}",
                                style: Theme.of(context).textTheme.subtitle2,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: postData.location == null ? "" : " is at ${postData.location.address}",
                                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.blueGrey),
                                  )
                                ],
                              ),
                            ),
                            subtitle: Text("${timeago.format(postData.postDate, allowFromNow: true)}",
                                style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.blueGrey)),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Visibility(
                                  visible: postData.title != "default",
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${postData.title}",
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: postData.image != null || postData.video != null,
                                  child: MultiMediaWidget(
                                    mediaType: postData.postType == "photo"
                                        ? MediaType.IMAGE
                                        : postData.postType == "video"
                                            ? MediaType.VIDEO
                                            : postData.postType == "text"
                                                ? MediaType.TEXT
                                                : MediaType.AUDIO,
                                    postData: postData,
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FractionColumnWidth(.10),
                                    1: FractionColumnWidth(.60),
                                    2: FractionColumnWidth(.15),
                                    3: FractionColumnWidth(.15),
                                  },
                                  children: <TableRow>[
                                    TableRow(children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Image.asset(
                                            "assets/react.png",
                                          )),
                                      postData.reacts.isEmpty
                                          ? Container()
                                          : Text(
                                              "${getTotalReact(postData.reacts) == 1 ? "${getTotalReact(postData.reacts)} Like" : "${getTotalReact(postData.reacts)} Likes"}",
                                              style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.grey),
                                            ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "${postData.comments}",
                                            style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.grey),
                                          ),
                                          Icon(Icons.comment_outlined)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "0",
                                            style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.grey),
                                          ),
                                          Image.asset(
                                            "assets/share.png",
                                          )
                                        ],
                                      ),
                                    ])
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      postData.comments == 0
                                          ? "No Comments"
                                          : "${postData.comments == 1 ? "View all comments" : "View all "
                                              "${postData.comments} comments"}",
                                      style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextField(
                                  minLines: 1,
                                  maxLines: 5,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    hintText: "Write a comment",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(color: Theme.of(context).hintColor),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide.none),
                                  ),
                                ),
                                SizedBox(
                                  height: 24.0,
                                ),
                              ],
                            ),
                          )
                        ]),
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int getTotalReact(List<React> reacts) {
    int totalReacts = 0;
    for (React react in reacts) {
      totalReacts += react.cn;
    }
    return totalReacts;
  }
}
