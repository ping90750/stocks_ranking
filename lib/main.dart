import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stocks_ranking/screens/home_screen.dart';
import 'graphql/graphql_service.dart';
import 'graphql/queries.dart';
import 'package:stocks_ranking/screens/index.dart';

void main() async {
  // Initialize Hive for GraphQL caching
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GraphQLClient>(
      valueListenable: GraphQLService.initializeClientNotifier(),
      builder: (context, client, child) {
        return GraphQLProvider(
          client: ValueNotifier(client),
          child: MaterialApp(
            title: 'Stocks Ranking',
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}
