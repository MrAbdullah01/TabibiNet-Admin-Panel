import 'dart:developer';

class PaymentModel {
  final String id;
  final String doctorName;
  final String patientName;
  final String patientAge;
  final String doctorLocation;
  final String email;
  final String image;
  final String status;
  final String fees;
  final String userUid;
  final String appointmentDate;
  final String feesId;
  final String feesType;
  final String patientProblem;
  final String availabilityFrom;
  final String availabilityTo;
  final String country;
  final String experience;
  final String rating;
  final String reviews;
  final String speciality;
  final String userType;
  final String membership;
  final String patientPhone;
  final String patientEmail;
  final String docPhoneNumber;

  PaymentModel( {
    required this.availabilityFrom,
    required this.patientEmail,
    required this.availabilityTo,
    required this.country,
    required this.patientAge,
    required this.experience,
    required this.rating,
    required this.reviews,
    required this.speciality,
    required this.userType,
    required this.feesId,
    required this.appointmentDate,
    required this.id,
    required this.doctorName,
    required this.doctorLocation,
    required this.patientName,
    required this.email,
    required this.image,
    required this.status,
    required this.fees,
    required this.userUid,
    required this.feesType,
    required this.patientProblem,
    required this.membership,
    required this.patientPhone,
    required this.docPhoneNumber,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map,String documentId) {
    // log('map is:: $map');
    return PaymentModel(
      id: documentId,
      doctorName: map['doctorName'] ?? "",
      email: map['doctorEmail'] ?? "",
      patientEmail: map['patientEmail'] ?? "",
      status: map['status'] ?? "",
      fees: map['fees'] ?? "",
      image: map['image'] ?? "",
      userUid: map['userUID'] ?? "",
      appointmentDate: map['appointmentDate'] ?? "",
      feesId: map['feesId'] ?? "",
      feesType: map['feesType'] ?? "",
      patientName: map['name'] ?? "",
      doctorLocation: map['doctorLocation'] ?? "",
      patientProblem: map['patientProblem'] ?? "",
      patientAge: map['patientAge'] ?? "",
      availabilityFrom: map['availabilityFrom'] ?? "",
      availabilityTo: map['availabilityTo']??"",
      country: map['country']??"",
      membership: map['membership']??"",
      experience: map['experience']??"",
      docPhoneNumber:map ['phone']??"",
      patientPhone:map ['patientPhone']??"",
      rating: map['rating']??"",
      reviews: map['reviews']??"",
      speciality:map[ 'speciality']??"",
      userType: map['userType']??"",
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id,feesType $feesType, doctorName: $doctorName, email: $email, image: $image ,status:$status,'
        'status: $fees: $fees, appointmentDate: $appointmentDate,feesId: $feesId,patientName: $patientName,patientProblem: $patientProblem,'
        'availabilityFrom: $availabilityFrom, availabilityTo: $availabilityTo,country: $country,docPhoneNumber: $docPhoneNumber,patientPhone: $patientPhone'
        'experience:$experience,membership: $membership,patientAge: $patientAge,patientEmail: $patientEmail';
  }
}