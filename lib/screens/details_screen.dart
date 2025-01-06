import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../graphql/queries.dart';

class DetailsScreen extends StatelessWidget {
  final String stockSymbol;
  final String stockId;
  final String jittaScore;
  final String rank;

  DetailsScreen(
      {required this.stockSymbol,
      required this.stockId,
      required this.jittaScore,
      required this.rank});

  @override
  Widget build(BuildContext context) {
    String formattedDate(date) {
      if (date == "") {
        return "-";
      }
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
    }

    return Scaffold(
      appBar: AppBar(title: Text(stockSymbol)),
      body: SingleChildScrollView(
          child: Query(
        options: QueryOptions(
          document: gql(getStocksDetailQuery),
          variables: {
            'stockId': stockId,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(
              child: Text("Error: ${result.exception.toString()}"),
            );
          }

          final data = result.data?['stock'] as dynamic?;

          if (data == null || data.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          print("data : ${data}");

          return Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Score: ${jittaScore}, Rank: ${rank}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w400,
                    color: Colors.black38,
                    fontSize: 14,
                    height: 1.2,
                  ),
                ),
                Text(
                  "Full name: ${data['name'] ?? "-"}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
                Text(
                  "Short name: ${data['shortname'] ?? "-"}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                Text(
                  "Summary: ${data['summary'] ?? "-"}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                Text(
                  "IPO date: ${formattedDate(data['company']['ipo_date'] ?? "")}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                Text(
                  "Contract Us",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address: ${data['company']["address"]["line1"] ?? "-"}, ${data['company']["address"]["line2"] ?? "-"}, ${data['company']["address"]["zipcode"] ?? "-"}, ${data['company']["address"]["city"] ?? "-"}, ${data['company']["address"]["country"] ?? "-"}",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          "Phone: ${data['company']["phone"] ?? "-"}",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          "Fax: ${data['company']["fax"] ?? "-"}",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          "Website: ${data['company']["link"][0]["url"] ?? "-"}",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ]),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
