class DeliveryModel {
  final String orderId;
  final String status;
  final String date;
  final String from;
  final String to;
  
  final HistoryStatusType statusType;

  DeliveryModel({
    required this.orderId,
    required this.status,
    required this.date,
    required this.from,
    required this.to,
    required this.statusType,
  });
}

final deliveries = [
  DeliveryModel(
    orderId: "DT-84920",
    status: "In Transit",
    date: "Arriving Oct 24, by 8:00 PM",
    from: "Seattle Distribution Center",
    to: "123 Main St, Apt 4B",
    statusType: HistoryStatusType.yuklanmoqda
  ),
  DeliveryModel(
    orderId: "DT-73105",
    status: "Delivered",
    date: "Delivered Oct 22, 1:25 PM",
    from: "Portland Hub",
    to: "Office Park, Suite 200",
    statusType: HistoryStatusType.jonatilgan
  ),
  DeliveryModel(
    orderId: "DT-69221",
    status: "Delivered",
    date: "Delivered Oct 18, 10:30 AM",
    from: "Warehouse",
    to: "Customer Address",
    statusType: HistoryStatusType.yetibkelgan
  ),
];

enum HistoryStatusType { yuklanmoqda, jonatilgan, yetibkelgan }
