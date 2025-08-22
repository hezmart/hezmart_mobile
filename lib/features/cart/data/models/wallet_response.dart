class CryptoWalletPriceResponse {
  CryptoWalletPriceResponse({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
  });

  final String? id;
  final String? symbol;
  final String? name;
  final String? image;
  final dynamic? currentPrice;
  final dynamic? marketCap;
  final dynamic? marketCapRank;
  final dynamic? fullyDilutedValuation;
  final dynamic? totalVolume;
  final dynamic? high24H;
  final dynamic? low24H;
  final dynamic? priceChange24H;
  final dynamic? priceChangePercentage24H;
  final dynamic? marketCapChange24H;
  final dynamic? marketCapChangePercentage24H;
  final dynamic? circulatingSupply;
  final dynamic? totalSupply;
  final dynamic? maxSupply;
  final dynamic? ath;
  final dynamic? athChangePercentage;
  final DateTime? athDate;
  final dynamic? atl;
  final dynamic? atlChangePercentage;
  final DateTime? atlDate;
  final dynamic roi;
  final DateTime? lastUpdated;

  CryptoWalletPriceResponse copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    dynamic? currentPrice,
    dynamic? marketCap,
    dynamic? marketCapRank,
    dynamic? fullyDilutedValuation,
    dynamic? totalVolume,
    dynamic? high24H,
    dynamic? low24H,
    dynamic? priceChange24H,
    dynamic? priceChangePercentage24H,
    dynamic? marketCapChange24H,
    dynamic? marketCapChangePercentage24H,
    dynamic? circulatingSupply,
    dynamic? totalSupply,
    dynamic? maxSupply,
    dynamic? ath,
    dynamic? athChangePercentage,
    DateTime? athDate,
    dynamic? atl,
    dynamic? atlChangePercentage,
    DateTime? atlDate,
    dynamic? roi,
    DateTime? lastUpdated,
  }) {
    return CryptoWalletPriceResponse(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      fullyDilutedValuation: fullyDilutedValuation ?? this.fullyDilutedValuation,
      totalVolume: totalVolume ?? this.totalVolume,
      high24H: high24H ?? this.high24H,
      low24H: low24H ?? this.low24H,
      priceChange24H: priceChange24H ?? this.priceChange24H,
      priceChangePercentage24H: priceChangePercentage24H ?? this.priceChangePercentage24H,
      marketCapChange24H: marketCapChange24H ?? this.marketCapChange24H,
      marketCapChangePercentage24H: marketCapChangePercentage24H ?? this.marketCapChangePercentage24H,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      maxSupply: maxSupply ?? this.maxSupply,
      ath: ath ?? this.ath,
      athChangePercentage: athChangePercentage ?? this.athChangePercentage,
      athDate: athDate ?? this.athDate,
      atl: atl ?? this.atl,
      atlChangePercentage: atlChangePercentage ?? this.atlChangePercentage,
      atlDate: atlDate ?? this.atlDate,
      roi: roi ?? this.roi,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  factory CryptoWalletPriceResponse.fromJson(Map<String, dynamic> json){
    return CryptoWalletPriceResponse(
      id: json["id"],
      symbol: json["symbol"],
      name: json["name"],
      image: json["image"],
      currentPrice: json["current_price"],
      marketCap: json["market_cap"],
      marketCapRank: json["market_cap_rank"],
      fullyDilutedValuation: json["fully_diluted_valuation"],
      totalVolume: json["total_volume"],
      high24H: json["high_24h"],
      low24H: json["low_24h"],
      priceChange24H: json["price_change_24h"],
      priceChangePercentage24H: json["price_change_percentage_24h"],
      marketCapChange24H: json["market_cap_change_24h"],
      marketCapChangePercentage24H: json["market_cap_change_percentage_24h"],
      circulatingSupply: json["circulating_supply"],
      totalSupply: json["total_supply"],
      maxSupply: json["max_supply"],
      ath: json["ath"],
      athChangePercentage: json["ath_change_percentage"],
      athDate: DateTime.tryParse(json["ath_date"] ?? ""),
      atl: json["atl"],
      atlChangePercentage: json["atl_change_percentage"],
      atlDate: DateTime.tryParse(json["atl_date"] ?? ""),
      roi: json["roi"],
      lastUpdated: DateTime.tryParse(json["last_updated"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "image": image,
    "current_price": currentPrice,
    "market_cap": marketCap,
    "market_cap_rank": marketCapRank,
    "fully_diluted_valuation": fullyDilutedValuation,
    "total_volume": totalVolume,
    "high_24h": high24H,
    "low_24h": low24H,
    "price_change_24h": priceChange24H,
    "price_change_percentage_24h": priceChangePercentage24H,
    "market_cap_change_24h": marketCapChange24H,
    "market_cap_change_percentage_24h": marketCapChangePercentage24H,
    "circulating_supply": circulatingSupply,
    "total_supply": totalSupply,
    "max_supply": maxSupply,
    "ath": ath,
    "ath_change_percentage": athChangePercentage,
    "ath_date": athDate?.toIso8601String(),
    "atl": atl,
    "atl_change_percentage": atlChangePercentage,
    "atl_date": atlDate?.toIso8601String(),
    "roi": roi,
    "last_updated": lastUpdated?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $symbol, $name, $image, $currentPrice, $marketCap, $marketCapRank, $fullyDilutedValuation, $totalVolume, $high24H, $low24H, $priceChange24H, $priceChangePercentage24H, $marketCapChange24H, $marketCapChangePercentage24H, $circulatingSupply, $totalSupply, $maxSupply, $ath, $athChangePercentage, $athDate, $atl, $atlChangePercentage, $atlDate, $roi, $lastUpdated, ";
  }
}
