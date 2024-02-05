import 'package:freezed_annotation/freezed_annotation.dart';

part 'pharmacy_detail.freezed.dart';
part 'pharmacy_detail.g.dart';

@freezed
class PharmacyDetail with _$PharmacyDetail {
  const PharmacyDetail._();
  const factory PharmacyDetail({
    required String storeId,
    required String storeName,
    required double lat,
    required double lng,
    @Default([]) List<dynamic>? medicines,
    @Default('연중무휴 매일 밤 10시부터 아침 6시까지') String? operatingDesc,
    @Default('응급시 필요한 일반 의약품') String? medicineDesc,
    @Default('반드시 카드 결제만 가능합니다.') String? paymentDesc,
  }) = _PharmacyDetail;

  factory PharmacyDetail.fromJson(Map<String, dynamic> json) =>
      _$PharmacyDetailFromJson(json);
}
