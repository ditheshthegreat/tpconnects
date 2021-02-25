import 'package:sembast/sembast.dart';
import 'package:tp_connects/businees_logic/model/user_details.dart';

import 'app_database.dart';

class UserDao {
  static const String USERS_STORE_NAME = 'user';

  final _userStore = intMapStoreFactory.store(USERS_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<int> insert(UserDetailsModel user) async {
    return await _userStore.add(await _db, user.toJson());
  }

  Future userUpdate(UserDetailsModel user) async {
    final finder = Finder(filter: Filter.equals("profileId", user.profileId));
    await _userStore.update(
      await _db,
      user.toJson(),
      finder: finder,
    );
  }

  Future deleteDatabase() async {
    await _userStore.delete(await _db);
  }

  Future delete(UserDetailsModel user) async {
    final finder = Finder(filter: Filter.byKey(user.profileId));
    await _userStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<UserDetailsModel> getUser() async {
    final finder = Finder(sortOrders: [
      SortOrder('profileId'),
    ]);

    final recordSnapshots = await _userStore.find(
      await _db,
      finder: finder,
    );

    if (recordSnapshots.isNotEmpty)
      return recordSnapshots.map((snapshot) {
        final user = UserDetailsModel.fromJson(snapshot.value);

        return user;
      }).toList()[0];
    else
      return null;
  }
}
