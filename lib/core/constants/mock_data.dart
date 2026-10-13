class MockUser {
  final String id;
  final String name;
  final String handle;
  final String college;
  final String avatar;
  final String role;
  final bool verified;

  MockUser({
    required this.id,
    required this.name,
    required this.handle,
    required this.college,
    required this.avatar,
    required this.role,
    required this.verified,
  });
}

class MockStory {
  final String id;
  final MockUser user;
  final String image;
  final bool viewed;

  MockStory({
    required this.id,
    required this.user,
    required this.image,
    required this.viewed,
  });
}

class MockPost {
  final String id;
  final MockUser author;
  final String type;
  final String? title;
  final String content;
  final List<String> images;
  final String? date;
  final String time;
  final int likes;
  final List<Map<String, dynamic>> comments;
  final List<String>? skills;
  final bool isLiked;
  final bool isSaved;

  MockPost({
    required this.id,
    required this.author,
    required this.type,
    this.title,
    required this.content,
    required this.images,
    this.date,
    required this.time,
    required this.likes,
    required this.comments,
    this.skills,
    required this.isLiked,
    required this.isSaved,
  });
}

class MockNotification {
  final String id;
  final String type;
  final MockUser user;
  final String content;
  final String time;
  final bool read;

  MockNotification({
    required this.id,
    required this.type,
    required this.user,
    required this.content,
    required this.time,
    required this.read,
  });
}

class MockMessage {
  final String id;
  final MockUser user;
  final String lastMessage;
  final String time;
  final int unread;

  MockMessage({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.time,
    required this.unread,
  });
}

class MockCommunity {
  final String id;
  final String name;
  final String type;
  final String coverImage;
  final String avatar;
  final int membersCount;
  final bool isJoined;

  MockCommunity({
    required this.id,
    required this.name,
    required this.type,
    required this.coverImage,
    required this.avatar,
    required this.membersCount,
    required this.isJoined,
  });
}

class MockEventOrganizer {
  final String name;
  final bool verified;
  MockEventOrganizer({required this.name, required this.verified});
}

class MockEvent {
  final String id;
  final String title;
  final String image;
  final String coverImage;
  final String date;
  final String time;
  final String location;
  final String price;
  final int attendees;
  final MockEventOrganizer organizer;
  final List<String> tags;
  final bool isRsvpd;

  MockEvent({
    required this.id,
    required this.title,
    required this.image,
    String? coverImage,
    required this.date,
    required this.time,
    this.location = 'Online',
    this.price = 'FREE',
    required this.attendees,
    required this.organizer,
    required this.tags,
    required this.isRsvpd,
  }) : coverImage = coverImage ?? image;
}

class MockOpportunity {
  final String id;
  final String title;
  final String type;
  final String deadline;
  final List<String> skills;
  final MockUser author;
  final String description;
  final int interested;
  final List<Map<String, dynamic>> roles;

  MockOpportunity({
    required this.id,
    required this.title,
    required this.type,
    required this.deadline,
    required this.skills,
    required this.author,
    this.description = 'Join us to build something amazing! We are looking for passionate individuals to collaborate on an exciting new project.',
    this.interested = 12,
    this.roles = const [
      {'title': 'Designer', 'count': 1, 'skills': ['Figma', 'UI/UX']},
      {'title': 'Developer', 'count': 2, 'skills': ['Flutter', 'Firebase']},
    ],
  });
}

class MockPerson {
  final String id;
  final String name;
  final String handle;
  final String college;
  final String role;
  final String avatar;
  final bool verified;
  final int mutualConnections;

  MockPerson({
    required this.id,
    required this.name,
    required this.handle,
    required this.college,
    required this.role,
    required this.avatar,
    required this.verified,
    required this.mutualConnections,
  });
}

class MockData {
  static final MockUser currentUser = MockUser(
    id: "u1",
    name: "Aryan Sharma",
    handle: "@aryans",
    college: "IIT Bombay",
    avatar: "https://picsum.photos/seed/aryan/200/200",
    role: "Student",
    verified: true,
  );

