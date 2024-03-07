part of '../views/dashboard_view.dart';

class _BottomNavigationBarWidget extends GetView<DashboardController> {
  const _BottomNavigationBarWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 3,
        backgroundColor: Colors.white,
        currentIndex: controller.currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => controller.setCurrentIndexValue(index),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetPath.home,
              colorFilter: const ColorFilter.mode(
                AppColors.hE5EAFF,
                BlendMode.modulate, // Blend mode
              ),
              height: 30,
            ),
            activeIcon: SvgPicture.asset(
              AssetPath.home,
              colorFilter: const ColorFilter.mode(
                AppColors.hF87054,
                BlendMode.modulate, // Blend mode
              ),
              height: 30,
            ),
            label: 'Page1',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetPath.cards,
              colorFilter: const ColorFilter.mode(
                AppColors.hE5EAFF,
                BlendMode.modulate, // Blend mode
              ),
              height: 30,
            ),
            activeIcon: SvgPicture.asset(
              AssetPath.cards,
              colorFilter: const ColorFilter.mode(
                AppColors.hF87054,
                BlendMode.modulate, // Blend mode
              ),
              height: 30,
            ),
            label: 'Page1',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetPath.statements,
              colorFilter: const ColorFilter.mode(
                AppColors.hE5EAFF,
                BlendMode.modulate, // Blend mode
              ),
              height: 30,
            ),
            activeIcon: SvgPicture.asset(
              AssetPath.statements,
              colorFilter: const ColorFilter.mode(
                AppColors.hF87054,
                BlendMode.modulate, // Blend mode
              ),
              height: 30,
            ),
            label: 'Page1',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetPath.settings,
              colorFilter: const ColorFilter.mode(
                AppColors.hE5EAFF,
                BlendMode.modulate, // Blend mode
              ),
              height: 30,
            ),
            activeIcon: SvgPicture.asset(
              AssetPath.settings,
              colorFilter: const ColorFilter.mode(
                AppColors.hF87054,
                BlendMode.modulate, // Blend mode
              ),
              height: 30,
            ),
            label: 'Page1',
          ),
        ],
      ),
    );
  }
}
