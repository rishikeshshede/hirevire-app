class Endpoints {
  // ############## User Endpoints ##############
  // GET Endpoint
  static const String searchJobTitles = 'master/jobTitles/by-name';
  static const String searchCompanies = 'master/companies/by-name';
  static const String searchSkills = 'master/skills/by-name';
  static const String getTexts = 'content';

  // POST Endpoints
  static const String sendOtp = 'auth/sendOTP';
  static const String verifyOTP = 'auth/verifyOTP';
  static const String signup = 'auth/signup';
  static const String uploadProfilePicture = 'auth/profilePicture';
  static const String uploadVideoWithThumbnail = 'jobPosting/media';

  // UPDATE Endpoints

  // DELETE Endpoints

  // ############## Recruiter Endpoints ##############

  // POST Endpoints
  static const String recruiterSignin = 'auth/recruiter/signin';
}