  static final List<MockStory> stories = [
    MockStory(
      id: "s1",
      user: MockUser(id: "u2", name: "Priya", handle: "", college: "", role: "", verified: false, avatar: "https://picsum.photos/seed/priya/200/200"),
      image: "https://picsum.photos/seed/story1/1080/1920",
      viewed: false,
    ),
    MockStory(
      id: "s2",
      user: MockUser(id: "u3", name: "Rahul", handle: "", college: "", role: "", verified: false, avatar: "https://picsum.photos/seed/rahul/200/200"),
      image: "https://picsum.photos/seed/story2/1080/1920",
      viewed: false,
    ),
    MockStory(
      id: "s3",
      user: MockUser(id: "u4", name: "TechFest", handle: "", college: "", role: "", verified: true, avatar: "https://picsum.photos/seed/techfest/200/200"),
      image: "https://picsum.photos/seed/story3/1080/1920",
      viewed: true,
    ),
  ];

  static final List<MockNotification> notifications = [
    MockNotification(id: "n1", type: "like", user: MockUser(id: "u2", name: "Priya Patel", avatar: "https://picsum.photos/seed/priya/200/200", handle: "", role: "", college: "", verified: false), content: "liked your post about internship experiences.", time: "2m ago", read: false),
    MockNotification(id: "n2", type: "connection", user: MockUser(id: "u3", name: "Rahul Dev", avatar: "https://picsum.photos/seed/rahul/200/200", handle: "", role: "", college: "", verified: false), content: "wants to connect with you", time: "15m ago", read: false),
    MockNotification(id: "n3", type: "comment", user: MockUser(id: "u5", name: "Ananya Singh", avatar: "https://picsum.photos/seed/ananya/200/200", handle: "", role: "", college: "", verified: true), content: "commented on your post: \"Great insights!\"", time: "1h ago", read: false),
    MockNotification(id: "n4", type: "opportunity", user: MockUser(id: "u4", name: "Design Club", avatar: "https://picsum.photos/seed/design/200/200", handle: "", role: "", college: "", verified: false), content: "posted a new opportunity matching your skills", time: "3h ago", read: true),
    MockNotification(id: "n5", type: "like", user: MockUser(id: "u6", name: "TechFest IIT", avatar: "https://picsum.photos/seed/techfest/200/200", handle: "", role: "", college: "", verified: true), content: "and 24 others liked your post", time: "5h ago", read: true),
    MockNotification(id: "n6", type: "connection", user: MockUser(id: "u7", name: "Vikram Nair", avatar: "https://picsum.photos/seed/vikram/200/200", handle: "", role: "", college: "", verified: false), content: "accepted your connection request", time: "Yesterday", read: true),
  ];

  static final List<MockMessage> messages = [
    MockMessage(
      id: "m1",
      user: MockUser(id: "u2", name: "Sneha Rao", avatar: "https://picsum.photos/seed/sneha/200/200", handle: "", role: "", college: "", verified: false),
      lastMessage: "Are we still on for the project meeting tomorrow?",
      time: "10:30 AM",
      unread: 2,
    ),
    MockMessage(
      id: "m2",
      user: MockUser(id: "g1", name: "ETHIndia Team 4", avatar: "https://picsum.photos/seed/team4/200/200", handle: "", role: "", college: "", verified: false),
      lastMessage: "Rahul: I've pushed the smart contract changes",
      time: "Yesterday",
      unread: 0,
    ),
    MockMessage(
      id: "m3",
      user: MockUser(id: "u4", name: "Vikram Singh", avatar: "https://picsum.photos/seed/vikram/200/200", handle: "", role: "", college: "", verified: true),
      lastMessage: "Thanks for sharing those Figma files!",
      time: "Mon",
      unread: 0,
    ),
  ];

