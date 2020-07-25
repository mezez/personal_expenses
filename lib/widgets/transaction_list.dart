import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;
  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text('No transactions added yet!',
                    style: Theme.of(context).textTheme.title),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView(
            children: userTransactions
                .map((tx) => TransactionItem(
                    // key: UniqueKey(),
                    key: ValueKey(tx.id),
                    userTransaction: tx,
                    deleteTransaction: deleteTransaction))
                .toList(),
          );
  }
}

// import 'package:flutter/material.dart';

// import '../models/transaction.dart';
// import './transaction_item.dart';

// class TransactionList extends StatelessWidget {
//   final List<Transaction> userTransactions;
//   final Function deleteTransaction;
//   TransactionList(this.userTransactions, this.deleteTransaction);

//   @override
//   Widget build(BuildContext context) {
//     return userTransactions.isEmpty
//         ? LayoutBuilder(builder: (ctx, constraints) {
//             return Column(
//               children: <Widget>[
//                 Text('No transactions added yet!',
//                     style: Theme.of(context).textTheme.title),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                     height: constraints.maxHeight * 0.6,
//                     child: Image.asset(
//                       'assets/images/waiting.png',
//                       fit: BoxFit.cover,
//                     ))
//               ],
//             );
//           })
//         : ListView.builder(
//             //a column with a single child scroll view
//             itemBuilder: (ctx, index) {
//               // return Card(
//               //   child: Row(
//               //     children: <Widget>[
//               //       Container(
//               //         margin:
//               //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               //         decoration: BoxDecoration(
//               //             border: Border.all(
//               //                 color: Theme.of(context).primaryColor,
//               //                 // color: Colors.purple,
//               //                 width: 2)),
//               //         padding: EdgeInsets.all(10),
//               //         child: Text(
//               //           '\$${userTransactions[index].amount.toStringAsFixed(2)}', //dollar sign by default is reserved in dart, so to use the default doller sign,you have to excape it
//               //           //toStringAsFixed is for fractions/decimal
//               //           style: TextStyle(
//               //             fontWeight: FontWeight.bold,
//               //             fontSize: 20,
//               //             color: Theme.of(context).primaryColor,
//               //             // color: Colors.purple
//               //           ),
//               //         ),
//               //       ),
//               //       Column(
//               //         crossAxisAlignment: CrossAxisAlignment.start,
//               //         children: <Widget>[
//               //           Text(userTransactions[index].title,
//               //               style: Theme.of(context).textTheme.title
//               //               // TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               //               ),
//               //           Text(
//               //             // DateFormat('yyyy-MM-dd').format(tx.date),
//               //             DateFormat.yMMMd()
//               //                 .format(userTransactions[index].date),
//               //             style: TextStyle(color: Colors.grey),
//               //           ),
//               //         ],
//               //       )
//               //     ],
//               //   ),
//               // );
//               return TransactionItem(
//                   userTransaction: userTransactions[index],
//                   deleteTransaction: deleteTransaction);
//             },
//             itemCount: userTransactions.length,
//           );
//   }
// }
