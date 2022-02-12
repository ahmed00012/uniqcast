import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:better_player/better_player.dart';
import 'constants.dart';
import 'data_controller/home_controller.dart';
import 'login.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(dataFuture);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Uniqcast',
            style: TextStyle(color: Colors.white, fontSize: size.height>500? size.height * 0.02:size.width * 0.02),
          ),
          centerTitle: true,
          backgroundColor: Constants.mainColor,
          elevation: 1,
          actions: [
            Container(
              width: 120,
              child: IconButton(
                  onPressed: () {
                    viewModel.logout();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Login()));
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'logout',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: size.height>500? size.height * 0.015:size.width * 0.015),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.logout,
                        size: size.height>500? size.height * 0.02:size.width * 0.02,
                      )
                    ],
                  )),
            )
          ],
        ),
        body: ListView(
          children: [
            viewModel.video,
            ListView.builder(
              itemCount: viewModel.listChannelModel.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return viewModel.listChannelModel[i].name != ''
                    ? Column(
                  children: [
                    Container(
                      height: 1,
                      width: size.width,
                      color:viewModel.listChannelModel[i].chosen!?Constants.secondaryColor:Colors.black12,
                    ),
                    Container(
                      height: size.height>500? size.height * 0.09:size.width * 0.09,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap :(){
                            viewModel.chooseChannel(i);
                },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height>500? size.height * 0.09:size.width * 0.09,
                                width:size.height>500? size.height * 0.07:size.width * 0.07,
                                child: Image.network(
                                  viewModel.listChannelModel[i].logo!,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace? stackTrace) {
                                    return Container(
                                      height: 70,
                                      width: 70,
                                      color: Colors.black12,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  height: size.height>500? size.height * 0.09:size.width * 0.09,
                                  width: 1,
                                  color: viewModel.listChannelModel[i].chosen!?Constants.secondaryColor:Colors.black12,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(top: size.height>500? size.height * 0.02:size.width * 0.02),
                                  child: Text(
                                    viewModel.listChannelModel[i].name!,
                                    style: TextStyle(
                                        fontSize: size.height>500? size.height * 0.02:size.width * 0.02,
                                        fontWeight:viewModel.listChannelModel[i].chosen!?FontWeight.bold: FontWeight.w500,
                                        color: Constants.secondaryColor),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Constants.secondaryColor,
                                ),
                              )
                              // Padding(
                              //   padding:EdgeInsets.only(top: size.height*0.03),
                              //   child: Icon(Icons.arrow_forward_ios_sharp),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: size.width,
                      color: viewModel.listChannelModel[i].chosen!?Constants.secondaryColor:Colors.black12,
                    ),
                  ],
                )
                    : Container();
              },
            )
          ],
        ));
  }
}
