import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../models/BillingModel/cartModel.dart';
import '../../dynamicTableOrderNumbersNotifier.dart';
import '../cartNotifier.dart';
import '../outletDetail.dart';
import '../servicePageNotifier.dart';

void HomeDeliveryAddNewHandler() {
  Provider.of<DynamicTableDetails>(Get.context!,listen:false).GetDynamicDetailsHit(c_OrderTypeId.value??0).then((value){
    c_orderDetail.value=new OrderModel();
    c_orderDetail.value!.initOtherServices(value['Table1'][0]['OrderId'], value['Table1'][0]['OrderNumber'], value['Table'][0]['DynamicTable']);
    c_orderDetail.value!.setOrderType();
    c_orderDetail.value!.isMergeTable = false;
    clearClickEvents();
    //Get.to(BillingPage());
  });
}



void onHomeDeliveryClick() {
/*  ubc("divTakeAwayList", "sysTakeAway");
  $("#divTakeAwayList").on("click", ".sysTakeAway", function () {
  var orderId = $(this).attr("id");
  var tableNo = $(this).find(".auto-gen-TA-no").text();
  var status = $(this).attr("data-status");
  cl("onTakeAwayClick", orderId)
  cl("tableNo", tableNo)
  cl("status", status)
  TakeAwayHandler({
  orderId: orderId,
  dynamicNumber: tableNo,
  status: status
  });
  });*/
}


void HomeDeliveryHandler({ orderId, dynamicNumber, status }) {
  clearClickEvents();
  getTableStatus(null, dynamicNumber.split('-')[1],callback: (response){ getTableStatusResponse(response); },orderId: orderId);
}
