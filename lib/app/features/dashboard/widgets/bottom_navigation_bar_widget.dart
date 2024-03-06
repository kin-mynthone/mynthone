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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: AppColors.hE5EAFF,
              size: 30,
            ),
            activeIcon: Icon(
              Icons.home,
              color: AppColors.hF87054,
              size: 30,
            ),
            label: 'Page1',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              color: AppColors.hE5EAFF,
              size: 30,
            ),
            activeIcon: Icon(
              Icons.calendar_month,
              color: AppColors.hF87054,
              size: 30,
            ),
            label: 'Page2',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: AppColors.hE5EAFF,
              size: 30,
            ),
            activeIcon: Icon(
              Icons.person,
              color: AppColors.hF87054,
              size: 30,
            ),
            label: 'Page3',
          ),
        ],
      ),
    );
  }
}
