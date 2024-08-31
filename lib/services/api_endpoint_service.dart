class EndpointService {
  // ------------------- COMMON ENDPOINTS -------------------

  // -------------------- USER ENDPOINTS --------------------

  // GET Endpoint
  static const String getRecommendedJobs = 'jobPosting/recommendation';
  static const String getMyApplications = 'jobApplication/user/applied';
  static const String getUserProfile = 'jobSeeker';

  // POST Endpoints
  static const String userLeftSwipe = 'jobApplication/user/leftSwipe';
  static const String userUploadVideoWithThumbnail = 'jobPosting/media';
  static const String userJobApply = 'jobApplication/user/rightSwipe';

  // UPDATE Endpoints
  static const String updateUserProfile = 'jobSeeker/updateProfile';


  // ------------------ EMPLOYER ENDPOINTS ------------------

  // GET Endpoint
  static const String getRequisitions = 'jobPosting/requisitions';
  static const String getJobPostings = 'jobPosting/created';
  static const String getJobApplications = 'jobApplication/recruiter/application';


  // POST Endpoints
  static const String createJobPostings = 'jobPosting/create';
  static const String rightSwipeApplicant = 'jobApplication/recruiter/rightSwipe';
  static const String leftSwipeApplicant = 'jobApplication/recruiter/leftSwipe';

  // UPDATE Endpoints
  static const String closeJobPostings = 'jobPosting/close';
  static const String updateJobPostings = 'jobPosting/update';

}