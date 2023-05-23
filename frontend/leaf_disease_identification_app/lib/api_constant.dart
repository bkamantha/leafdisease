class ApiConstants {
  /*if you are using android emulator for runing device 
  use this ipv4adress 10.0.2.2 insted of following one. 
  if you are using real device for runing app, use your 
  Api runing device IPv4Address and replase it to 
  ipv4Adderss variable you can get it using "ipconfig" 
  command in cmd */

  /*######also note that run your django bakend using 
  "manage.py runserver 0.0.0.0:8000"  #######*/

  static const String ipv4Address = "10.0.2.2";
  //static const String ipv4Address = "192.168.1.4";

  static const String bASEURL = 'http://$ipv4Address:8000/detection/';
}
