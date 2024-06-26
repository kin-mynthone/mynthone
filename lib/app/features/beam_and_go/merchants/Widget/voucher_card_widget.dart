part of '../views/merchants_view.dart';

class _VoucherCardWidget extends GetView<MerchantsController> {
  const _VoucherCardWidget({
    required this.voucher,
  });

  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.resetQuantity();
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return _BottomSheetVoucherDetails(
              voucher: voucher,
            );
          },
        );
      },
      child: CouponCard(
        height: 150,
        backgroundColor: AppColors.hF2F4FE,
        curveAxis: Axis.vertical,
        firstChild: Container(
          decoration: const BoxDecoration(
            color: AppColors.hE06144,
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: Image.network(
                voucher.imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('Failed to load image');
                },
              ),
            ),
          ),
        ),
        secondChild: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                voucher.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                voucher.description,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h8E8E8E,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              const Spacer(),
              Text(
                '${voucher.unitPrice} ${voucher.unitPriceCurrencyCode} ',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.hE06144,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSheetVoucherDetails extends GetView<MerchantsController> {
  const _BottomSheetVoucherDetails({
    required this.voucher,
  });

  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(
          AppNumbers.screenPadding, 0, AppNumbers.screenPadding, 50),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 180,
              width: 180,
              child: Image.network(
                voucher.imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('Failed to load image');
                },
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                voucher.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h403E51,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                voucher.description,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.h8E8E8E,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${voucher.unitPrice}  ${voucher.unitPriceCurrencyCode}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.hE06144,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(
            height: 40,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.quantity > voucher.minQty) {
                          controller.subtractQuantity();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.h2445D4,
                          padding: const EdgeInsets.all(0)),
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.hF2F4FE,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      ' ${controller.quantity}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.h403E51,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 50,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.quantity < voucher.maxQty) {
                          controller.addQuantity();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.h2445D4,
                          padding: const EdgeInsets.all(0)),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.hF2F4FE,
                      ),
                    ),
                  ),
                ],
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                'Continue'.tr,
              )),
        ],
      ),
    );
  }
}
