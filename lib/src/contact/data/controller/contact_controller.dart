import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wond3rcard/src/contact/data/model/suggested_user.dart';
import 'package:wond3rcard/src/contact/data/repository/contact_repository.dart';
import 'package:wond3rcard/src/contact/views/pages/contacts_page.dart';

final addContactControllerProvider =
    StateNotifierProvider<AddContactController, AsyncValue<void>>(
  (ref) => AddContactController(ref.read(contactRepositoryProvider)),
);

class AddContactController extends StateNotifier<AsyncValue<void>> {
  final ContactRepository _repository;

  AddContactController(this._repository) : super(const AsyncValue.data(null));

  Future<void> addContact(
      {required String userId, required String email}) async {
    state = const AsyncValue.loading();
    try {
      await _repository.addContact(userId: userId, contactEmail: email);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final contactsControllerProvider =
    FutureProvider.family<List<Contact>, String>((ref, userId) async {
  final repo = ref.read(contactRepositoryProvider); // your repository provider
  return await repo.getContacts(userId);
});

// final connectUserProvider = StateNotifierProvider<ConnectUserController, AsyncValue<Map<String, dynamic>>>(
//   (ref) => ConnectUserController(ref.read(contactRepositoryProvider)),
// );

// class ConnectUserController extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
//   final ContactRepository _repository;

//   ConnectUserController(this._repository) : super(const AsyncValue.data({}));

//   Future<void> connect(String contactUserId) async {
//     state = const AsyncValue.loading();
//     try {
//       final response = await _repository.connectWithContact(contactUserId);
//       state = AsyncValue.data(response);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }
// }

final connectUserProvider =
    StateNotifierProvider<ConnectUserController, Map<String, bool>>(
  (ref) => ConnectUserController(ref.read(contactRepositoryProvider)),
);

class ConnectUserController extends StateNotifier<Map<String, bool>> {
  final ContactRepository _repository;

  ConnectUserController(this._repository) : super({});

  Future<void> connect(String userId) async {
    // Set this user's loading state to true
    state = {...state, userId: true};
    try {
      await _repository.connectWithContact(userId);
    } catch (e) {
      // Handle error if needed
    } finally {
      // Reset loading state for this user
      state = {...state, userId: false};
    }
  }

  bool isLoading(String userId) => state[userId] ?? false;

  bool loading(String uid) => state[uid] ?? false;

  Future<void> disconnect(String uid) async {
    state = {...state, uid: true};
    try {
      await _repository.removeContact(uid);
    } catch (e) {
      print("Failed to disconnect: $e");
    }
    state = {...state, uid: false};
  }
}

final contactAndconnectUserProvider =
    StateNotifierProvider<ContactAndConnectUserController, Map<String, bool>>(
  (ref) => ContactAndConnectUserController(
    contactRepo: ref.read(contactRepositoryProvider),
  ),
);

class ContactAndConnectUserController extends StateNotifier<Map<String, bool>> {
  final ContactRepository contactRepo;

  ContactAndConnectUserController({required this.contactRepo}) : super({});

  Future<void> connect(String userId, String email, String uId) async {
    // Set loading state for this user
    state = {...state, userId: true};
    try {
      await contactRepo.addContact(userId: uId, contactEmail: email);
      // Step 2: Connect to user
      await contactRepo.connectWithContact(userId);
    } catch (e) {
      print('this is the connection error $e');
    } finally {
      // Reset loading state
      state = {...state, userId: false};
    }
  }

  bool isLoading(String userId) => state[userId] ?? false;
}

final connectionListProvider = StateNotifierProvider<ConnectionController,
    AsyncValue<List<Map<String, dynamic>>>>(
  (ref) => ConnectionController(ref.read(contactRepositoryProvider)),
);

class ConnectionController
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final ContactRepository _repository;

  ConnectionController(this._repository) : super(const AsyncValue.loading()) {
    getConnections();
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    state = AsyncValue.data(state.value ?? []);
  }

  Future<void> getConnections() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getConnections();
      state = AsyncValue.data(data);
    } catch (e, st) {
      print('this is the get connection error $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeConnection(String userId) async {
    try {
      await _repository.removeConnection(userId);
      await getConnections(); // Refresh the list
    } catch (e) {
      print("Error removing connection: $e");
    }
  }
}

final suggestionListProvider = StateNotifierProvider<SuggestionController,
    AsyncValue<List<SuggestedUser>>>(
  (ref) => SuggestionController(ref.read(contactRepositoryProvider)),
);

class SuggestionController
    extends StateNotifier<AsyncValue<List<SuggestedUser>>> {
  final ContactRepository _repo;

  SuggestionController(this._repo) : super(const AsyncValue.loading()) {
    fetchSuggestions();
  }

  Future<void> fetchSuggestions() async {
    state = const AsyncValue.loading();
    try {
      final suggestions = await _repo.getConnectionSuggestions();
      suggestions.sort((a, b) {
        if (a.companyName.isNotEmpty && b.companyName.isEmpty) return -1;
        if (a.companyName.isEmpty && b.companyName.isNotEmpty) return 1;
        return 0;
      });

      state = AsyncValue.data(suggestions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
