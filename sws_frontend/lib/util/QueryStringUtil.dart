class QueryStringUtil{
  Map<String,String> queryMap=<String,String>{};

  void add(String key,String value){
    queryMap[key]=value;
  }
  void addString(String keyValue){
    List<String> e=keyValue.split("=");
    queryMap[e[0]]=e[1];
  }
  String getQueryString(){
    if(queryMap.isNotEmpty){
      return queryMap.entries
          .map((e) => "${e.key}=${e.value}")
          .join("&");
    }
    return "";
  }
}