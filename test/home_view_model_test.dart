import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_app/ui/home/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer createContainer() {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  return container;
}

void main() async {
  await dotenv.load(fileName: ".env");
  test(
    'HomeViewModel test',
    () async {
      final container = createContainer();
      HomeState homeState = container.read(homeViewModelProvider);

      expect(homeState.locations, null);

      await container.read(homeViewModelProvider.notifier).search('별내동');

      HomeState homeStateAfterSearch = container.read(homeViewModelProvider);
      if (homeStateAfterSearch.locations!.isSuccess) {
        expect(homeStateAfterSearch.locations!.data!.isNotEmpty, true);
        expect(homeStateAfterSearch.locations!.data![0].title, "별내행정복지센터");
      }
    },
  );
}
