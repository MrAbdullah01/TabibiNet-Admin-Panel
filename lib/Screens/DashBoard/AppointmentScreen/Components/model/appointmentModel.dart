class AppointmentDetails {
  final String id;
  final String patientName;
  final String patientEmail;
  final String patientPhone;
  final String doctorFee;
  final String appointmentTime;
  final String doctorName;
  final String doctorLocation;
  final String checkUpType;

  AppointmentDetails({required this.checkUpType,
    required this.doctorName,required this.doctorLocation,required this.id, required this.patientName, required this.patientEmail, required this.patientPhone, required this.doctorFee, required this.appointmentTime,
  });


  factory AppointmentDetails.fromMap(Map<String, dynamic> data) {
    return AppointmentDetails(
      id: data['id'] ?? '',
      patientName: data['patientName'] ?? '',
      patientEmail: data['patientEmail'] ?? '',
      patientPhone: data['phone'] ?? '',
      doctorFee: data['fees'] ?? '',
      appointmentTime: data['appointmentTime'] ?? '',
      doctorName: data['doctorName'] ?? '',
      doctorLocation: data['doctorLocation'] ?? '',
      checkUpType: data['feesType'] ?? '',
    );
  }
}