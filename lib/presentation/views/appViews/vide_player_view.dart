import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VidePlayerView extends StatefulWidget {
  const VidePlayerView({Key key}) : super(key: key);

  @override
  _VidePlayerViewState createState() => _VidePlayerViewState();
}

class _VidePlayerViewState extends State<VidePlayerView> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: 'FF96KUvaR5k',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "How To Use", doestNotshow: true),
      body: _getUI(context),
      drawer: AppDrawer(),
    );
  }

  Widget _getUI(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      actionsPadding: const EdgeInsets.only(left: 16.0),
      bottomActions: [
        CurrentPosition(),
        const SizedBox(width: 10.0),
        ProgressBar(isExpanded: true),
        const SizedBox(width: 10.0),
        RemainingDuration(),
        FullScreenButton(),
      ],
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();
    super.dispose();
  }
}