  static final List<MockPost> posts = [


    MockPost(
      id: "p1",
      author: MockUser(id: "u2", name: "Priya Patel", handle: "@priyap", avatar: "https://picsum.photos/seed/priya/200/200", college: "BITS Pilani", role: "Student", verified: false),
      type: "text",
      content: "Just finished my first round of interviews for the summer internship! The DSA questions were brutal but I think I managed. Anyone else interviewing with them this week?",
      images: ["https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=1080&auto=format&fit=crop"],
      time: "2h ago",
      likes: 124,
      comments: [],
      isLiked: false,
      isSaved: true,
    ),
    MockPost(
      id: "p2",
      author: MockUser(id: "u3", name: "Rahul Dev", handle: "@rahuld", avatar: "https://picsum.photos/seed/rahul/200/200", college: "NIT Trichy", role: "Student", verified: false),
      type: "opportunity",
      title: "Looking for a UI/UX Designer for our Hackathon team",
      content: "We are building an AI-powered study buddy app for the upcoming ETHIndia hackathon. Need someone who can design clean, minimal interfaces.",
      images: ["https://images.unsplash.com/photo-1618761714954-0b8cd0026356?q=80&w=1080&auto=format&fit=crop"],
      skills: ["Figma", "UI/UX", "Prototyping"],
      time: "5h ago",
      likes: 45,
      comments: [],
      isLiked: true,
      isSaved: false,
    ),
    MockPost(
      id: "p3",
      author: MockUser(id: "u4", name: "Design Club", handle: "@designiitd", avatar: "https://picsum.photos/seed/design/200/200", college: "IIT Delhi", role: "Club/Society", verified: true),
      type: "event",
      title: "Intro to Spatial Design Workshop",
      content: "Join us this weekend for a hands-on workshop on designing for AR/VR. Limited seats remaining!",
      images: ["https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=1080&auto=format&fit=crop"],
      date: "Sat, 14 Oct • 5:00 PM",
      time: "1d ago",
      likes: 312,
      comments: [],
      isLiked: false,
      isSaved: false,
    ),
  ];

  static final List<MockPerson> people = [
    MockPerson(id: "p1", name: "Sneha Rao", handle: "@snehar", college: "IIT Bombay", role: "UI/UX Designer", avatar: "https://picsum.photos/seed/sneha/200/200", verified: false, mutualConnections: 3),
    MockPerson(id: "p2", name: "Vikram Singh", handle: "@vikrams", college: "BITS Pilani", role: "Full Stack Dev", avatar: "https://picsum.photos/seed/vikram2/200/200", verified: true, mutualConnections: 7),
    MockPerson(id: "p3", name: "Ananya Kumar", handle: "@ananyak", college: "NIT Trichy", role: "ML Engineer", avatar: "https://picsum.photos/seed/ananya2/200/200", verified: false, mutualConnections: 2),
    MockPerson(id: "p4", name: "Rohan Mehta", handle: "@rohanm", college: "IIT Delhi", role: "Product Manager", avatar: "https://picsum.photos/seed/rohan/200/200", verified: false, mutualConnections: 5),
  ];

  static final List<MockCommunity> communities = [
    MockCommunity(id: "c1", name: "IIT Bombay CS", type: "College", coverImage: "https://images.unsplash.com/photo-1562774053-701939374585?q=80&w=400&auto=format&fit=crop", avatar: "https://picsum.photos/seed/iitb/200/200", membersCount: 1240, isJoined: true),
    MockCommunity(id: "c2", name: "ETHIndia Builders", type: "Interest", coverImage: "https://images.unsplash.com/photo-1620321023374-d1a68fbc720d?q=80&w=400&auto=format&fit=crop", avatar: "https://picsum.photos/seed/ethindia/200/200", membersCount: 856, isJoined: true),
    MockCommunity(id: "c3", name: "Design Collective", type: "Interest", coverImage: "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?q=80&w=400&auto=format&fit=crop", avatar: "https://picsum.photos/seed/design2/200/200", membersCount: 432, isJoined: true),
    MockCommunity(id: "c4", name: "NIT Trichy Alumni", type: "College", coverImage: "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=400&auto=format&fit=crop", avatar: "https://picsum.photos/seed/nit/200/200", membersCount: 2100, isJoined: false),
    MockCommunity(id: "c5", name: "IIT Delhi Research", type: "Closed", coverImage: "https://images.unsplash.com/photo-1532094349884-543559244f46?q=80&w=400&auto=format&fit=crop", avatar: "https://picsum.photos/seed/iitd/200/200", membersCount: 320, isJoined: false),
    MockCommunity(id: "c6", name: "TechFest 2025", type: "Event", coverImage: "https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=400&auto=format&fit=crop", avatar: "https://picsum.photos/seed/techfest2/200/200", membersCount: 3400, isJoined: false),
    MockCommunity(id: "c7", name: "Robotics Club", type: "Interest", coverImage: "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=400&auto=format&fit=crop", avatar: "https://picsum.photos/seed/robotics/200/200", membersCount: 678, isJoined: false),
  ];

