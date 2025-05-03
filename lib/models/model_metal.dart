import 'dart:convert';
import 'package:hive/hive.dart';

part 'model_metal.g.dart';

@HiveType(typeId: 0) // First type in the app
class ModelMetal {
  @HiveField(0)
  final int timestamp;
  @HiveField(1)
  String metal;
  @HiveField(2)
  final String currency;
  @HiveField(3)
  final String exchange;
  @HiveField(4)
  final String symbol;
  @HiveField(5)
  final int openTime;
  @HiveField(6)
  final double price;
  @HiveField(7)
  final double ch;
  @HiveField(8)
  final double ask;
  @HiveField(9)
  final double bid;
  @HiveField(10)
  final double priceGram24K;
  @HiveField(11)
  final double priceGram22K;
  @HiveField(12)
  final double priceGram21K;
  @HiveField(13)
  final double priceGram20K;
  @HiveField(14)
  final double priceGram18K;
  @HiveField(15)
  final double priceGram16K;
  @HiveField(16)
  final double priceGram14K;
  @HiveField(17)
  final double priceGram10K;
  @HiveField(18)
  int recordID;
  @HiveField(19)
  String responseMsg;

  ModelMetal({
    this.timestamp = 0,
    this.metal = 'XAU',
    this.currency = 'EGP',
    this.exchange = 'FOREXCOM',
    this.symbol = 'FOREXCOM:XAUUSD',
    this.openTime = 0,
    this.price = 0,
    this.ch = 0,
    this.ask = 0,
    this.bid = 0,
    this.priceGram24K = 0,
    this.priceGram22K = 0,
    this.priceGram21K = 0,
    this.priceGram20K = 0,
    this.priceGram18K = 0,
    this.priceGram16K = 0,
    this.priceGram14K = 0,
    this.priceGram10K = 0,
    this.recordID = 0,
    this.responseMsg = '',
  });

  factory ModelMetal.fromRawJson(String str) =>
      ModelMetal.fromJson(json.decode(str));

  factory ModelMetal.fromJson(Map<String, dynamic> json) => ModelMetal(
    timestamp: json["timestamp"],
    metal: json["metal"],
    currency: json["currency"],
    exchange: json["exchange"],
    symbol: json["symbol"],
    openTime: json["open_time"],
    price: json["price"]?.toDouble(),
    ch: json["ch"]?.toDouble(),
    ask: json["ask"]?.toDouble(),
    bid: json["bid"]?.toDouble(),
    priceGram24K: json["price_gram_24k"]?.toDouble(),
    priceGram22K: json["price_gram_22k"]?.toDouble(),
    priceGram21K: json["price_gram_21k"]?.toDouble(),
    priceGram20K: json["price_gram_20k"]?.toDouble(),
    priceGram18K: json["price_gram_18k"]?.toDouble(),
    priceGram16K: json["price_gram_16k"]?.toDouble(),
    priceGram14K: json["price_gram_14k"]?.toDouble(),
    priceGram10K: json["price_gram_10k"]?.toDouble(),
  );
}
