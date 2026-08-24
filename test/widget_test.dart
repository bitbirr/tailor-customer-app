import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_customer_app/app/app.dart';

void main() {
  testWidgets('shows the customer workshop home', (tester) async {
    await tester.pumpWidget(TailorCustomerApp());
    await tester.pumpAndSettle();
    expect(find.text('Customers'), findsOneWidget);
    expect(find.text('Add customer'), findsOneWidget);
  });
}
