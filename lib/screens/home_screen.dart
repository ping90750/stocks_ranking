import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stocks_ranking/screens/index.dart';
import '../graphql/queries.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? market;
  String? sector;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jitta Ranking"),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getStocksQuery),
          variables: {
            'filter': {
              'market': market ?? "TH", // ตัวอย่าง filter
              'sectors': sector ?? null
            },
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

          final data = result.data?['jittaRanking']['data'] as List<dynamic>?;
          final dataCountry =
              result.data?['availableCountry'] as List<dynamic>?;

          if (data == null || data.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          // List _lists = [];
          // data.forEach((value) => _lists.add(value["sector"]));

          Set<String> seenSectors = Set();
          List<Map<String, dynamic>> _lists = [];

          data.forEach((value) {
            String sectorId = value["sector"]["id"];

            // Check if sector ID has been added before
            if (!seenSectors.contains(sectorId)) {
              // If not, add to the list and mark the sector as seen
              _lists.add(value["sector"]);
              seenSectors.add(sectorId);
            }
          });

          return Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: market,
                      hint: Text("Select a Country"),
                      items: dataCountry?.map((item) {
                        return DropdownMenuItem<String>(
                          value: item["code"],
                          child: Text(item["flag"] + " " + item["name"] ??
                              ""), // Emoji + ชื่อ
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          market = value;
                        });
                      },
                      style: TextStyle(color: Colors.black), // กำหนดสี Text
                      dropdownColor: Colors.white, // สี Background ของ Dropdown
                      icon: Icon(Icons.arrow_drop_down), // ไอคอน Dropdown
                    ),
                    DropdownButton<String>(
                      value: sector,
                      hint: Text("Select a Sector"),
                      items: _lists?.map((item) {
                        return DropdownMenuItem<String>(
                          value: item["id"],
                          child: Text(item["name"] ?? ""), // Emoji + ชื่อ
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          sector = value;
                        });
                      },
                      style: TextStyle(color: Colors.black), // กำหนดสี Text
                      dropdownColor: Colors.white, // สี Background ของ Dropdown
                      icon: Icon(Icons.arrow_drop_down), // ไอคอน Dropdown
                    ),
                  ],
                )),
                Expanded(
                    child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final stock = data[index];
                    return buildCard(stock);
                  },
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildCard(stock) {
    return GestureDetector(
        onTap: () {
          print("name : ${stock["name"]}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                        stockId: stock["id"],
                        stockSymbol: stock["symbol"],
                        jittaScore: stock["jittaScore"].toString(),
                        rank: stock["rank"].toString(),
                      )));
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black26,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock["symbol"],
                      style: GoogleFonts.prompt(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 18,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      '(${stock["title"]})',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.prompt(
                        fontWeight: FontWeight.w400,
                        color: Colors.black38,
                        fontSize: 14,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      "Score: ${stock['jittaScore']}, Rank: ${stock['rank']}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.prompt(
                        fontWeight: FontWeight.w400,
                        color: Colors.black38,
                        fontSize: 14,
                        height: 1.2,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                stock["latestPrice"].toString(),
                style: GoogleFonts.prompt(
                  fontWeight: FontWeight.w400,
                  color: Colors.green,
                  fontSize: 18,
                  height: 1.2,
                ),
              )
            ],
          ),
        ));
  }
}


// ListTile(
//                       title: Text(stock['nativeName'] ?? stock['name']),
//                       subtitle: Text(
//                           "Score: ${stock['jittaScore']}, Rank: ${stock['rank']}"),
//                       trailing: Text("Updated: ${stock['updatedAt']}"),
//                     )