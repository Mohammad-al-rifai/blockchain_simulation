import 'dart:convert';

import 'blocks.dart';
import 'transaction.dart';
import 'package:crypto/crypto.dart' as crypto;
import "package:hex/hex.dart";

class Blockchain {
  final List<Block> chain;
  final List<Transaction> _currentTransactions;

  Blockchain()
      : chain = [],
        _currentTransactions = [] {
    // create genesis block
    newBlock(100, "1");
  }

  Block newBlock(int proof, String? previousHash) {
    previousHash ??= hash(chain.last);

    var block = Block(
      chain.length,
      DateTime.now().millisecondsSinceEpoch,
      _currentTransactions,
      proof,
      previousHash,
    );
    _currentTransactions.clear(); // = [] ?
    chain.add(block);
    return block;
  }

  int newTransaction(String sender, String recipient, double amount) {
    _currentTransactions.add(
      Transaction(
        sender: sender,
        recipient: recipient,
        amount: amount,
      ),
    );
    return lastBlock.index + 1;
  }

  Block get lastBlock {
    return chain.last;
  }

  String hash(Block block) {
    var blockStr = json.encode(block.toJson());
    var bytes = utf8.encode(blockStr);
    var converted = crypto.sha256.convert(bytes).bytes;
    return HEX.encode(converted);
  }

  int proofOfWork(int lastProof) {
    var proof = 0;
    while (!validProof(lastProof, proof)) {
      proof++;
    }

    return proof;
  }

  bool validProof(int lastProof, int proof) {
    var guess = utf8.encode("$lastProof$proof");
    var guessHash = crypto.sha256.convert(guess).bytes;
    return HEX.encode(guessHash).substring(0, 4) == "0000";
  }
}
