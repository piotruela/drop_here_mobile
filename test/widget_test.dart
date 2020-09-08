

import 'package:drop_here_mobile/common/ui/widgets/main_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('FormPage has icons and title', (WidgetTester tester) async {
    await tester.pumpWidget(MainWidget());

    expect(find.text('drop.here'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    expect(find.byType(SvgPicture), findsOneWidget);
  });
}
