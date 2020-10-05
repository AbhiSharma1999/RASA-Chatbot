class Language{
  final int id;
  final String name;
  final String languagecode;
  final String countrycode;

  Language(this.id, this.name,  this.languagecode,this.countrycode);

  static List<Language> languageList = [
                                        Language(0,'English','en','US'),
                                        Language(1,'हिन्दी','hi','IN')
                                        ];


}