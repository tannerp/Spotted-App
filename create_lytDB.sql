create table AuthEmail(
  email varchar(100) not null primary key
);

create table AuthCode(
  code int auto_increment not null primary key,
  email varchar(100),
  constraint AuthCode_AuthEmail_email_fk
  foreign key (email) references AuthEmail (email) on update restrict
);

create table User(
  userId int auto_increment primary key,
  firstName varchar(100) not null,
  lastName varchar(100) not null,
  middleName varchar(100) null,
  email varchar(50)  not null,
  userPassword varchar(50)  not null,
  constraint User_AuthEmail_email_fk
  foreign key (email) references AuthEmail (email) on update restrict
);

create table StudentProfile(
  profileId int auto_increment primary key,
  classYear enum ('freshman', 'sophomore', 'junior', 'senior') not null,
  onCampus boolean not null,
  gender enum ('female', 'male')	not null,
  userId int not null,
  constraint StudentProfile_User_userId_fk
  foreign key (userId) references User (userId) on update restrict
);

create table ThanksCount(
  thanksCount int primary key,
  profileId int not null,
  constraint ThanksCount_StudentProfile_profileId_fk
  foreign key (profileId) references StudentProfile (profileId) on update restrict
);

create table whothankedWho(
  thanksId int auto_increment primary key,
  thankerId int not null,
  thankeeId int not null,
  constraint thankedWho_StudentProfile_thankerId_fk
  foreign key (thankerId) references StudentProfile (userId) on update restrict,
  constraint thankedWho_StudentProfile_thankeeId_fk
  foreign key (thankeeId) references StudentProfile (userId) on update restrict,
);

create table Department(
  departmentId int auto_increment primary key,
  departmentName varchar(100) not null
);

create table Major(
  majorId int auto_increment primary key,
  majorName varchar(100) not null,
  departmentId int not null,
  constraint Major_Department_departmentId_fk
  foreign key (departmentId) references Department (departmentId) on update restrict
);

create table MajorXStudent(
  MXSId int auto_increment primary key,
  profileId int not null,
  majorId int not null,
  constraint MajorXStudent_Major_majorId_fk
  foreign key (majorId) references Major (majorId) on update restrict,
  constraint MajorXStudent_StudentProfile_profileId_fk
  foreign key (profileId) references StudentProfile (profileId) on update restrict
);

create table InterestCategory(
  interestCategoryId int auto_increment primary key,
  interestCategoryTitle varchar(100) not null
);

create table StudentInterest(
  interestId int auto_increment  primary key,
  categotyTitle varchar(100) not null,
  profileId int not null,
  interestCategoryId int not null,
  constraint StudentInterest_StudentPorfile_profileId_fk
  foreign key (profileId) references StudentProfile (profileId) on update restrict,
  constraint StudentInterest_InterestCategory_interestCategoryId_fk
  foreign key (interestCategoryId) references InterestCategory (interestCategoryId) on update restrict
);

create table Post(
  postId int auto_increment primary key,
  postTitle varchar(100) not null,
  postContent varchar(300) not null,
  postDate date not null,
  postStatus enum ('live', 'expired', 'deleted') not null
  userId int not null,
  constraint Post_User_userId_fk
  foreign key (userId) references User   (userId) on update restrict
);

create table PostXInterest(
  postXInterestId int auto_increment primary key,
  interestId int not null,
  postId int not null,
  constraint PostXInterest_StudentInterest_interestId_fk
  foreign key (interestId) references StudentInterest (interestId) on update restrict,
  constraint PostXInteres_Post_postId_fk
  foreign key (postId) references Post (postId) on update restrict
);

create table PotentialMentor(
  potentialMentorId int auto_increment primary key,
  postId int not null,
  userId int not null,
  constraint PotentialMentor_Post_postId_fk
  foreign key (postId) references Post (postId)
  on update restrict,
  constraint PotentialMentor_User_userId_fk
  foreign key (userId) references User (userId) on update restrict
);

create table Conversation(
  conversationId int auto_increment primary key,
  postId int not null,
  constraint Conversation_Post_postId_fk
  foreign key (postId) references Post (postId) on update restrict
);

create table Participant(
  conversationId int not null,
  userId int not null,
  last_read_timestamp timestamp not null,
  constraint Participant_Conversation_conversationId_fk
  foreign key (conversationId) references Conversation (conversationId) on update restrict,
  constraint Participant_User_userId_fk
  foreign key (userId) references User (userId) on update restrict
);

create table Message(
  messageId int not null auto_increment primary key,
  messageBody varchar(300) not null,
  timeStamp time,
  conversationId int not null,
  constraint Message_Conversation_conversationId_fk
  foreign key (conversationId) references Conversation (conversationId) on update restrict
);
