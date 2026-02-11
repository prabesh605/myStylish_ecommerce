import 'package:flutter/material.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class KhaltiPage extends StatefulWidget {
  const KhaltiPage({super.key, required this.pidx});
  final String pidx;

  @override
  State<KhaltiPage> createState() => _KhaltiPageState();
}

class _KhaltiPageState extends State<KhaltiPage> {
  late final Future<Khalti> khalti;
  PaymentResult? paymentResult;
  String? pidxNumber;
  String? transactionNumber;
  String? totalAmount;
  String? status;

  @override
  void initState() {
    super.initState();
    final payConfig = KhaltiPayConfig(
      publicKey: '5c8cdd2f88be406d9f32fc7b51c7cb71',
      pidx: widget.pidx,
      environment: Environment.test,
    );
    khalti = Khalti.init(
      enableDebugging: true,
      payConfig: payConfig,
      onPaymentResult: (paymentResult, khalti) {
        setState(() {
          pidxNumber = paymentResult.payload?.pidx;
          transactionNumber = paymentResult.payload?.transactionId;
        });
        print(paymentResult.payload?.status);
        print(paymentResult.payload?.pidx);
        print(paymentResult.payload?.totalAmount);
        print(paymentResult.payload?.transactionId);
      },

      onMessage:
          (
            khalti, {
            description,
            statusCode,
            event,
            needsPaymentConfirmation,
          }) async {
            debugPrint(
              'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
            );
            khalti.close(context);
          },
      onReturn: () => {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: khalti,
            builder: (context, snapshot) {
              final khaltiSnapshot = snapshot.data;
              if (khaltiSnapshot == null) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      khaltiSnapshot.open(context);
                    },
                    child: Text('Pay with Khalti'),
                  ),

                  paymentResult != null
                      ? Column(
                          children: [
                            Text("${pidxNumber}"),
                            Text("${transactionNumber}"),
                            // Text("${paymentResult?.payload?.status}"),
                            // Text("${paymentResult?.payload?.pidx}"),
                            // Text("${paymentResult?.payload?.totalAmount}"),
                            // Text("${paymentResult?.payload?.transactionId}"),
                          ],
                        )
                      : Container(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
