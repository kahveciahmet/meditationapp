import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DerinUyku extends StatefulWidget {
  const DerinUyku({super.key});

  @override
  State<DerinUyku> createState() => _DerinUykuState();
}

class _DerinUykuState extends State<DerinUyku> {
  final videoURL = "https://www.youtube.com/watch?v=rq52iDYPe_A&t=618s&ab_channel=mistikyol";

  late YoutubePlayerController _controller;

  @override
  void initState(){
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,

        )
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final websiteUri = Uri.parse("https://www.youtube.com/@mistikyol");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Derin Uyku Meditasyonu"),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(controller: _controller,
            showVideoProgressIndicator: true,
          ),
          const SizedBox(height: 15.0,),
          Container(
            color: Colors.blue[900], // Arkaplan rengi
            padding: const EdgeInsets.all(50.0),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Derin uyku meditasyonu, rahatlamayı teşvik eden bir meditasyon türüdür ve genellikle uykuya dalma sürecini iyileştirmek amacıyla uygulanır. Bu meditasyon, zihni sakinleştirmeye, stresten arınmaya ve daha huzurlu bir zihinsel duruma geçiş yapmaya odaklanır.",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 35.0),
          Center(
            child: ElevatedButton(
                onPressed: () => setState(() {
                  launchUrl(
                    websiteUri,
                    mode: LaunchMode.externalApplication,
                  );
                }),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(500, 80),
                  elevation: 10.0,
                  side: const BorderSide(color: Colors.blueAccent, width: 5.0),
                ),
                child: const Text("Bu kanaldan daha fazlası için tıklayın!",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.blueAccent,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
