enum BuildFlavor { dev, release }

class BuildEnvironment {
  final BuildFlavor flavor;
  final String apiBaseUrl;

  BuildEnvironment.dev({
    required this.apiBaseUrl,
  }) : this.flavor = BuildFlavor.dev;

  BuildEnvironment.release({
    required this.apiBaseUrl,
  }) : this.flavor = BuildFlavor.release;
}