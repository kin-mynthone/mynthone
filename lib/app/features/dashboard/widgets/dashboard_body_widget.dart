part of '../views/dashboard_view.dart';

class _DashboardBodyWidget extends GetView<DashboardController> {
  const _DashboardBodyWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _IndexStackWithFadeAnimation(
        index: controller.bottomNavCurrentIndex,
        children: const [
          Center(child: HomeView()),
          //  Center(child: CardView()),
          Center(child: StatementView()),
          //  Center(child: Text('page4')),
        ],
      ),
    );
  }
}

class _IndexStackWithFadeAnimation extends StatefulWidget {
  const _IndexStackWithFadeAnimation({
    required this.index,
    required this.children,
  });

  final int index;
  final List<Widget> children;

  @override
  State<_IndexStackWithFadeAnimation> createState() =>
      _IndexStackWithFadeAnimationState();
}

class _IndexStackWithFadeAnimationState
    extends State<_IndexStackWithFadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(_IndexStackWithFadeAnimation oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}
