

import 'package:get/get.dart';

class VideooController extends GetxController{
  RxBool pause        = true.obs;
  RxBool speaker      = true.obs;
  RxBool viewchanger  = false.obs;
  RxBool loop         = true.obs;
  RxInt hour          =0.obs;
  RxInt minute        =0.obs;
  RxInt second        =0.obs;
  RxDouble slidervalue=0.0.obs;

}