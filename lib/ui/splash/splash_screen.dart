import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streams_like_a_pro/ui/home/home_screen.dart';
import 'package:streams_like_a_pro/ui/splash/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final bloc = SplashBloc();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      bloc.startSplashAnimation(MediaQuery.of(context).size.width * 2);
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<double>(
            stream: bloc.sizeStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOut,
                  height: data,
                  width: data,
                  child: Image.asset(
                    'assets/dash_avatar.png',
                    fit: BoxFit.cover,
                  ),
                  onEnd: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 850),
                        transitionsBuilder: (_, animation, __, child) {
                          return ScaleTransition(
                            scale: CurvedAnimation(
                              parent: animation,
                              curve: Curves.elasticOut,
                            ),
                            child: child,
                          );
                        },
                        pageBuilder: (_, animation, __) {
                          return const HomeScreen();
                        },
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
