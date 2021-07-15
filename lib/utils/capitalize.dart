String capitalize(String str){
  if (str.isEmpty){
    return "";
  }
  return "${str[0].toUpperCase()}${str.substring(1)}";
}