import 'package:hayat_eg/features/data/model/medicine/medicine_unit.dart';

class MedicineDonationRequest {
  double? quantity;
  int? cityId;
  String? communicationMethod;
  String? description;
  String? state;
  String? title;
  int? medicineUnitId;
  String? telegramLink;
  String? whatsappLink;
  int? medicineId;
  String? medicineExpirationDate;

  MedicineDonationRequest(
      {this.quantity,
      this.cityId,
      this.communicationMethod,
      this.description,
      this.state,
      this.title,
      this.medicineUnitId,
      this.telegramLink,
      this.whatsappLink,
      this.medicineId,
      this.medicineExpirationDate});

  MedicineDonationRequest.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    cityId = json['city_id'];
    communicationMethod = json['communication_method'];
    description = json['description'];
    state = json['state'];
    title = json['title'];
    medicineUnitId = json['medicine_unit_id'];
    telegramLink = json['telegram_link'];
    whatsappLink = json['whatsapp_link'];
    medicineId = json['medicine_id'];
    medicineExpirationDate = json['medicine_expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['city_id'] = this.cityId;
    data['communication_method'] = this.communicationMethod;
    data['description'] = this.description;
    data['state'] = this.state;
    data['title'] = this.title;
    data['medicine_unit_id'] = this.medicineUnitId;
    data['telegram_link'] = this.telegramLink;
    data['whatsapp_link'] = this.whatsappLink;
    data['medicine_id'] = this.medicineId;
    data['medicine_expiration_date'] = this.medicineExpirationDate;
    return data;
  }
}
