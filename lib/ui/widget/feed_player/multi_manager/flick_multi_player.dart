

import 'dart:typed_data';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../portrait_controls.dart';
import './flick_multi_manager.dart';
import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FlickMultiPlayer extends StatefulWidget {
  const FlickMultiPlayer(
      {Key key, this.url,  this.flickMultiManager})
      : super(key: key);

  final String url;
  final FlickMultiManager flickMultiManager;

  @override
  _FlickMultiPlayerState createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer> {
  FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url)
        ..setLooping(false),
      autoPlay: false,
    );
    widget.flickMultiManager.init(flickManager);

    super.initState();
  }

  @override
  void dispose() {
    widget.flickMultiManager.remove(flickManager);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > .5) {
          widget.flickMultiManager.play(flickManager);
        }
      },
      child: Container(
        child: FlickVideoPlayer(
          flickManager: flickManager,
          wakelockEnabled: true,
          flickVideoWithControls: FlickVideoWithControls(
            backgroundColor: Colors.black,
            videoFit: BoxFit.cover,
            playerLoadingFallback: Positioned.fill(
              child: Stack(
                children: <Widget>[
                  FutureBuilder(
                    future: getNetworkVideoThumbnail(widget.url),
                    builder: (context,snapshot) {
                      if(snapshot.hasData) {
                        print("snapshot::");
                        print("${snapshot.data}");
                          return Positioned.fill(
                            child: Image.memory(
                              snapshot.data,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else
                        return Container();
                    }
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            controls: FeedPlayerPortraitControls(
              flickMultiManager: widget.flickMultiManager,
              flickManager: flickManager,
            ),
          ),
        ),
      ),
    );
  }
  Future<Uint8List> getNetworkVideoThumbnail(String videoUrl) async {
    var data = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 300,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      maxHeight: 300,
      quality: 100,
    );
    return data;
  }
}