class PaymentModel {
  final String id;
  final String doctorName;
  final String email;
  final String image;
  final String status;
  final String fees;
  final String userUid;
  final String appointmentDate;
  final String feesId;
  final String feesType;

  PaymentModel({required this.feesId,
    required this.appointmentDate,
    required this.id,
    required this.doctorName,
    required this.email,
    required this.image,
    required this.status,
    required this.fees,
    required this.userUid,
    required this.feesType,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map,String documentId) {
    return PaymentModel(
      id: documentId,
      doctorName: map['doctorName'] ?? "",
      email: map['email'] ?? "",
      status: map['status'] ?? "",
      fees: map['fees'] ?? "",
      image: map['image'] ?? "",
      userUid: map['userUID'] ?? "",
      appointmentDate: map['appointmentDate'] ?? "",
      feesId: map['feesId'] ?? "",
      feesType: map['feesType'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id,feesType $feesType, doctorName: $doctorName, email: $email, image: $status,status: $fees: $fees, appointmentDate: $appointmentDate,feesId: $feesId,';
  }
}