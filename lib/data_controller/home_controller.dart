import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:uniqcast/models/channel_model.dart';
import 'local_storage.dart';
import 'package:better_player/better_player.dart';



final dataFuture = ChangeNotifierProvider.autoDispose<HomeController>(
    (ref) => HomeController());

class HomeController extends ChangeNotifier {
  List<Channel> listChannelModel = [];
  BetterPlayerController? betterPlayerController;
  Widget video = Container();

  HomeController() {
    getData();
    // videoController();
  }
  logout() {
    LocalStorage.removeData(key: 'token');
    notifyListeners();
  }


  Future<void> chooseChannel(int i)async {
    listChannelModel.forEach((element) {
      element.chosen = false;
    });
    listChannelModel[i].chosen = true;
    if (betterPlayerController == null) {
      videoController(listChannelModel[i].url!);
    } else {
      video =  AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(),
      );
      final oldController = betterPlayerController;
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        oldController!.dispose();
        videoController(listChannelModel[i].url!);
        notifyListeners();
      });


    }
    notifyListeners();
  }

  videoController(String url) {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      videoFormat: BetterPlayerVideoFormat.hls,
    );
    betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
            autoPlay: true,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              showControls: false,
            )),
        betterPlayerDataSource: betterPlayerDataSource);
   video= Stack(
     children: [

       AspectRatio(
         aspectRatio: 16 / 9,
         child: BetterPlayer(
           controller: betterPlayerController!,
         ),
       ),
       Positioned(
           top: 5,
           left: 10,
           child: InkWell(
             onTap: (){
               listChannelModel.forEach((element) {element.chosen=false;});
               video = Container();
               final oldController = betterPlayerController;
               WidgetsBinding.instance!.addPostFrameCallback((_) async {
                 oldController!.dispose();
                 notifyListeners();
               });
               notifyListeners();
             },
             child: Container(
               height: 30,
               width: 30,
               decoration: BoxDecoration(
                 color: Colors.white.withOpacity(0.2),
                 borderRadius: BorderRadius.circular(10)
               ),
               child: Icon(Icons.close),
             ),
           )),
     ],
   );
    notifyListeners();
  }

  Future getData() async {
    listChannelModel = [];
    try {
      http.Response response = await http
          .get(Uri.parse("http://devel.uniqcast.com:3001/channels"), headers: {
        "Authorization": "Bearer ${LocalStorage.getData(key: 'token')}"
      });

      var data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        listChannelModel.add(Channel.fromJson(data[i]));
        listChannelModel[i].logo =
            'https://devel.uniqcast.com/samples/logos/${data[i]['id']}.png';
        listChannelModel[i].chosen=false;
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
