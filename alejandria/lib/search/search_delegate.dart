import 'package:alejandria/models/search_model.dart';
import 'package:alejandria/services/user_service.dart';
import 'package:alejandria/share_preferences/preferences.dart';
import 'package:alejandria/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar usuarios';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: AppTheme.primary),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('result');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
          child: Icon(
        Icons.person,
        color: AppTheme.primary.withOpacity(0.5),
        size: 170,
      ));
    }

    final userProvider = Provider.of<UserService>(context, listen: false);
    userProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
        stream: userProvider.suggestionsStream,
        builder: (_, AsyncSnapshot<List<SearchModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Icon(
              Icons.person,
              color: AppTheme.primary.withOpacity(0.5),
              size: 170,
            ));
          }
          final users = snapshot.data!;

          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, int i) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: _UserItem(users[i])));
        });
  }
}

class _UserItem extends StatelessWidget {
  final SearchModel resp;
  const _UserItem(this.resp);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/icon.png'),
                image: NetworkImage(resp.fotoDePerfil)),
          ),
        ),
        title: Text('@${resp.nick}'),
        onTap: () {
          if (Preferences.userNick == resp.nick) {
            Navigator.pushNamed(context, 'profile');
          } else {
            Navigator.pushNamed(context, 'otherUser',
                arguments: {'nick': resp.nick});
          }
        });
  }
}
