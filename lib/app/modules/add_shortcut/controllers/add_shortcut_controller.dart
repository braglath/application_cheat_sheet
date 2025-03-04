import 'package:get/get.dart';

class AddShortcutController extends GetxController {
  var appTitle = ''.obs; // title field

  var appDesc = ''.obs; // description field

  var keyBindingCount = 1.obs; // key binding title +
  var keyCount1 = 1.obs; // first row texts
  var keyCount2 = 1.obs; // second row texts

  // key text fields
  var keyBinding1 = ''.obs;
  var keyBinding2 = ''.obs;
  var keyBinding3 = ''.obs;

  var keyCombination1 = ''.obs;
  var keyCombination2 = ''.obs;
  var keyCombination3 = ''.obs;

  /////////////////////////

  var finalKeyBindings = ''.obs;
  var finalKeyCombination = ''.obs;



  void setAppTitle(String title) => appTitle.value = title;

  void setAppDesc(String desc) => appDesc.value = desc;

  void setKeyBindingCount(int count) {
    keyBindingCount.value = count;
    if (count == 1) {
      // remove second row values
      setKeyCombination1('');
      setKeyCombination2('');
      setKeyCombination3('');
      // reset count so its starts from first field
      keyCount2.value = 1;
    }
  }

  void setKeyCount1(int count, {bool isRemoving = false}) {
    keyCount1.value = count;
    if (isRemoving) {
      if (count == 2) {
        // remove only 3rd field
        keyBinding3.value = '';
      }
      if (count == 1) {
        // remove 2nd and 3rd fields
        keyBinding2.value = '';
        keyBinding3.value = '';
      }
    }
  }

  void setKeyCount2(int count, {bool isRemoving = false}) {
    keyCount2.value = count;
    if (isRemoving) {
      if (count == 2) {
        // remove only 3rd field
        keyCombination3.value = '';
      }
      if (count == 1) {
        // remove 2nd and 3rd fields
        keyCombination2.value = '';
        keyCombination3.value = '';
      }
    }
  }

  void setKeyBinding1(String key) => keyBinding1.value = key.trim();

  void setKeyBinding2(String key) => keyBinding2.value = key.trim();

  void setKeyBinding3(String key) => keyBinding3.value = key.trim();

  void setKeyCombination1(String key) => keyCombination1.value = key.trim();

  void setKeyCombination2(String key) => keyCombination2.value = key.trim();

  void setKeyCombination3(String key) => keyCombination3.value = key.trim();

  void setFinalKeyBinding() => finalKeyBindings.value =
      '${keyBinding1.value.trim()}${_addKeys(keyBinding2.value.trim())}${_addKeys(keyBinding3.value.trim())}'
          .trim();

  void setFinalKeyCombination() => finalKeyCombination.value =
      '${keyCombination1.value.trim()}${_addKeys(keyCombination2.value.trim())}${_addKeys(keyCombination3.value.trim())}'
          .trim();

  String _addKeys(String key) {
    if (key.isEmpty) return '';
    return ' + $key';
  }

}
