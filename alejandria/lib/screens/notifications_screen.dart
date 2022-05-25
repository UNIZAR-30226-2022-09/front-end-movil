import 'package:alejandria/services/notificaciones_service.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/my_posts_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  Future? myFuture;

  bool isLoading = false;

  Future<void> getNotificaciones() async {
    final notificacionesService =
        Provider.of<NotificacionesService>(context, listen: false);
    await notificacionesService.loadNotificaciones();
  }

  Future<void> _fetchMore() async {
    if (isLoading) return;
    isLoading = true;
    final notificacionesService =
        Provider.of<NotificacionesService>(context, listen: false);
    await notificacionesService.loadMoreNotificaciones();
    Future.delayed(const Duration(seconds: 2));
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    myFuture = getNotificaciones();

    _scrollController.addListener(() {
      if ((_scrollController.position.pixels + 500) >=
          _scrollController.position.maxScrollExtent) {
        _fetchMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificacionesService = Provider.of<NotificacionesService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Notificaciones',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary)),
          bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
        ),
        body: FutureBuilder(
            future: myFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppTheme.primary,
                ));
              } else if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: notificacionesService.misNotificaciones.length == 0
                      ? Center(
                          child: NoPosts('No tienes notificaciones',
                              FontAwesomeIcons.bellSlash),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              notificacionesService.misNotificaciones.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin:
                                    EdgeInsets.only(top: 8, left: 8, right: 8),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppTheme.primary),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Preferences.isDarkMode
                                        ? Colors.black54
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              AppTheme.primary.withOpacity(0.1),
                                          offset: Offset(0, 5),
                                          blurRadius: 7)
                                    ]),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, 'otherUser', arguments: {
                                          'nick': notificacionesService
                                              .misNotificaciones[index]
                                              .nickEmisor
                                        });
                                      },
                                      child: CircleAvatar(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: FadeInImage(
                                                            fit: BoxFit.cover,
                                                            placeholder: AssetImage(
                                                                'assets/icon.png'),
                                                            image: NetworkImage(
                                                                notificacionesService
                                                                    .misNotificaciones[
                                                                        index]
                                                                    .fotoDePerfil),
                                                          )))))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        print(notificacionesService
                                            .misNotificaciones[index].tipo);
                                        if (notificacionesService
                                                .misNotificaciones[index]
                                                .tipo ==
                                            3) {
                                          Navigator.pushNamed(
                                              context, 'otherUser', arguments: {
                                            'nick': notificacionesService
                                                .misNotificaciones[index]
                                                .nickEmisor
                                          });
                                        } else {
                                          final postService =
                                              Provider.of<MyPostsService>(
                                                  context,
                                                  listen: false);
                                          await postService.getInfoPost(
                                              notificacionesService
                                                  .misNotificaciones[index]
                                                  .idPubli!);
                                          Navigator.pushNamed(
                                              context, 'onePost', arguments: {
                                            'post': postService.postRT
                                          });
                                        }
                                      },
                                      child: _Message(
                                          notificacion: notificacionesService
                                              .misNotificaciones[index]),
                                    )
                                  ],
                                ));
                          }),
                );
              }
              return Container();
            }));
  }
}

class _Message extends StatelessWidget {
  final Notificaciones notificacion;
  const _Message({
    Key? key,
    required this.notificacion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? message;
    switch (notificacion.tipo) {
      case 1:
        message = ' le ha dado me gusta a tu publicación.';
        break;
      case 2:
        message = ' ha comentado en tu publicación.';
        break;
      case 3:
        message = ' ha comenzado a seguirte.';
        break;
    }
    return Container(
      width: MediaQuery.of(context).size.width - 90,
      child: RichText(
        maxLines: 2,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.5,
            color: Preferences.isDarkMode ? Colors.white : Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
                text: '@' + notificacion.nickEmisor,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: message),
          ],
        ),
      ),
    );
  }
}