  static final List<MockEvent> events = [
    MockEvent(
      id: "e1",
      title: "ETHIndia Hackathon 2025",
      image: "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1080&auto=format&fit=crop",
      coverImage: "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1080&auto=format&fit=crop",
      date: "Dec 14",
      time: "9:00 AM",
      location: "Bangalore International Exhibition Centre",
      price: "FREE",
      attendees: 1200,
      organizer: MockEventOrganizer(name: "ETHIndia", verified: true),
      tags: ["Web3", "Hackathon", "Prize Pool"],
      isRsvpd: true,
    ),
    MockEvent(
      id: "e2",
      title: "Intro to Spatial Design Workshop",
      image: "https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=1080&auto=format&fit=crop",
      coverImage: "https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=1080&auto=format&fit=crop",
      date: "Oct 14",
      time: "5:00 PM",
      location: "LHC 101, IIT Delhi",
      price: "₹299",
      attendees: 85,
      organizer: MockEventOrganizer(name: "Design Club IIT Delhi", verified: false),
      tags: ["AR/VR", "Design", "Workshop"],
      isRsvpd: false,
    ),
    MockEvent(
      id: "e3",
      title: "Campus Startup Pitch Night",
      image: "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=1080&auto=format&fit=crop",
      coverImage: "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=1080&auto=format&fit=crop",
      date: "Nov 2",
      time: "6:30 PM",
      location: "E-Cell Auditorium, BITS Pilani",
      price: "FREE",
      attendees: 220,
      organizer: MockEventOrganizer(name: "E-Cell BITS Pilani", verified: true),
      tags: ["Startup", "Pitch", "Networking"],
      isRsvpd: false,
    ),
  ];

  static final List<MockOpportunity> opportunities = [
    MockOpportunity(
      id: "o1",
      title: "UI/UX Designer for AI Study Buddy App",
      type: "Hackathon Team",
      deadline: "3 days left",
      skills: ["Figma", "UI/UX", "Prototyping"],
      author: MockUser(id: "u3", name: "Rahul Dev", handle: "@rahuld", avatar: "https://picsum.photos/seed/rahul/200/200", college: "NIT Trichy", role: "Student", verified: false),
    ),
    MockOpportunity(
      id: "o2",
      title: "Research Assistant – NLP Lab",
      type: "Research",
      deadline: "2 weeks left",
      skills: ["Python", "NLP", "PyTorch"],
      author: MockUser(id: "u5", name: "Prof. Ananya", handle: "@ananya_prof", avatar: "https://picsum.photos/seed/ananya/200/200", college: "IIT Bombay", role: "Professor", verified: true),
    ),
    MockOpportunity(
      id: "o3",
      title: "Backend Dev for FinTech Startup",
      type: "Startup",
      deadline: "1 week left",
      skills: ["Node.js", "PostgreSQL", "AWS"],
      author: MockUser(id: "u6", name: "Startup Founders", handle: "@startupf", avatar: "https://picsum.photos/seed/startup/200/200", college: "IIT Delhi", role: "Student", verified: false),
    ),
  ];
}
