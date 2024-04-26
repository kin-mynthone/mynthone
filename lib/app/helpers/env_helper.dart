class Env {
  static const String developmentEnvFile = '.env.development';
  static const String stagingEnvFile = '.env.staging';
  static const String productionEnvFile = '.env.production';

  static const String supabaseUrl = 'SUPABASE_URL';
  static const String supabaseAnon = 'SUPABASE_ANON';

  static const String developmentFlavor = 'Development';
  static const String stagingFlavor = 'Staging';
  static const String productionFlavor = 'Production';

  static const String signInApiEndpoint = 'SIGNIN_API_ENDPOINT';
  static const String registerApiEndpoint = 'REGISTER_API_ENDPOINT';
  static const String forgotPasswordApiEndpoint =
      'FORGOT_PASSWORD_API_ENDPOINT';
}
