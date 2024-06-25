part of '../views/merchants_view.dart';

class _ShimmerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppNumbers.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          _ShimmerItemWidget(),
          _ShimmerItemWidget(),
          _ShimmerItemWidget(),
          _ShimmerItemWidget(),
          _ShimmerItemWidget(),
        ],
      ),
    );
  }
}

class _ShimmerItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.hF6F6F6,
          highlightColor: AppColors.hBDBDBD,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: 250,
              height: 15,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: AppColors.hF6F6F6,
          highlightColor: AppColors.hBDBDBD,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: 120,
              height: 15,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
