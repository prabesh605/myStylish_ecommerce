import 'package:flutter/material.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class KhaltiPage extends StatefulWidget {
  const KhaltiPage({super.key});

  @override
  State<KhaltiPage> createState() => _KhaltiPageState();
}

class _KhaltiPageState extends State<KhaltiPage> {
  late final Future<Khalti> khalti;
  String pidx = 'AM5LHYWowEtcApv9tDiqKd';
  PaymentResult? paymentResult;
  @override
  void initState() {
    super.initState();
    final payConfig = KhaltiPayConfig(
      publicKey: '5c8cdd2f88be406d9f32fc7b51c7cb71',
      pidx: pidx,
      environment: Environment.prod,
    );
    khalti = Khalti.init(
      enableDebugging: true,
      payConfig: payConfig,
      onPaymentResult: (paymentResult, khalti) {
        debugPrint(paymentResult.toString());
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
          },
      onReturn: () => debugPrint('Successfully redirected to return url'),
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
