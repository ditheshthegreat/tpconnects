import 'package:flutter/material.dart';
import 'package:tp_connects/businees_logic/model/post_details.dart';

import 'feed_player/multi_manager/flick_multi_manager.dart';
import 'feed_player/multi_manager/flick_multi_player.dart';

enum MediaType { IMAGE, VIDEO,TEXT, AUDIO }

class MultiMediaWidget extends StatefulWidget {
  final PostDatum postData;
  final MediaType mediaType;

  const MultiMediaWidget({Key key, this.postData, this.mediaType}) : super(key: key);

  @override
  _MultiMediaWidgetState createState() => _MultiMediaWidgetState();
}

class _MultiMediaWidgetState extends State<MultiMediaWidget> {
  FlickMultiManager flickMultiManager = FlickMultiManager();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.mediaType) {
      case MediaType.IMAGE:
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            "${widget.postData.image}",
            fit: BoxFit.cover,
          ),
        );
      case MediaType.VIDEO:
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: MediaQuery.of(context).size.width,
            child: FlickMultiPlayer(
              url: "${widget.postData.video}",
              flickMultiManager: flickMultiManager,
            ),
          ),
        );
      case MediaType.TEXT:
        return Text("${widget.postData.content}");
      case MediaType.AUDIO:
        return Container(
          color: Colors.grey,
          height: MediaQuery.of(context).size.width,
        );
      default:
        return Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
