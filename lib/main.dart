import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuapp1/cubit/main_cubit.dart';
import 'package:kuapp1/cubit/main_state.dart';
import 'package:kuapp1/screen/screen1.dart';
import 'package:kuapp1/screen/screen2.dart';
import 'package:kuapp1/screen/screen3.dart';
import 'package:kuapp1/screen/screen4.dart';
import 'package:loading_overlay/loading_overlay.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Timer(Duration(seconds: 3), () async {});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int _selectedIndex = 0;
  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
  }

  List<Widget> _widgetOptions = <Widget>[
    Screen1(link: ""),
    Screen2(link: ""),
    Screen3(link: ""),
    Screen4(link: ""),
  ];
  List<IconData> _icon = [Icons.home, Icons.login, Icons.logout, Icons.help];
  void init() async {}

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.pop(context);
  }

  final List<String> _title = ['Trang chủ', 'Đăng nhập', 'Đăng ký', 'Hỗ trợ'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..init(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.web1 == null || state.web1 == "") {
            return LoadingOverlay(child: Container(), isLoading: true);
          } else {
            _widgetOptions = <Widget>[
              Screen1(link: state.web1!),
              Screen2(link: state.web2!),
              Screen3(link: state.web3!),
              Screen4(link: state.web4!),
            ];
          }
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.amber,
                // backgroundColor: backgroundColor,
                iconTheme: IconThemeData(color: Colors.black),
                title: Text(
                  _title[_selectedIndex],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                centerTitle: false,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
              // backgroundColor: backgroundColor,
              drawer: Drawer(
                backgroundColor: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(
                      height: 112,
                      child: DrawerHeader(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20))),
                          child: Row(
                            children: [
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: const CircleAvatar(
                              //     backgroundColor: Colors.white,
                              //     child: Icon(Icons.person, color: Colors.grey),
                              //   ),
                              // ),
                              // SizedBox(width: 16),
                              // const Flexible(
                              //   child: Text(
                              //     'Xin chào',
                              //     maxLines: 1,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 16,
                              //         color: Colors.black),
                              //   ),
                              // )
                            ],
                          )),
                    ),
                    Column(
                      children: List.generate(4, (index) {
                        return ListTile(
                          leading: Icon(
                            _icon[index],
                            size: 23,
                          ),
                          // Image.asset(
                          //   _icon[index],
                          //   height: 24,
                          //   width: 24,
                          // ),
                          title: Text(
                            _title[index],
                            // style: index != _selectedIndex
                            //     ? titleStyle.copyWith(
                            //         height: 0,
                            //         fontSize: 14.sp,
                            //         color: textColor)
                            //     : titleStyle.copyWith(
                            //         height: 0,
                            //         fontSize: 14.sp,
                            //         color: primaryColor),
                          ),
                          selected: _selectedIndex == index,
                          onTap: () async {
                            // if (index == 3) {
                            //   ///TODO: implement logout
                            //   await _cacheManager.deleteUserToCached();
                            //   _cacheManager.addStatusClickToCached(null);
                            //   context.router.push(const SplashPage());
                            // } else {
                            _onItemTapped(index);
                            // }
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
              body: _widgetOptions.elementAt(_selectedIndex));
        },
      ),
    );
  }
}
