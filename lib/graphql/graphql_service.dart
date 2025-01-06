import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static final HttpLink httpLink =
      HttpLink('https://thecollector-staging-l6chkvtlsa-df.a.run.app');

  static GraphQLClient initializeClient() {
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    );
  }

  static ValueNotifier<GraphQLClient> initializeClientNotifier() {
    final client = initializeClient();
    return ValueNotifier(client);
  }
}
