part of '../views/bng_home_view.dart';

class _VoucherCardWidget extends StatelessWidget {
  const _VoucherCardWidget({
    required this.voucher,
  });

  final Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
