import 'package:blockchain_simulation/logic/blockchain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logic/blocks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController dataController = TextEditingController();

  Blockchain blockchain = Blockchain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blockchain Simulation ** محمد رضا الرفاعي * هندسة النطم',
          style: TextStyle(fontSize: 12.0),
        ),
      ),
      body: getBody(),
      floatingActionButton: getFAB(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const Text("Blockchain  محمد الرفاعي "),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildBlockWidget(blockchain.chain[0]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Icon(
                    Icons.arrow_downward,
                    size: 30.0,
                    color: Colors.grey,
                  ),
                ),
              );
            },
            itemCount: 3,
          )
        ],
      ),
    );
  }

  Widget buildBlockWidget(Block block) {
    return Container(
      margin: const EdgeInsetsDirectional.all(8.0),
      padding: const EdgeInsetsDirectional.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: dataController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                gapPadding: 12.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 12.0,
              ),
              contentPadding: EdgeInsetsDirectional.zero,
              label: Text(
                'DATA',
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
              prefixIcon: const Icon(
                Icons.document_scanner,
                color: Colors.grey,
              ),
              hintText: 'DATA',
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text('PREVIOUS Hash'),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  block.prevHash,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text('Hash'),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsetsDirectional.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12.0),
                    color: Colors.lightGreenAccent.shade200.withOpacity(.4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade900,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                      ),
                      BoxShadow(
                        color: Colors.lightGreenAccent.shade700,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                      ),
                      BoxShadow(
                        color: Colors.green.shade900,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                  child: Text(
                    blockchain.hash(block),
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              block.prevHash == "1"
                  ? const Text(
                      'GENESIS BLOCK',
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
                    )
                  : const Text(
                      'Block #1',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  block.timestamp.toString(),
                  style: const TextStyle(
                    fontSize: 8.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsetsDirectional.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(8.0),
                  color: Colors.grey.shade300,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Text(block.proof.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getFAB() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Enter Your Data Block',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            content: TextFormField(
              controller: dataController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  gapPadding: 12.0,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 12.0,
                ),
                contentPadding: EdgeInsetsDirectional.zero,
                label: Text(
                  'DATA',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.document_scanner,
                  color: Colors.grey,
                ),
                hintText: 'DATA',
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Send'),
              ),
            ],
          ),
        );
      },
      child: Icon(
        CupertinoIcons.add,
        color: Colors.blueAccent.shade700,
      ),
    );
  }
}
