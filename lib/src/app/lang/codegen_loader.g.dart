// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en_US = {
  "common": {
    "input_dialog": {
      "buttons": {
        "close": {
          "title": "Close"
        },
        "submit": {
          "title": "Submit"
        },
        "save": {
          "title": "Save"
        }
      }
    }
  },
  "dashboard": {
    "title": "Dashboard"
  },
  "donations": {
    "title": "Donations",
    "donation_alerts": {
      "title": "Donation Alerts",
      "buttons": {
        "add": "Add",
        "remove": "Remove"
      },
      "add_dialog": {
        "last_messages": {
          "title": "Last messages widget",
          "insert_link": "Insert link"
        }
      }
    }
  },
  "streams": {
    "title": "Streams"
  },
  "authentication": {
    "title": "Authentication"
  },
  "accounts": {
    "title": "Accounts"
  },
  "chatbot": {
    "title": "Chatbot"
  },
  "stream_widgets": {
    "title": "Stream Widgets"
  },
  "settings": {
    "title": "Settings"
  }
};
static const Map<String,dynamic> _ru_RU = {
  "common": {
    "input_dialog": {
      "buttons": {
        "close": {
          "title": "Закрыть"
        },
        "submit": {
          "title": "Подвердить"
        },
        "save": {
          "title": "Сохранить"
        }
      }
    }
  },
  "dashboard": {
    "title": "Дашборд"
  },
  "donations": {
    "title": "Донаты",
    "donation_alerts": {
      "title": "Donation Alerts",
      "buttons": {
        "add": "Добавить",
        "remove": "Убрать"
      },
      "add_dialog": {
        "last_messages": {
          "title": "Виджет последних сообщений",
          "insert_link": "Вставьте ссылку"
        }
      }
    }
  },
  "streams": {
    "title": "Стримы"
  },
  "authentication": {
    "title": "Аутентификация"
  },
  "accounts": {
    "title": "Аккаунты"
  },
  "chatbot": {
    "title": "Чатбот"
  },
  "stream_widgets": {
    "title": "Виджеты"
  },
  "settings": {
    "title": "Настройки"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": _en_US, "ru_RU": _ru_RU};
}
