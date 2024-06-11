part of '../views/dashboard_view.dart';

class _BottomNavigationBarWidget extends GetView<DashboardController> {
  const _BottomNavigationBarWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 20,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            backgroundColor: Colors.white,
            currentIndex: controller.bottomNavCurrentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => controller.setBottomNavCurrentIndexValue(index),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetPath.home,
                  colorFilter: const ColorFilter.mode(
                    AppColors.hE5EAFF,
                    BlendMode.modulate, // Blend mode
                  ),
                  height: 25,
                ),
                activeIcon: SvgPicture.asset(
                  AssetPath.home,
                  colorFilter: const ColorFilter.mode(
                    AppColors.hE06144,
                    BlendMode.modulate, // Blend mode
                  ),
                  height: 25,
                ),
                label: 'Home',
              ),
              // BottomNavigationBarItem(
              //   icon: SvgPicture.asset(
              //     AssetPath.cards,
              //     colorFilter: const ColorFilter.mode(
              //       AppColors.hE5EAFF,
              //       BlendMode.modulate, // Blend mode
              //     ),
              //     height: 25,
              //   ),
              //   activeIcon: SvgPicture.asset(
              //     AssetPath.cards,
              //     colorFilter: const ColorFilter.mode(
              //       AppColors.hE06144,
              //       BlendMode.modulate, // Blend mode
              //     ),
              //     height: 25,
              //   ),
              //   label: 'Cards',
              // ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetPath.statements,
                  colorFilter: const ColorFilter.mode(
                    AppColors.hE5EAFF,
                    BlendMode.modulate, // Blend mode
                  ),
                  height: 25,
                ),
                activeIcon: SvgPicture.asset(
                  AssetPath.statements,
                  colorFilter: const ColorFilter.mode(
                    AppColors.hE06144,
                    BlendMode.modulate, // Blend mode
                  ),
                  height: 25,
                ),
                label: 'Statement',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetPath.settings,
                  colorFilter: const ColorFilter.mode(
                    AppColors.hE5EAFF,
                    BlendMode.modulate, // Blend mode
                  ),
                  height: 25,
                ),
                activeIcon: SvgPicture.asset(
                  AssetPath.settings,
                  colorFilter: const ColorFilter.mode(
                    AppColors.hE06144,
                    BlendMode.modulate, // Blend mode
                  ),
                  height: 25,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
