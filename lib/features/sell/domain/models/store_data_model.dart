class StoreDataModel{
  String? karat;
  String? weight;
  String? proposedPrice;
  String? branchId;
  String? deliveryAddressId;

  StoreDataModel(
      this.karat,
      this.weight,
      this.proposedPrice,
      this.branchId,
      this.deliveryAddressId);

  StoreDataModel.fromJson(Map<String, String> json) {
      karat = json['karat'];
      weight = json['weight'];
      proposedPrice = json['proposed_price'];
      branchId = json['branch_id'];
      deliveryAddressId = json['delivery_address_id'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['karat'] = karat ?? '';
    data['weight'] = weight ?? '';
    data['proposed_price'] = proposedPrice ?? '';
    data['branch_id'] = branchId ?? '';
    data['delivery_address_id'] = deliveryAddressId ?? '';
    return data;
  }
}