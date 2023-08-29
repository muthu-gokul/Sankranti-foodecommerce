class KOTCommentandAddOnMapping {
  int? kOTCommentandAddOnId;
  int? kOTCommentandAddOnTypeId;
  int? kOTId;
  int? commentId;
  int? addonId;
  String? comments;
  String? AddOnName;
  double? price;
  bool? isActive;
  int? orderProductId;

  KOTCommentandAddOnMapping(
      {this.kOTCommentandAddOnId,
        this.kOTCommentandAddOnTypeId,
        this.kOTId,
        this.commentId,
        this.addonId,
        this.comments,
        this.price,
        this.AddOnName,
        this.isActive=true,
        this.orderProductId});

  KOTCommentandAddOnMapping.fromJson(Map<String, dynamic> json) {
    kOTCommentandAddOnId = json['KOTCommentandAddOnId'];
    kOTCommentandAddOnTypeId = json['KOTCommentandAddOnTypeId'];
    kOTId = json['KOTId'];
    commentId = json['CommentId'];
    addonId = json['AddonId'];
    comments = json['Comments'];
    price = json['Price'];
    isActive = json['IsActive']??true;
    orderProductId = json['OrderProductId'];
  }

  KOTCommentandAddOnMapping.fromGetBilling(Map<String, dynamic> json) {
    kOTCommentandAddOnId = json['KOTCommentandAddOnId'];
    kOTCommentandAddOnTypeId = json['KOTCommentandAddOnTypeId'];
    kOTId = json['KOTId'];
    commentId = json['CommentId'];
    addonId = json['AddOnId'];
    comments = json['Comments'];
    price = json['Price'];
    isActive = json['IsActive'];
    orderProductId = json['OrderProductId'];
    AddOnName = json['AddOnName'];
    isActive = json['IsActive']??true;
  }

  KOTCommentandAddOnMapping.fromGetBillingComments(Map<String, dynamic> json) {
    kOTCommentandAddOnId = json['KOTCommentandAddOnId'];
    kOTCommentandAddOnTypeId = json['KOTCommentandAddOnTypeId'];
    kOTId = json['KOTId'];
    commentId = json['KOTCommentId'];
    addonId = json['AddOnId'];
    comments = json['Comments'];
    price = json['Price'];
    isActive = json['IsActive'];
    orderProductId = json['OrderProductId'];
    AddOnName = json['KOTComment'];
    isActive = json['IsActive']??true;
  }

  toJson() {
    var obj = {};
    obj['KOTCommentandAddOnId'] = this.kOTCommentandAddOnId;
    obj['KOTCommentandAddOnTypeId'] = this.kOTCommentandAddOnTypeId;
    obj['OrderProductId'] = this.orderProductId;
    obj['KOTId'] = this.kOTId;
    obj['CommentId'] = this.commentId;
    obj['AddonId'] = this.addonId;
    obj['Comments'] = this.comments;
    obj['Price'] = this.price;
    obj['IsActive'] = true;
    return obj;
  }
}