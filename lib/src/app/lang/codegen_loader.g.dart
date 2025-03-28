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
  "navigation_bar": {
    "dashboard": "Dashboard",
    "donations": "Donations",
    "streams": "Streams",
    "authentication": "Authentication",
    "accounts": "Accounts",
    "chatbot": "Chatbot",
    "stream_widgets": "Stream Widgets",
    "settings": "Settings"
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
        "remove": "Remove",
        "edit": "Edit"
      },
      "add_dialog": {
        "last_alerts": {
          "title": "Last alerts widget",
          "insert_link": "Insert link"
        }
      },
      "errors": {
        "invalid_last_alerts_widget_link": "Invald last alerts widget link",
        "invalid_link": "Invalid link. Link must be from official DonationAlerts website"
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
    "title": "Accounts",
    "buttons": {
      "log_out": "Log out"
    }
  },
  "chatbot": {
    "title": "Chatbot"
  },
  "stream_widgets": {
    "title": "Stream Widgets"
  },
  "settings": {
    "title": "Settings",
    "theme": {
      "title": "App theme",
      "dark": "Dark",
      "light": "Light"
    }
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
  "navigation_bar": {
    "dashboard": "Дашборд",
    "donations": "Донаты",
    "streams": "Стримы",
    "authentication": "Аутентификация",
    "accounts": "Аккаунты",
    "chatbot": "Чатбот",
    "stream_widgets": "Виджеты",
    "settings": "Настройки"
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
        "remove": "Убрать",
        "edit": "Изменить"
      },
      "add_dialog": {
        "last_alerts": {
          "title": "Виджет последних сообщений",
          "insert_link": "Вставьте ссылку"
        }
      },
      "errors": {
        "invalid_last_alerts_widget_link": "Неверная ссылка на виджет последних сообщений",
        "invalid_link": "Неверная ссылка. Ссылка должна быть предоставлена официальным сайтом DonationAlerts"
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
    "title": "Аккаунты",
    "buttons": {
      "log_out": "Выйти"
    }
  },
  "chatbot": {
    "title": "Чатбот"
  },
  "stream_widgets": {
    "title": "Виджеты"
  },
  "settings": {
    "title": "Настройки",
    "theme": {
      "title": "Тема",
      "dark": "Тёмная",
      "light": "Светлая"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": _en_US, "ru_RU": _ru_RU};
}
