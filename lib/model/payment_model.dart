class PaymentStatement {
  final double onlineBookingEarnings;
  final double totalEarnings;
  final List<Booking> bookings;

  PaymentStatement({
    required this.onlineBookingEarnings,
    required this.totalEarnings,
    required this.bookings,
  });

  factory PaymentStatement.fromJson(Map<String, dynamic> json) {
    return PaymentStatement(
      onlineBookingEarnings: (json['onlineBookingEarnings'] as num).toDouble(),
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      bookings: (json['bookings'] as List)
          .map((e) => Booking.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'onlineBookingEarnings': onlineBookingEarnings,
      'totalEarnings': totalEarnings,
      'bookings': bookings.map((e) => e.toJson()).toList(),
    };
  }
}

class Booking {
  final String id;
  final int items;
  final double amount;
  final String source;
  final String status;

  Booking({
    required this.id,
    required this.items,
    required this.amount,
    required this.source,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      items: json['items'] as int,
      amount: (json['amount'] as num).toDouble(),
      source: json['source'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items,
      'amount': amount,
      'source': source,
      'status': status,
    };
  }
}
