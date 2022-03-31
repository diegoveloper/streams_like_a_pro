import 'package:flutter/material.dart';
import 'package:streams_like_a_pro/domain/city.dart';
import 'package:streams_like_a_pro/main.dart';
import 'package:streams_like_a_pro/ui/home/details/details_screen.dart';
import 'package:streams_like_a_pro/ui/home/drawer/drawer_screen.dart';
import 'package:streams_like_a_pro/ui/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc bloc = HomeBloc(
    ServicesInheritedWidget.of(context).myService,
  );

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      bloc.init();
    });
    bloc.streamDetails.listen((event) async {
      await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, animation, __) => FadeTransition(
            opacity: animation,
            child: DetailsScreen(
              city: event,
            ),
          ),
        ),
      );
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
    return StreamBuilder<bool>(
      stream: bloc.streamGridView,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final value = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cities'),
            actions: [
              IconButton(
                icon: Icon(
                  value ? Icons.view_list_sharp : Icons.grid_view_sharp,
                ),
                onPressed: () {
                  bloc.onChangeView(!value);
                },
              ),
            ],
          ),
          drawer: const Drawer(
            child: DrawerScreen(),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              bloc.loadCities();
            },
            child: StreamBuilder<List<City>>(
              stream: bloc.streamCities,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    child: value
                        ? GridView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return CityImage(
                                imageUrl: data[index].image,
                                onTap: () => bloc.onCitySelected(data[index]),
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            itemExtent: 150,
                            itemBuilder: (context, index) {
                              return CityImage(
                                imageUrl: data[index].image,
                                onTap: () => bloc.onCitySelected(data[index]),
                              );
                            },
                          ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class CityImage extends StatelessWidget {
  const CityImage({required this.imageUrl, required this.onTap, Key? key})
      : super(key: key);

  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: imageUrl,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
