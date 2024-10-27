import 'package:equatable/equatable.dart';

class OrderModel extends Equatable{
  final List<String> orderList;
  final double total;


  const OrderModel({
    required this.orderList,
    required this.total});

  static const empty = OrderModel(
      orderList: [],
      total: 0);

  OrderModel copyWith({
    List<String>? orderList,
    double? total
  }){
    return OrderModel (
        orderList: orderList ?? this.orderList,
        total: total ?? this.total,
    );
  }

  bool get isEmpty => this == OrderModel.empty;

  bool get isNotEmpty => this != OrderModel.empty;

  @override
  List<Object?> get props => [orderList, total];

}