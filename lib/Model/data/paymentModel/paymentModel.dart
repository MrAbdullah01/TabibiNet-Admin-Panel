class PaymentModel {
  final String id;
  final String doctorName;
  final String email;
  final String image;
  final String status;
  final String fees;
  final String userUid;
  final String applyDate;
  final String feesId;

  PaymentModel({required this.feesId,
    required this.applyDate,
    required this.id,
    required this.doctorName,
    required this.email,
    required this.image,
    required this.status,
    required this.fees,
    required this.userUid,
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
      applyDate: map['applyDate'] ?? "",
      feesId: map['feesId'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, doctorName: $doctorName, email: $email, image: $status,status: $fees: $fees, applyDate: $applyDate,feesId: $feesId,'

        '}';
  }
}