import 'package:flutter/material.dart';
import 'package:mobile/api/dashboard_api.dart';
import 'package:mobile/classes/login_state.dart';
import 'package:mobile/pages/authorized/dashboard/recent_transactions/transaction_card.dart';
import 'package:mobile/widgets/loading_indicator.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions(
      {Key? key,
      required this.hideBottomNavbar,
      required this.loginState,
      required this.selectedAcc})
      : super(key: key);

  final void Function(bool) hideBottomNavbar;
  final LoginState loginState;
  final Map<dynamic, dynamic> selectedAcc;

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  double position = 0.0;

  double sensitivityFactor = 20.0;
  late final Future<List<Map<String, dynamic>>> transactions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactions = getRecentTransactions(
        widget.loginState, widget.selectedAcc['listNumber']);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
        maxChildSize: 0.65,
        minChildSize: 0.4,
        initialChildSize: 0.4,
        expand: true,
        builder: (context, _controller) {
          return Container(
            decoration: const BoxDecoration(
                color: Color(0xff029aa8),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                )),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification.metrics.pixels - position >=
                      sensitivityFactor) {
                    position = scrollNotification.metrics.pixels;
                    widget.hideBottomNavbar(true);
                  }
                  if (position - scrollNotification.metrics.pixels >=
                      sensitivityFactor) {
                    position = scrollNotification.metrics.pixels;
                    widget.hideBottomNavbar(false);
                  }
                  return true;
                },
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: transactions,
                  builder: (context, snap) {
                  if (snap.hasData) {
                    var data = snap.data;
                    return ListView.builder(
                        controller: _controller,
                        itemCount: data!.length + 2,
                        itemBuilder: (ctx, _index) {
                          if (_index == 0) {
                            return Center(
                              child: Container(
                                width: 125,
                                height: 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xffd9d9d9)),
                              ),
                            );
                          }
                          if (_index == 1) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Text(
                                "Recent transactions",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Signika",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          _index -= 2;
                          getAmount(data){
                            // double amount = 0;
                            // if(data['debit'] !=null) amount = amount - double.parse(data['debit']);
                            // if(data['credit'] !=null) amount = amount + double.parse(data['credit']);
                            var amount = "";
                            if(data['debit'] !=null && data['debit'].isNotEmpty){
                              amount = '- ${data["debit"]}';
                            }
                            if(data['credit'] !=null && data['credit'].isNotEmpty){
                              amount = '+ ${data["credit"]}';
                            }
                            return amount;
                          }

                          getType(data){
                            if(data['debit'] !=null && data['debit'].isNotEmpty) return 'Debit';
                            if(data['credit'] !=null && data['credit'].isNotEmpty) return 'Credit';
                            return "";
                          }

                          return TransactionCard(
                            description: data[_index]['description'],
                            amount: getAmount(data[_index]),
                            date: data[_index]['date'],
                            type: getType(data[_index]),
                          );
                        });
                  }
                  return const Center(
                      child: DottedCircularProgressIndicatorFb(numDots: 10));
                }),
              ),
            ),
          );
        });
  }
}
