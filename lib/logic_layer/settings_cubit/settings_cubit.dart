import 'package:bloc/bloc.dart';
import 'package:chat_app_itsharks_25/services/cache_helper/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  
  static SettingsCubit get(context)=>BlocProvider.of(context);

  late bool isDark;
  late String languageCode;
  void loadThemeFromCache(){
    bool? fromCache = SharedPreferencesHelper.getData(key: "isDark");
    if(fromCache == null) {
      isDark = false;
    }
    else {
      isDark = fromCache;
    }
    emit(LoadThemeFromCache());
  }

  void changeTheme()async{
    isDark = !isDark;
    await SharedPreferencesHelper.saveData(key: "isDark", value: isDark);
    emit(ChangeTheme());
  }

  void loadLanguageCode(){
    String? langCode = SharedPreferencesHelper.getData(key: "languageCode");
    if(langCode == null){
      languageCode = 'en';
    }
    else{
      languageCode = langCode;
    }
    emit(LoadLanguageFromCache());
  }

  void changeLanguage({required String languageCode})async {
    this.languageCode = languageCode;
    await SharedPreferencesHelper.saveData(key: "languageCode", value: languageCode);
    emit(ChangeLanguage());
  }
}
