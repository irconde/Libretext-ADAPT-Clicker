class Strings {
  static const String tryAgainBtnLabel = 'TRY IT AGAIN';
  static const String submitBtnLabel = 'Submit';
  static const String emailHint = 'john.appleseed@domain.com';
  static const String courses = 'Courses';
  static const String myProfile = 'My Profile';
  static const String myPassword = 'My Password';
  static const String contactUs = 'Contact Us';
  static const String contactus = 'Contact us';
  static const String requiredFields = '*Required Fields';
  static const String genericHintText =
      '[Some hint text...]'; // TODO. Review this.
  static const String or = 'OR';
  static const String havingProblems = 'Having problems? ';
  static const String firstNameFieldHint = 'John';
  static const String lastNameFieldHint = 'Appleseed';
  static const String studentIDFieldHint = 'john.appleseed';
  static const String emailField = 'Email';
  static const String passwordField = 'Password';
  static const String emailFieldMandatory = 'Email*';
  static const String emailFieldHint = 'john.appleseed@school.edu';
  static const String description = 'Description:  ';

  //Forms
  static const String dollarPeriod = r'''$.'''; //Used for api calls and such
  static const String formError = 'errors'; //.errors
  static const String formToken = 'token'; //.token

  //Forms - These are all constant values
  //used for the students that aren't currently customizable in app
  static const String schoolVal = 'unknown';
  static const String toUserIdVal = '0';
  static const String typeVal = 'contact_us';

  static const String registrationType = '3';

  //Login and Course
  static const String ssoLink = 'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=oaq1jkujPejJBNfDnOaguii9uOmuz4W5SEJH&redirect_uri=https%3A%2F%2Fadapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue';

  static const String adaptLink = 'https://adapt.libretexts.org';

  static const String accountError = 'Account could not be found';

  // Assignment screen
  static const String latePolicy = 'Late Policy: ';
  static const String emptyNotificationString = 'view_and_submit';
  static const String noDescription = 'There is no description';
  static const String points =
      'points'; //These three are also used for semantics
  static const String allowedAttempts = 'allowed attempts';
  static const String allowedAttempt = 'allowed attempt';

  // Assignment grid
  static const String uppercasePoints = 'Points';
  static const String awaitingScore = 'Awaiting Score';

  // Connection state mixin
  static const String connected = 'Connected to Internet';
  static const String notConnected = 'No Internet connection';

  // Poll widget
  static const String remainingTime = 'REMAINING TIME: ';

  // Notification Popup
  static const String ignoreButton = 'IGNORE';
  static const String participateButton = 'PARTICIPATE';


  // Add course widget
  static const String joinedCourse = 'You have successfully joined the course.';
  static const String courseRegistration = 'Course Registration';
  static const String courseCode = 'Course Code';
  static const String enterCourseCodeMsg =
      'Please enter the course code used given by your instructor.';
  static const String joinCourseBtnLabel = 'JOIN COURSE';
  static const String joinCourseBtnProcessingLabel = 'JOINING COURSE';

  // Reset password widget
  static const String pwdRequestedMsg =
      'Password reset requested. Check your inbox.';
  static const String passwordRecovery = 'Password Recovery';
  static const String enterEmail =
      'Please enter the email address used for \nregistration.';
  static const String resetPwdBtnLabel = 'RESET PASSWORD';
  static const String resetPwdBtnProcessingLabel = 'RESETTING PASSWORD';

  // Course list screen
  static const String signedInAs = 'Signed in as ';

  // No courses widget
  static const String noCoursesMsg =
      'Oops. it seems you haven\'t registered for a course yet';
  static const String askYour = 'Ask your ';
  static const String instructor = 'Instructor';
  static const String forA = 'for a ';
  static const String codeToJoin = 'Code to join';

  // Navigation drawer
  static const String logoutBtnLabel = 'LOGOUT';

  // Contact dropdown widget
  static const String generalInquiry = 'General Inquiry';
  static const String technicalIssue = 'Technical Issue';
  static const String emailChange = 'Email Change';
  static const String requestInstructorAccessCode =
      'Request Instructor Access Code';
  static const String requestTesterAccessCode = 'Request Tester Access Code';
  static const String integratingADAPT = 'Integrating ADAPT with LMS';
  static const String other = 'Other';

  // Poll widget
  static const String poll = 'Poll';

  // Update profile screen
  static const String firstNameFieldMandatory = 'First Name*';
  static const String lastNameFieldMandatory = 'Last Name*';
  static const String studentIDFieldMandatory = 'Student ID*';
  static const String updateProfileBtnLabel = 'UPDATE PROFILE';
  static const String updateProfileBtnProcessingLabel = 'UPDATING';
  static const String updateProfileBtnSuccessLabel = 'PROFILE UPDATED';

  // Reset password screen
  static const String changePwdBtnLabel = 'CHANGE PASSWORD';
  static const String changePwdBtnProcessingLabel = 'CHANGING PASSWORD';
  static const String changePwdBtnSuccessLabel = 'PASSWORD UPDATED';
  static const String currentPasswordField = 'Current Password';
  static const String newPasswordFieldMandatory = 'New Password*';
  static const String confirmPasswordFieldMandatory = 'Confirm New Password*';

  // Contact us screen
  static const String contactInfoMsg =
      'Please use this form to contact us regarding general questions or issues.';
  static const String nameFieldMandatory = 'Name*';
  static const String nameFieldHint = 'John Appleseed';
  static const String messageField = 'Message';
  static const String messageFieldHint = 'Your message here';
  static const String contactBtnLabel = 'SEND MESSAGE';
  static const String contactBtnProcessingLabel = 'SENDING MESSAGE';
  static const String contactBtnSuccessLabel = 'MESSAGE SENT';

  // Login screen
  static const String welcomeBack = 'Welcome Back';
  static const String rememberMe = 'Remember Me ';
  static const String forgotPassword = 'Forgot Password?';
  static const String signInBtnLabel = 'SIGN IN WITH ADAPT';
  static const String campusLoginBtnLabel = 'CAMPUS LOGIN';
  static const String signInBtnProcessingLabel = 'SIGNING IN';
  static const String dontHaveAccount = 'Don\'t have an account? ';
  static const String signUp = 'Sign up';

  // Home screen
  static const String loginBtnLabel = 'LOGIN';
  static const String createAccountBtnLabel = 'CREATE ACCOUNT';

  // Create account screen
  static const String accountFor = 'An account for ';
  static const String successfullyCreated = ' has been successfully created.';
  static const String createAccount = 'Create Account';
  static const String firstNameField = 'First Name';
  static const String lastNameField = 'Last Name';
  static const String studentIDField = 'Student ID';
  static const String passwordFieldHint = '*******';
  static const String confirmPasswordField = 'Confirm Password';
  static const String signUpBtnLabel = 'REGISTER';
  static const String campusSignUpBtnLabel = 'CAMPUS REGISTRATION';
  static const String signUpBtnProcessingLabel = 'CREATING ACCOUNT';

  // No notifications widget
  static const String noNotifications = 'No Notifications';
  static const String forNow = 'For Now';

  // Notification single
  static const String notification = 'Notification';
  static const String details = 'Details';

  // Notifications screen
  static const String notifications = 'Notifications';
  static const String clearAllBtnLabel = 'Clear All ';

  // Assignment ctn widget
  static const String outOf = 'out of';
  static const String noRecords = 'No records';

  // Assignment stat ctn widget
  static const String activityDescription = 'Activity Description';
  static const String dueDate = 'Due Date: ';
  static const String datePlaceholder = '8/18/2022 at 1:43 pm';

  // Course details screen
  static const String homeTab = 'HOME';
  static const String assignmentsTab = 'ASSIGNMENTS';
  static const String noCourseName = 'No name available';
  static const String instructorLabel = 'Instructor: ';
  static const String noCourseInstructor = 'No instructor assigned';
  static const String startDate = 'Start Date: ';
  static const String noDate = 'undefined';
  static const String endDate = 'End Date: ';
  static const String learningProcess = 'Learning Process';
  static const String noItemsMessage =
      'Oops. it seems you haven\'t registered for a course yet';
  static const String no = 'No ';
  static const String assessment = 'Assessment';
  static const String records = 'Records';
  static const String currently = 'Currently';
  static const String assignments = 'Assignments';
  static const String filterAllAssignments = 'All Assignments';
  static const String filterExam = 'Exam';
  static const String filterExtraCredit = 'Extra Credit';
  static const String filterHomework = 'Homework';
  static const String filterLab = 'Lab';
  static const String orderName = 'ORDER BY: NAME';
  static const String displayOrderName = 'Name';
  static const String orderStartDate = 'START DATE';
  static const String displayOrderStartDate = 'Available From';
  static const String orderDueDate = 'DUE DATE';
  static const String displayOrderDueDate = 'Due';

  ///Semantics
  //Global
  static const String passwordToggleShowingSemanticsLabel =
      'Toggle Password Visibility; Visible';
  static const String passwordToggleNotShowingSemanticsLabel =
      'Toggle Password Visibility; Not Visible';

  //AppBars
  static const String backButtonSemanticsLabel = 'Back';
  static const String closeButtonSemanticsLabel = 'Close';
  static const String notificationSemanticsLabel = 'Notifications';
  static const String mainMenuSemanticsLabel = 'Main Menu';

  //Login
  static const String rememberMeSemanticsLabel = 'Remember Me';

  //Courses
  static const String listOfCoursesSemanticsLabel = 'List of Courses';
  static const String addCourseSemanticsLabel = 'Add Course';

  //Assignment List
  static const String assignmentFilterSemanticsLabel = 'Show type';
  static const String assignmentOrderSemanticsLabel = 'Order by';
  static const String listOfStatsSemanticsLabel =
      'List of Statistic containers';

  //Assignment Details
  static const String assignmentInfoClosedSemanticsLabel =
      'Assignment Info Closed';
  static const String assignmentInfoOpenSemanticsLabel =
      'Assignment Info Opened';
  static const String totalPointsSemanticsLabel = 'Total Points';
  static const String questionNumberSemanticsLabel = 'Question: ';

  //Paginator
  static const String firstPageSemanticsLabel = 'First Page';
  static const String nextPageSemanticsLabel = 'Next Page';
  static const String previousPageSemanticsLabel = 'Previous Page';
  static const String lastPageSemanticsLabel = 'Last Page';
}
