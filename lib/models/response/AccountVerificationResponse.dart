

import 'FinEdgeBankVerification.dart';

class AccountVerificationResponse {
  FinedgeBankVerification? finedgeBankVerification;
  OtherBankVerification? otherBankVerification;
  AccountVerificationResponse(
      {this.finedgeBankVerification, this.otherBankVerification});
}
