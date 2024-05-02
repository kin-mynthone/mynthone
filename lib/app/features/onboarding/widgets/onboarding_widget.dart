part of '../views/onboarding_view.dart';

class _OnboardingWidget extends StatelessWidget {
  const _OnboardingWidget({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppNumbers.screenPadding,
        vertical: AppNumbers.screenPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ImageWidget(imagePath: imagePath),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Title(title: title),
              const SizedBox(height: 10),
              _Description(description: description),
            ],
          ),
          const SizedBox()
        ],
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        imagePath,
        width: 250,
        height: 350,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.hF6F6F6,
              fontSize: 28,
            ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.hF6F6F6,
            fontSize: 13,
          ),
    );
  }
}
