import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:seeds/models/models.dart';

class HttpMockResponse {
  bool isEnabled = false;

  final members = [
    MemberModel(
      account: "sevenflash42",
      nickname: "Igor Berlenko",
      image: "",
    ),
  ];

  final transactions = [
    TransactionModel("join.seeds", "sevenflash42", "15.0000 SEEDS", ""),
    TransactionModel("sevenflash42", "testingseeds", "5.0000 SEEDS", ""),
  ];

  final balance = BalanceModel("10.0000 SEEDS");

  final voice = VoiceModel(77);

  final proposals = [
    ProposalModel(
      id: 1,
      creator: "creator",
      recipient: "recipient",
      quantity: "1000000.0000 SEEDS",
      staked: "1.0000 SEEDS",
      executed: 1,
      total: 1000,
      favour: 800,
      against: 200,
      title: "title",
      summary: "summary",
      description: "description",
      image: "https://seeds-service.s3.amazonaws.com/development/a26a6d72-dd50-4c40-8504-00930b97961b/5bc29df1-1f72-4868-b900-3d177678ef77-1920.jpg",
      url: "https://ipfs.globalupload.io/QmVGQyjnRM77hAK4SfaVTVu45Lb7QoFpJRLeoYwA1XijyS",
      status: "status",
      stage: "stage",
      fund: "fund",
      creationDate: 1000,
    ),
  ];

  HttpMockResponse() {
    if (DotEnv().env['DEBUG_MOCK_HTTP'] != "") {
      isEnabled = true;
    }
  }
}
