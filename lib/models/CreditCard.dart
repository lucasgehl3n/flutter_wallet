import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CreditCard {
  String id = "";
  String description = "";
  DateTime? expirationDate;
  String securityCode = "";
  String number = "";

  CreditCard.newCard();
  CreditCard(this.description, this.expirationDate, this.securityCode,
      this.number, this.id);

  String expirationDateFormat() {
    if (expirationDate != null) {
      return DateFormat("MM/yy").format(expirationDate!).toString();
    } else {
      return DateFormat("MM/yy").format(DateTime.now()).toString();
    }
  }

  CreditCard.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    description = json['description'];

    if (json['expirationDate'] != null && json['expirationDate'] != "") {
      expirationDate = DateTime.parse(json['expirationDate']);
    }

    securityCode = json['securityCode'] ?? "";
    number = json['number'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'id': id != "" ? id : Uuid().v1(),
        'description': description,
        'expirationDate': expirationDate.toString(),
        'securityCode': securityCode,
        'number': number
      };
}
