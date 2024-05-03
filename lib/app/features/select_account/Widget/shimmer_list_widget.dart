part of '../views/select_account_view.dart';

class _ShimmerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 2),
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
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.hF6F6F6,
          highlightColor: AppColors.hBDBDBD,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
