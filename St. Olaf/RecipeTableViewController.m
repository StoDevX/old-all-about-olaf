//
//  CustomTableViewController.m
//  CustomTable
//
//  Created by Simon on 7/12/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "RecipeTableCell.h"
#import "RecipeDetailViewController.h"
#import "Recipe.h"

@interface RecipeTableViewController ()

@end

@implementation RecipeTableViewController
@synthesize searchResults;
@synthesize recipes;
@synthesize myInt;
@synthesize addWord;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialize the recipes array
    // NOTE: a hack has been implemented here....we check if a recipe has the "first" or "last" text in their position. Update as needed
    // also, fix the counting (as in some of the defs are listed out-of-order but are in order in the dictionary) if you feel so inclined.
    
    
    // Handling the plus button being pushed
    addWord.target = self;
    addWord.action = @selector(addWord:);
    
    // Hide the button as necessary as we are not finished
    //[self.navigationItem setRightBarButtonItems:nil animated:YES];
    
    /***********************************
     A
     **********************************/
    Recipe *recipe1 = [Recipe new];
    recipe1.name = @"AAC";
    recipe1.ingredients = [NSArray arrayWithObjects:@"The Academic Advising Center provides support in exploring academic goals within the context of possible career and life-long goals. The Center supports both faculty advisors and their advisees in providing the necessary information and skills to fulfill graduation, general education and major requirements. The Center also assists students in exploring possible major options, in changing faculty advisors, in using a degree audit, class/lab schedule, and the St. Olaf Catalog for necessary information about fulfilling requirements. Academic Peer Advisors assist the Center.", nil];
    recipe1.position = @"first";
    
    Recipe *recipe2 = [Recipe new];
    recipe2.name = @"ACE";
    recipe2.ingredients = [NSArray arrayWithObjects:@"Academic Civic Engagement is an approach to teaching and learning that encourages students to learn in community contexts. Students consider community-based experiences in relation to classroom learning and apply academic knowledge and skills to strengthen communities as an integrated component of an academic course.", nil];
    
    Recipe *recipe151 = [Recipe new];
    recipe151.name = @"ACM";
    recipe151.ingredients = [NSArray arrayWithObjects:@"The Association for Computing Machinery is an international organization supporting the field of Computer Science. The recently accredited student chapter at St. Olaf aims to foster the computing community on campus through social events, workshops, talks, contests, demonstrations, tutoring, and community service. The activities and overall direction of the ACM are largely determined by the student members.", nil];
    
    Recipe *recipe3 = [Recipe new];
    recipe3.name = @"ADC";
    recipe3.ingredients = [NSArray arrayWithObjects:@"ADC stands for the After Dark Committee. As part of the Student Government Association, ADC is responsible for planning events for the student body. As the name describes, the committee handles events after dark. They plan events in the 10pm-2am time slot. Events have included paint parties in the Pause, Laser Tag, dances, and much more!", nil];
    
    Recipe *recipe4 = [Recipe new];
    recipe4.name = @"Admissions";
    recipe4.ingredients = [NSArray arrayWithObjects:@"This is where the St. Olaf journey begins. The Admissions Office guides future Ole prospects to see all the good in St. Olaf.", nil];
    
    Recipe *recipe5 = [Recipe new];
    recipe5.name = @"Alias";
    recipe5.ingredients = [NSArray arrayWithObjects:@"The term for a group of email addresses made for an easier way to mass email. Professors use aliases for easy communication with their classes and students use aliases for easy communications with student organizations they participate in.", nil];
    
    Recipe *recipe6 = [Recipe new];
    recipe6.name = @"Agnes A Cappella ";
    recipe6.ingredients = [NSArray arrayWithObjects:@"The female student a cappella group on campus. This is a very competitive group to become a part of because they are so highly liked by all of campus. The group holds concerts open to the public throughout the year. The campus favorite is the Holiday Concert where Agnes and the Limestones perform together.", nil];
    
    Recipe *recipe7 = [Recipe new];
    recipe7.name = @"Amcon";
    recipe7.ingredients = [NSArray arrayWithObjects:@"Short for American Conversations, an interdisciplinary General Education program and learning community in which students  analyze America’s history and culture.  Over four successive semesters in their first and sophomore years, Amcon students encounter many of the texts, topics, and historical developments that have defined “America” from its earliest colonization to the present. Amcon students make up a true academic community, living in a common dorm in their first year and complementing their in-class education with dinners, informal gatherings and field trips. Through the inclusion of an academic civic engagement component, moreover, students develop as active citizens, bringing their ideas and energy into the larger community.", nil];
    
    Recipe *recipe8 = [Recipe new];
    recipe8.name = @"ARMS";
    recipe8.ingredients = [NSArray arrayWithObjects:@"“American Racial and Multicultural Studies” is a program committed to the study of racial and cultural diversity within the United States. The major introduces students to the cultures, histories, and experiences of African Americans, Native Americans, Latinos, Asian Americans, and people of Middle Eastern descent.", nil];
    
    Recipe *recipe9 = [Recipe new];
    recipe9.name = @"ASC";
    recipe9.ingredients = [NSArray arrayWithObjects:@"The professional and student staff in the Academic Support Center is committed to working with students to help facilitate an understanding of what it means to fully participate in the academic experience at St. Olaf. Students interested in examining their own learning and study strategies as well as effective study, efficient time use, writing clearly, taking valuable notes, constructive class and test preparation, or other components of their plan to be a better student are encouraged to make an appointment or attend My Plan: Academic Strategies on the first and third Saturdays of every month. Call ext. 3288 with questions.", nil];
    
    /***********************************
                    B
     **********************************/
    Recipe *recipe10 = [Recipe new];
    recipe10.name = @"BASICS";
    recipe10.ingredients = [NSArray arrayWithObjects:@"BASICS is a “drinker’s checkup” that helps you examine your use, identify changes that could work for you and reduce your risk of future problems. It’s not therapy or substance abuse treatment. Any student who’s concerned about their alcohol or other drug use can choose to attend BASICS. Students who violate St. Olaf’s alcohol and drug policies, are medically transported for alcohol or drug intoxication, held in protective custody, or are court-sanctioned may be mandated to attend BASICS.", nil];
    
    Recipe *recipe11 = [Recipe new];
    recipe11.name = @"Black and Gold Gala";
    recipe11.ingredients = [NSArray arrayWithObjects:@"The Alumni Board hosts this annual opportunity for alumni, parents, and friends of St. Olaf College to enjoy an evening of dinner and dancing while supporting current students. The event also features a silent auction in which all proceeds go directly into the St. Olaf Fund.", nil];
 
    Recipe *recipe12 = [Recipe new];
    recipe12.name = @"Board of Regents";
    recipe12.ingredients = [NSArray arrayWithObjects:@"The St. Olaf Board of Regents manages and directs the business and affairs of the college. Among its many responsibilities, the board ultimately oversees the academic integrity of the college by appointing the president, awarding tenure to the faculty upon the president’s nomination, and adopting policies that establish the rights and obligations of faculty members.", nil];
    
    Recipe *recipe13 = [Recipe new];
    recipe13.name = @"Boe Chapel";
    recipe13.ingredients = [NSArray arrayWithObjects:@"Dedicated in 1954, Boe is meant to be a place for worship, music, edifying convocations, college ceremonies, the arts and private meditation. Daily Chapel takes place here during a break from classes.", nil];
    
    Recipe *recipe14 = [Recipe new];
    recipe14.name = @"Boe House";
    recipe14.ingredients = [NSArray arrayWithObjects:@"Boe House houses the Counseling Center, which was established by St. Olaf College to enhance the personal growth and development of its students. The Center supports students in their academic pursuits and facilitates personal and interpersonal learning and growth. The Counseling Center is open during the academic year from 8:00 a.m. to 12:00 noon and from 1:00 p.m. to 5:00 p.m., Monday through Friday.", nil];
    
    Recipe *recipe15 = [Recipe new];
    recipe15.name = @"The Book";
    recipe15.ingredients = [NSArray arrayWithObjects:@"The official student planner of St. Olaf College. The Book contains college policies, schedules, and information related to student life, academic and non-academic, at St. Olaf in addition to being a full year, calendar planner. SGA produces The Book each year.", nil];
    
    Recipe *recipe16 = [Recipe new];
    recipe16.name = @"Bookstore";
    recipe16.ingredients = [NSArray arrayWithObjects:@"Home to all textbooks, Ole gear, school supplies, and more, the Bookstore is conveniently located on the first floor of Buntrock Commons.", nil];
    
    Recipe *recipe17 = [Recipe new];
    recipe17.name = @"BORSC";
    recipe17.ingredients = [NSArray arrayWithObjects:@"As a branch of the Student Government Association, the Board of Regents Student Committee facilitates communication between the student body and the Board of Regents of the college. A primary responsibility of BORSC is to represent student concerns regarding the long range planning of the college, especially those aspects directly managed by the Board of Regents.", nil];
    
    
    /***********************************
                    C
     **********************************/
    
    Recipe *recipe19 = [Recipe new];
    recipe19.name = @"The Caf";
    recipe19.ingredients = [NSArray arrayWithObjects:@"The shortened version of “Cafeteria,” Stav Hall is located on the third floor of Buntrock Commons. Students get to dine with the best food in the nation.", nil];
    
    Recipe *recipe20 = [Recipe new];
    recipe20.name = @"Caf Date";
    recipe20.ingredients = [NSArray arrayWithObjects:@"One of the most common “dates” on campus. Couples can cozy up in the window booths or sit in the middle of the Caf for everyone to see!", nil];

    Recipe *recipe21 = [Recipe new];
    recipe21.name = @"The Cage";
    recipe21.ingredients = [NSArray arrayWithObjects:@"In the center of Buntrock Commons, the campus coffee shop and grill offers all-day breakfast, hot and cold sandwiches and plate-sized cookies in a lively setting. It’s the perfect place to meet friends or a study group!", nil];
    
    Recipe *recipe22 = [Recipe new];
    recipe22.name = @"Career Network for Oles";
    recipe22.ingredients = [NSArray arrayWithObjects:@"Designed by the Piper Center for Vocation and Career in conjunction with President David R. Anderson ’74 and the Office of Alumni and Parent Relations. The program connects St. Olaf juniors and seniors with the College’s alumni and parent community in meaningful and substantive ways in order to give students a chance to learn about careers, internships and jobs in their fields of interest while providing alumni and parents the opportunity to share their professional experiences and expertise.", nil];
 
    Recipe *recipe23 = [Recipe new];
    recipe23.name = @"Christiansen Hall of Music";
    recipe23.ingredients = [NSArray arrayWithObjects:@"Christiansen (pronounced kris-tee-AHN-sen) Hall of Music is home to the Music Department and the Music Organizations staff that supports concerts and tours by the ensembles. Named after St. Olaf Choir founder F. Melius Christiansen, the building houses Urness Recital Hall, the Margaret Skoglund Reception Room, the Halvorson Music Library, three rehearsal rooms, classrooms, practice rooms, faculty studios, and the electronic music studio.", nil];
    
    Recipe *recipe24 = [Recipe new];
    recipe24.name = @"Christmas Festival";
    recipe24.ingredients = [NSArray arrayWithObjects:@"As one of the oldest musical celebrations of Christmas in the United States, Christmas Fest was started in 1912 by F. Melius Christiansen, founder of the St. Olaf College Music Department. The festival features more than 500 student musicians who are members of five choirs (St. Olaf Choir, Viking Chorus, Chapel Choir, Cantorei, and Manitou Singers) and the St. Olaf Orchestra. The festival, which is regularly broadcast nationwide on public television and radio, has been featured in hundreds of publications, including TV Guide, Wall Street Journal, and the Los Angeles Times.", nil];

    Recipe *recipe25 = [Recipe new];
    recipe25.name = @"Club sports";
    recipe25.ingredients = [NSArray arrayWithObjects:@"An opportunity for athletes to participate in a variety of sports and recreational activities that are not a part of the program of NCAA intercollegiate sports administered by the St. Olaf Athletics Department. Club sports include: Cycling, Men’s Hockey, Men’s Lacrosse, Men’s Rugby, Men’s Volleyball, Men’s Ultimate, Rowing, Women’s Lacrosse, Women’s Rugby, and Women’s Ultimate.", nil];
    
    Recipe *recipe26 = [Recipe new];
    recipe26.name = @"Companydance";
    recipe26.ingredients = [NSArray arrayWithObjects:@"A project-based student dance company that offers a range of performing opportunities and is open by audition to all students. The company’s primary aesthetic is grounded in the modern dance tradition, but is by no means restricted to it.", nil];
    
    Recipe *recipe27 = [Recipe new];
    recipe27.name = @"Conversation Tables";
    recipe27.ingredients = [NSArray arrayWithObjects:@"As part of the Foreign Language GE, students attend weekly dinner tables to work on their “conversation” skills in the language they are studying.", nil];
    
    /***********************************
                    D
     **********************************/
    
    Recipe *recipe28 = [Recipe new];
    recipe28.name = @"DCC";
    recipe28.ingredients = [NSArray arrayWithObjects:@"The Diversity Celebrations Committee is a branch of the Student Government Association (SGA) that provides entertaining and educational experiences that support St. Olaf College’s commitment to integrate diverse perspectives. The purpose of these events is to provide students with exposure to diverse cultures, communities, and ethnicities and celebrate these cultures.", nil];
    
    Recipe *recipe29 = [Recipe new];
    recipe29.name = @"Daily Chapel";
    recipe29.ingredients = [NSArray arrayWithObjects:@"With different speakers every day, daily chapel is a time of inspiration for body, mind and spirit; a quiet harbor in a busy day; worship. Students, faculty and staff witness to their faith and invite the community to join them. All are welcome!", nil];

    Recipe *recipe30 = [Recipe new];
    recipe30.name = @"Dean of Students";
    recipe30.ingredients = [NSArray arrayWithObjects:@"The deans coordinate and direct services and programs designed to assist students in taking full advantage of their St. Olaf experience, both in and out of the classroom. The Dean of Students Office Suite is home to the Vice President, Dean of Students, the Associate Deans and Residence Life.", nil];
    
    Recipe *recipe32 = [Recipe new];
    recipe32.name = @"The Den";
    recipe32.ingredients = [NSArray arrayWithObjects:@"Home to the Lion’s Pause Pool table and Sports Center vibe, the Den is located in Buntrock Commons in the Pause where students go to relax, eat, and catch the game on TV.", nil];
    
    Recipe *recipe33 = [Recipe new];
    recipe33.name = @"Dinner Debate";
    recipe33.ingredients = [NSArray arrayWithObjects:@"The Political Awareness Committee (PAC) plans and hosts dinner debates in which students can bring their caf trays and go, listen, and participate in debates on a variety of issues on campus.", nil];
    
    Recipe *recipe34 = [Recipe new];
    recipe34.name = @"Dittmann Center";
    recipe34.ingredients = [NSArray arrayWithObjects:@"Before Buntrock Commons was built, Dittmann was the student center. By adding more natural lighting with strategic window placement, Dittmann is now home to the Studio Art, Art History and Dance Department. The building also houses the Flaten Art Museum.", nil];
    
    Recipe *recipe35 = [Recipe new];
    recipe35.name = @"Drag Ball";
    recipe35.ingredients = [NSArray arrayWithObjects:@"For one night every year, the Drag Ball gives students a chance to abandon dress codes, gender roles and inhibitions in celebration of cross-dressing. This popular event is hosted in the Pause Mane Stage!", nil];
    
    /***********************************
                    E
     **********************************/
    
    Recipe *recipe36 = [Recipe new];
    recipe36.name = @"E-Check Up to Go (e-chug)";
    recipe36.ingredients = [NSArray arrayWithObjects:@"An interactive web survey that allows college and university students to enter information about their drinking patterns and receive feedback about their use of alcohol. The confidential assessment takes about 7-8 minutes to complete, is self-guided, and requires no face-to-face contact time with a counselor.", nil];
    
    Recipe *recipe37 = [Recipe new];
    recipe37.name = @"E-Toke";
    recipe37.ingredients = [NSArray arrayWithObjects:@"The Marijuana e-CheckUpToGo is an interactive web survey that allows college and university students to enter information about their marijuana habits and receive feedback about their use of marijuana. The confidential assessment takes about 7-8 minutes to complete, is self-guided, and requires no face-to-face contact time with a counselor or administrator.", nil];
    
    Recipe *recipe38 = [Recipe new];
    recipe38.name = @"Early Music Singers";
    recipe38.ingredients = [NSArray arrayWithObjects:@"Consists of 14-20 singers and focuses primarily on music of the Medieval, Renaissance, and Baroque eras. The choir performs a concert each semester in collaboration with the St. Olaf Collegium Musicum, St. Olaf’s early instrument ensemble.", nil];
    
    Recipe *recipe39 = [Recipe new];
    recipe39.name = @"Elections (SGA)";
    recipe39.ingredients = [NSArray arrayWithObjects:@"Every fall and spring, the Student Government Association hold elections for positions within SGA and Student Senate. Check out Oleville for more info!", nil];

    Recipe *recipe40 = [Recipe new];
    recipe40.name = @"Ellingson";
    recipe40.ingredients = [NSArray arrayWithObjects:@"As a four-story first-year residence hall, Ellingson houses 198 students. Spacious lounges enable students to study and relax at ease.", nil];

    /***********************************
                    F
     **********************************/
    
    Recipe *recipe41 = [Recipe new];
    recipe41.name = @"Fall concert";
    recipe41.ingredients = [NSArray arrayWithObjects:@"Each fall, the Music Entertainment Committee (MEC) hosts an up and coming talent concert. Recent fall concerts have been Girl Talk, OK Go, The Hold Steady, and Brother Ali.", nil];
    
    Recipe *recipe42 = [Recipe new];
    recipe42.name = @"FCO";
    recipe42.ingredients = [NSArray arrayWithObjects:@"Fellowship of Christian Oles (FCO) is a group of people who gather once a week to discuss ideas, worship together, and share in the joy of Christ-centered relationships. We are a community striving to live as Christ calls us to live, with a heart for outreach in our own St. Olaf community and beyond. Through small groups, weekly meetings, and service trips we build relationships, welcoming people in all walks of Christian faith.", nil];
    
    Recipe *recipe43 = [Recipe new];
    recipe43.name = @"Fireside";
    recipe43.ingredients = [NSArray arrayWithObjects:@"Located on the second floor of Buntrock Commons, it is a place to lounge, study, and enjoy yourself. During the winter months, fires can be made in the fireplace!", nil];
 
    Recipe *recipe44 = [Recipe new];
    recipe44.name = @"Fram! Fram!";
    recipe44.ingredients = [NSArray arrayWithObjects:@"King Olav’s (Olaf’s) battle cry, “Fram, Fram, Kristmenn, Krossmen” can be found on the St. Olaf College crest.", nil];

    Recipe *recipe45 = [Recipe new];
    recipe45.name = @"Fresh Faces";
    recipe45.ingredients = [NSArray arrayWithObjects:@"A Deep End production for first-years. Fresh Faces is an opportunity to be in all first-years cabaret featuring acting scenes, dance numbers, musical pieces from popular theater.", nil];
    
    Recipe *recipe46 = [Recipe new];
    recipe46.name = @"Friday flowers";
    recipe46.ingredients = [NSArray arrayWithObjects:@"One of the most popular traditions for students! Each Friday, a local florist sells single flowers for students to buy and put in each other’s p.o. boxes. The p.o. boxes are wonderful to walk by to see all the flowers sticking out!", nil];
    
    /***********************************
                    G
     **********************************/
    
    Recipe *recipe47 = [Recipe new];
    recipe47.name = @"Global Semester";
    recipe47.ingredients = [NSArray arrayWithObjects:@"One of the most popular and well known study abroad programs. The Global Semester is a five-month academic program offering five courses in different parts of the world under the supervision of St. Olaf faculty. In cooperation with academic institutions in four countries, courses are designed to enable students to develop windows on the world from distinct academic perspectives through class lectures, field trips, and other activities. The program aims to facilitate immersion in the daily life of each community and develop comparisons with American society. The itinerary takes the group around the world with visits to Switzerland (the United Nations Headquarters in Geneva), Egypt, India, Thailand, Hong Kong, China and South Korea", nil];

    Recipe *recipe48 = [Recipe new];
    recipe48.name = @"GLOW!";
    recipe48.ingredients = [NSArray arrayWithObjects:@"Gay, Lesbian, or Whatever! is a student organization comprised of gay, lesbian, bisexual, transgender, and heterosexual persons. GLOW! helps to educate, provide resources for and foster acceptance and support for self-identified GLBT persons with and through the alliance of all sexual orientations and gender identities.", nil];
    
    Recipe *recipe49 = [Recipe new];
    recipe49.name = @"Gospel choir";
    recipe49.ingredients = [NSArray arrayWithObjects:@"A choir open to any student who wants to join! Rehearsals are held once a week.", nil];
    
    Recipe *recipe50 = [Recipe new];
    recipe50.name = @"Great Con";
    recipe50.ingredients = [NSArray arrayWithObjects:@"An integrated sequence of five courses taken over two years, the Great Conversation (Great Con) introduces students to the major epochs of Western tradition through direct encounter with significant works. Beginning with the ancient Greeks and Hebrews, the program traces the development of literary and artistic expression, philosophic thought, religious belief, and historical reflections on western culture into the modern world. Students respond to great works, challenging the ideas expressed in them and challenging their own ideas as well, thus joining the conversation of men and women through the ages about the perennial issues of human life.", nil];
    
    Recipe *recipe51 = [Recipe new];
    recipe51.name = @"Green Bikes";
    recipe51.ingredients = [NSArray arrayWithObjects:@"The Green Bikes Mechanics team maintains bicycles for use by anyone in the St. Olaf community as part of the campus transportation infrastructure. These 19 bikes are available for speeding you to class on time, down to Northfield and Carleton or further out of town for fun and exercise. Check one out at Rolvaag Library!", nil];
    
    /***********************************
                     H
     **********************************/
    
    Recipe *recipe52 = [Recipe new];
    recipe52.name = @"Health Services";
    recipe52.ingredients = [NSArray arrayWithObjects:@"Located on the first floor of Tomson Hall, it is staffed by a certified family nurse practitioner and support staff who collaborate as needed with physicians at the Northfield Hospital Emergency Department. During the school year the office is open to students Monday- Friday, 9:00 – 11:30 a.m. and 1:00 – 4:00 p.m.", nil];
    
    Recipe *recipe53 = [Recipe new];
    recipe53.name = @"Her Campus";
    recipe53.ingredients = [NSArray arrayWithObjects:@"A branch of HerCampus.com, this student organization is a weekly online magazine for the women of St. Olaf. The organization covers all topics from cuties on campus to cooking on campus to the latest and greatest fashion trends.", nil];

    Recipe *recipe54 = [Recipe new];
    recipe54.name = @"Hill/Kitt";
    recipe54.ingredients = [NSArray arrayWithObjects:@"Since Hilleboe Hall and Kittelsby Hall are connected by the same entrance, the 2 halls have received a joint name as well: Hill/Kitt.", nil];
    
    Recipe *recipe55 = [Recipe new];
    recipe55.name = @"Hill";
    recipe55.ingredients = [NSArray arrayWithObjects:@"St. Olaf College sits above the city of Northfield on a hill, so one can often hear the college being referred to as the “Hill.” How are things going on the Hill today?", nil];
  
    Recipe *recipe56 = [Recipe new];
    recipe56.name = @"Hilleboe";
    recipe56.ingredients = [NSArray arrayWithObjects:@"Hilleboe houses 123 (upper-class) students while maintaining the largest triple rooms on campus. The Hilleboe Chapel, study lounges, computer facilities, and recreational lounges all provide students with opportunities for studying, learning, and socializing.", nil];
    
    Recipe *recipe57 = [Recipe new];
    recipe57.name = @"Holland";
    recipe57.ingredients = [NSArray arrayWithObjects:@"Home to the Economics, History, Nursing, Philosophy, Political Science, Social Work, and Sociology/Anthropology Department, Holland Hall is a Norman Gothic building that serves as an architectural landmark on campus. The structure and decor of Holland are modeled after Mont-Saint-Michel, a famous monastery in France.", nil];
    
    Recipe *recipe58 = [Recipe new];
    recipe58.name = @"Homecoming";
    recipe58.ingredients = [NSArray arrayWithObjects:@"Every fall the Student Activities Committee (SAC) plans and hosts events, games, and activities for students during the week of Homecoming! The Alumni Office plans the festive weekend as the St. Olaf Community gathers for a fun-filled weekend of reconnection, celebration, and activity. Parents of current students and alumni from all classes, come back to the Hill and take part in the many hallmarks of campus life: learning with faculty members, athletic events and music concerts, worship, a campus festival for all ages, and more.", nil];
    
    Recipe *recipe59 = [Recipe new];
    recipe59.name = @"Honor House";
    recipe59.ingredients = [NSArray arrayWithObjects:@"The college maintains 19 campus houses that are available for upper-class student housing. These houses provide students with alternative opportunities to explore and develop interests and personal relationships through a more intimate residential setting.", nil];
    
    Recipe *recipe60 = [Recipe new];
    recipe60.name = @"Hoyme";
    recipe60.ingredients = [NSArray arrayWithObjects:@"Hoyme (pronounced Hoy·me) Hall is a four-story hall housing 210 first-year students. The main lounge provides a striking view of the surrounding countryside as well as a wonderful space for studying and socializing.", nil];
    
    /***********************************
     I
     **********************************/
    
    Recipe *recipe61 = [Recipe new];
    recipe61.name = @"IT";
    recipe61.ingredients = [NSArray arrayWithObjects:@"For all things technical, The Information and Instructional Technologies offers a campus-wide network of computing facilities that includes Macintosh, PC-compatibles, and UNIX/Linux-based systems. The Helpdesk in Rolvaag Memorial Library is available for students and faculty alike.", nil];
    
    Recipe *recipe62 = [Recipe new];
    recipe62.name = @"Interim";
    recipe62.ingredients = [NSArray arrayWithObjects:@"The Interim is a four-week period of intensive study in one area. Interim provides an opportunity for a professor and his or her students to focus their entire attention on one course for a full month, to offer a time of study in depth. It is a time when unique teaching and learning styles can be utilized in rather traditional courses or when unique subjects can be studied in some international or off-campus domestic location. Interim is a very popular time for study abroad!", nil];
    
    Recipe *recipe63 = [Recipe new];
    recipe63.name = @"Intramurals";
    recipe63.ingredients = [NSArray arrayWithObjects:@"For all students who want to participate in some team sport, but maybe want something a little less demanding — Intramurals provide weekly games year round. Grab a team, sign-up, and play!", nil];
    
    /***********************************
     J
     **********************************/
    
    Recipe *recipe64 = [Recipe new];
    recipe64.name = @"JC";
    recipe64.ingredients = [NSArray arrayWithObjects:@"A Junior Counselor (JC) is an upper-class student who works in a pair to build community in first-year residence halls. JC’s are responsible for the floor they live on in addition to the overall hall camaraderie.", nil];

    Recipe *recipe65 = [Recipe new];
    recipe65.name = @"Jungle";
    recipe65.ingredients = [NSArray arrayWithObjects:@"This giant, light-filled room in the Lion’s Pause is the perfect place to eat your delicious Pause pizza with your friends! The 2  TVs and booths are just a bonus.", nil];
    
    /***********************************
     K
     **********************************/
    
    Recipe *recipe66 = [Recipe new];
    recipe66.name = @"KSTO";
    recipe66.ingredients = [NSArray arrayWithObjects:@"KSTO is a student-run radio station that broadcasts over the airwaves on campus at 93.1 FM. Listeners can access KSTO through the online stream and eventually through their iPhone application.", nil];
    
    Recipe *recipe67 = [Recipe new];
    recipe67.name = @"Kierkegaard";
    recipe67.ingredients = [NSArray arrayWithObjects:@"Søren Aabye Kierkegaard (pronounced Kier·ke·gaard) was a 19th-century Danish philosopher. In Rolvaag Memorial Library, The Howard V. and Edna H. Hong Kierkegaard Library began as the private collection of its founders who used it to support their work translating the writings of Søren Kierkegaard from Danish into English. In 1976, the Hongs gave the Library to St. Olaf College with the understanding that it would exist as a study and publication center, a place where students and scholars of varied experience could come and have access to materials in an environment enhancing their intellectual work.", nil];
    
    Recipe *recipe68 = [Recipe new];
    recipe68.name = @"Kildahl";
    recipe68.ingredients = [NSArray arrayWithObjects:@"Kildahl (pronounced Kil·dahl) Hall offers a friendly, comfortable atmosphere for 168, first-year students. The main lounge serves as the center of community, offering many activities and late night conversations around the fireplace. Kildahl is equipped with computer facilities and a strong community that is ideal for studying and socializing.", nil];
    
    Recipe *recipe69 = [Recipe new];
    recipe69.name = @"Kitchen (Pause)";
    recipe69.ingredients = [NSArray arrayWithObjects:@"The student-run, full kitchen offers tasty eats at ridiculously low prices. Famous pizzas, quesadillas, shakes, and ice cream all made-to-order! The kitchen is open late to serve that “late-night” craving! Hours are Sunday - Thursday: 10:30am - Midnight, and Friday - Saturday: 10:30am - 2am (shortened menu after 9pm on Fridays and Saturdays).", nil];
    
    Recipe *recipe70 = [Recipe new];
    recipe70.name = @"Kittelsby";
    recipe70.ingredients = [NSArray arrayWithObjects:@"Kittelsby (pronounced Kittels·bee) Hall houses students 238 (first-year) students in triple rooms and is connected to Hilleboe Hall. The unique connection to Hilleboe Hall is unlike any of the other first-year dorms.", nil];
    
    /***********************************
     L
     **********************************/
    
    Recipe *recipe71 = [Recipe new];
    recipe71.name = @"Lair";
    recipe71.ingredients = [NSArray arrayWithObjects:@"The small, quaint, transformable room in the Lion’s Pause used for studying during the day and events at night!", nil];
    
    Recipe *recipe72 = [Recipe new];
    recipe72.name = @"Larson";
    recipe72.ingredients = [NSArray arrayWithObjects:@"Larson Hall houses 307 upper-class students. The circular arrangement of each floor creates a strong community atmosphere.", nil];
    
    Recipe *recipe73 = [Recipe new];
    recipe73.name = @"Late night breakfast";
    recipe73.ingredients = [NSArray arrayWithObjects:@"During finals week, each semester, one night is scheduled for breakfast food in Stav served by faculty and staff. This is a great break from studying and is one of the students favorite traditions!", nil];
    
    Recipe *recipe74 = [Recipe new];
    recipe74.name = @"Leaders for Social Change";
    recipe74.ingredients = [NSArray arrayWithObjects:@"A summer program that compliments a St. Olaf education by providing an opportunity for students to complete a community-based internship or research project in Northfield or the Twin Cities while participating in ongoing academic and vocational reflection with faculty, staff, community leaders and alumni. Student participants explore connections between theory and practice, discern their vocations and gain professional skills that will prepare them to foster the common good in future civic and work roles.", nil];
    
    Recipe *recipe75 = [Recipe new];
    recipe75.name = @"Libraries";
    recipe75.ingredients = [NSArray arrayWithObjects:@"The St. Olaf collection, housed in three separate libraries (Rølvaag Memorial Library, Hustad Science Library, and Halvorson Music Library), includes approximately 420,000 books, 22,000 media items, 5000 periodical titles, and 18,000 scores.", nil];
    
    Recipe *recipe76 = [Recipe new];
    recipe76.name = @"Limestones";
    recipe76.ingredients = [NSArray arrayWithObjects:@"The famous, seven-voice male a cappella group founded in 1989. The Limestones have grown over the years, working through an exciting evolution of a cappella singing. They have incorporated a more contemporary pop style of music, and have performed throughout the Midwest for schools, businesses, private functions, and have also performed in such places as The Ordway Center in St. Paul, MN and on Garrison Keillor’s Prairie Home Companion.", nil];
    
    /***********************************
     M
     **********************************/
    
    Recipe *recipe77 = [Recipe new];
    recipe77.name = @"MEC";
    recipe77.ingredients = [NSArray arrayWithObjects:@"The Music Entertainment Committee, a branch of the Student Government Association (SGA), devotes its time to organizing diverse concerts, music events, and other forms of music entertainment that cater to the varied interests of St. Olaf students. The purpose of these events is to provide students an escape from academic pressure and to give them an opportunity to become involved in campus life. MEC plans and hosts the fall and spring concerts each year where larger name acts perform!", nil];
    
    Recipe *recipe78 = [Recipe new];
    recipe78.name = @"Mane Stage";
    recipe78.ingredients = [NSArray arrayWithObjects:@"The Mane Stage is the Pause’s nightclub venue, hosting late-night events for the student body. Modeled after the legendary First Avenue in Minneapolis, this space hosts dances, concerts, student performances, and comedians on a continuous basis.", nil];
    
    Recipe *recipe79 = [Recipe new];
    recipe79.name = @"Manitou Messenger";
    recipe79.ingredients = [NSArray arrayWithObjects:@"Founded in 1887, the student newspaper has an intimate staff and a large pool of writers that produce a weekly issue of the paper. The different sections cover the many topics of life on campus as well as national and global news.", nil];
    
    Recipe *recipe80 = [Recipe new];
    recipe80.name = @"Manitou Singers";
    recipe80.ingredients = [NSArray arrayWithObjects:@"Comprised of select women’s voices from the first year class, Manitou (pronounced Man·it·toe) is one of the most popular music organizations on the St. Olaf College campus. The 100-voice choir sings at the opening worship service of the college as well as at various campus functions throughout the year such as daily chapel and church services, the annual St. Olaf Christmas Festival, Family Weekend Concert and its own Spring concert in April. With a repertoire that ranges from sacred to secular to popular ballads, the Manitou Singers have broad appeal both on and off campus.", nil];
    
    Recipe *recipe81 = [Recipe new];
    recipe81.name = @"Mellby";
    recipe81.ingredients = [NSArray arrayWithObjects:@"Housing 192 upper classmen, Mellby (pronounced Mell·bee) is the oldest residence hall on campus and its historic appeal truly stands out. It features a kitchen, TV lounge, computer facilities and a large, comfortable main lounge and fireplace.", nil];
    
    Recipe *recipe82 = [Recipe new];
    recipe82.name = @"Mohn";
    recipe82.ingredients = [NSArray arrayWithObjects:@"One of the two towers on campus, Mohn (pronounced Moan) is a ten-story residence hall housing 307 students. The hall, which traditionally houses first-year and sophomore students by floor, offers a main lounge, a recreational room, and a piano room. The circular arrangement of each corridor creates a strong community atmosphere.", nil];
    
    Recipe *recipe83 = [Recipe new];
    recipe83.name = @"Moodle";
    recipe83.ingredients = [NSArray arrayWithObjects:@"An online program that faculty and students use for classes. Professors can upload a syllabus, calendar, notes, readings, assignments, and quizzes for students to access at their convenience.", nil];
    
    Recipe *recipe84 = [Recipe new];
    recipe84.name = @"Multicultural Affairs";
    recipe84.ingredients = [NSArray arrayWithObjects:@"Provides services and assistance to Asian American, African American, Hispanic/Latino American, and Native American Students. MCA provides academic, financial, personal, career, social counseling and support as needed while also promoting the intellectual, social and moral development of all students on campus through the advancement and understanding of culture and heritage.", nil];
    
    /***********************************
     N
     **********************************/
    
    Recipe *recipe85 = [Recipe new];
    recipe85.name = @"Natural Lands";
    recipe85.ingredients = [NSArray arrayWithObjects:@"In addition to a 300-acre campus, the college owns nearly 700 acres of land adjacent to the campus. Most of this land was farmland rented out to local farmers. The college, principally through the members of the Biology and the Environmental Studies Departments, has conducted extensive natural habitat restoration projects over the past 15 years on some of this farmland. Over 40,000 tree seedlings and nursery stock trees have been planted on approximately 90 acres in an effort to re-establish the dominant Big Woods forest type originally found in our area. Over 150 acres of native, tall grass prairie has been reconstructed and 15 wetlands have been restored. A bluebird trail of 64 houses has been established through our woodlands and prairies. In addition to natural habitat restoration, a sustainable agriculture project has also been ongoing for over 10 years.", nil];
    
    Recipe *recipe86 = [Recipe new];
    recipe86.name = @"Norseman";
    recipe86.ingredients = [NSArray arrayWithObjects:@"One of two symphonic bands at St. Olaf, Norseman (pronounced Norse·man) has developed a reputation in recent years as a dynamic and exciting concert ensemble. The 85-piece ensemble performs regularly on campus, and has toured each spring to regional locations in Minnesota, Iowa, Wisconsin, Illinois and Michigan, as well as to Canada. The membership of the Norseman Band reflects the broad spectrum of academic interests and geographical diversity of the St. Olaf student body.", nil];
    
    Recipe *recipe87 = [Recipe new];
    recipe87.name = @"Norwegian Sweaters";
    recipe87.ingredients = [NSArray arrayWithObjects:@"During the weekend of Christmas Festival, the number of Norwegian sweaters on campus is extraordinary. Oles of all ages embrace the Norwegian heritage while keeping warm! Looking for a Norwegian sweater? Find them in the Bookstore!", nil];
    
    /***********************************
     O
     **********************************/
    
    Recipe *recipe88 = [Recipe new];
    recipe88.name = @"Old Main";
    recipe88.ingredients = [NSArray arrayWithObjects:@"Built in 1877, Old Main was the first — and originally the only — building to occupy Manitou Heights, containing classrooms, a library, housing for students and faculty, and a dining room. Newly renovated, Old Main is a beautiful place for students to study or relax. During the winter the Hill is a popular place for sledding!", nil];
    
    Recipe *recipe89 = [Recipe new];
    recipe89.name = @"Ole Ave";
    recipe89.ingredients = [NSArray arrayWithObjects:@"St. Olaf Avenue, commonly referred to as “Ole Ave”, runs from campus all the way to Highway 3 near downtown Northfield.", nil];
    
    Recipe *recipe90 = [Recipe new];
    recipe90.name = @"Ole Spring Relief";
    recipe90.ingredients = [NSArray arrayWithObjects:@"The annual, large-scale service trip that takes place over the week of spring break. All students have the opportunity to sign-up and take part in this great trip!", nil];
    
    Recipe *recipe91 = [Recipe new];
    recipe91.name = @"Ole card";
    recipe91.ingredients = [NSArray arrayWithObjects:@"The all-in-one I.D. card for all students. The Ole Card is used to eat meals in the Caf, buy coffee and snacks at the Cage, get a sweet treat at the Pause, purchase school supplies at the Bookstore, print documents for class, AND get students into their halls at night. The Ole Card carries “Flex dollars” in addition to “Ole dollars.” Flex dollars is the amount of money a student has to use at the Cage, and only the Cage. Ole dollars is the amount of money a student puts on their own Ole Card. Students do not have to deposit money on their cards, but it makes for an easy transaction around campus.", nil];
    
    Recipe *recipe92 = [Recipe new];
    recipe92.name = @"Ole cookie";
    recipe92.ingredients = [NSArray arrayWithObjects:@"Similar to a “monster” cookie, The Cage sells delicious cookies with oats, peanut butter, and candy pieces all combined into one giant St. Olaf cookie!", nil];
    
    Recipe *recipe93 = [Recipe new];
    recipe93.name = @"Ole the Lion";
    recipe93.ingredients = [NSArray arrayWithObjects:@"The beloved mascot of St. Olaf.", nil];
    
    Recipe *recipe94 = [Recipe new];
    recipe94.name = @"Oleville";
    recipe94.ingredients = [NSArray arrayWithObjects:@"The official website of the Student Government Association (SGA). Oleville explains the various branches of SGA.", nil];
    
    Recipe *recipe95 = [Recipe new];
    recipe95.name = @"Orgs";
    recipe95.ingredients = [NSArray arrayWithObjects:@"Student Organizations are known around campus just as “orgs.” To become an organization, a club must apply to the Student Organizations Committee (SOC). Then, SOC is able to provide funding for the organization.", nil];
    
    /***********************************
     P
     **********************************/
    
    Recipe *recipe96 = [Recipe new];
    recipe96.name = @"PAC";
    recipe96.ingredients = [NSArray arrayWithObjects:@"The Political Awareness Committee is a branch of the Student Government Association (SGA) and is the primary student promoter of political awareness and activity on the St. Olaf campus. Committed to nonpartisan political education and activism, PAC seeks to serve all members of the St. Olaf student body as a political resource, ultimately making students into responsible and knowledgeable citizens. PAC brings in big-name speakers for very large events twice a year, known as the fall and spring speaker.", nil];
    
    Recipe *recipe97 = [Recipe new];
    recipe97.name = @"PDA";
    recipe97.ingredients = [NSArray arrayWithObjects:@"President David R. Anderson’s (’74) nickname around campus.", nil];
    
    Recipe *recipe98 = [Recipe new];
    recipe98.name = @"PO box";
    recipe98.ingredients = [NSArray arrayWithObjects:@"All students get a mailbox that is referred to as their “P.O.” Mailboxes are not locked because campus is known for being very safe, as all students are respectful of each other.", nil];
    
    Recipe *recipe99 = [Recipe new];
    recipe99.name = @"Pause";
    recipe99.ingredients = [NSArray arrayWithObjects:@"The Lion’s Pause, a branch of the Student Government Association (SGA),  is most commonly shortened to just the Pause. This is a student-run nightclub located on the first floor of Buntrock Commons. Students are lucky to have a facility like this at their disposal — very few other schools in the nation have such a nice space! The Pause consists of 5 rooms: The Den, Lair, Jungle, Kitchen, and Mane Stage. The Kitchen is a student-staffed kitchen serving pizza, shakes, and more.", nil];
    
    Recipe *recipe100 = [Recipe new];
    recipe100.name = @"Pep band";
    recipe100.ingredients = [NSArray arrayWithObjects:@"Provides musical entertainment and lead fan enthusiasm at St. Olaf football and basketball games. The students involved are dedicated to enhancing team support and the spirit of the crowds at games.", nil];
    
    Recipe *recipe101 = [Recipe new];
    recipe101.name = @"President's Ball";
    recipe101.ingredients = [NSArray arrayWithObjects:@"The President's Ball, otherwise known as Prez Ball, is an annual event planned by the Student Activities Committee and enjoyed by students, faculty, and staff alike. It is a chance to socialize with the President and his wife, enjoy hors’devours, and dance the night away. Live music all night, and dance lessons from the Ballroom Club make this a must-attend event!", nil];
    
    Recipe *recipe102 = [Recipe new];
    recipe102.name = @"Pub Safe";
    recipe102.ingredients = [NSArray arrayWithObjects:@"Provides 24-hour security services, patrol and response throughout the year. Public Safety is dedicated to the safety and protection of the entire St. Olaf community. Officers are charged with enforcing college policies as well as local and state laws where applicable, that occur on college property.", nil];
    
    /***********************************
     Q
     **********************************/
    
    Recipe *recipe103 = [Recipe new];
    recipe103.name = @"Quarry";
    recipe103.ingredients = [NSArray arrayWithObjects:@"The student-edited fine arts journal that publishes the best of St. Olaf students’ literary works and visual art. Fiction, creative non-fiction, and poetry are all featured alongside photography, paintings, and other forms of visual creative expression.", nil];
    
    Recipe *recipe104 = [Recipe new];
    recipe104.name = @"Quidditch";
    recipe104.ingredients = [NSArray arrayWithObjects:@"Since St. Olaf so closely resembles Hogwarts, it is only fair that we have a Quidditch club! The St. Olaf Quidditch Association brings the wonders of Quidditch to the St. Olaf campus on a weekly basis. With pick up games every week and the coveted House Cup, Quidditch provides the opportunity that everyone has always wanted.", nil];
    
    /***********************************
     R
     **********************************/
    
    Recipe *recipe105 = [Recipe new];
    recipe105.name = @"R25";
    recipe105.ingredients = [NSArray arrayWithObjects:@"The “room scheduling” program for all of campus, excluding the Lion’s Pause. This is an easy way to reserve rooms/places on campus from the convenience of your own computer.", nil];
    
    Recipe *recipe106 = [Recipe new];
    recipe106.name = @"RA";
    recipe106.ingredients = [NSArray arrayWithObjects:@"A Resident Assistant (RA) is an upper class student who builds community in upper-class residence halls.", nil];
    
    Recipe *recipe107 = [Recipe new];
    recipe107.name = @"Rand";
    recipe107.ingredients = [NSArray arrayWithObjects:@"Nestled into the north face of Manitou Heights, Rand Hall houses 243 upper-classmen. A variety of living options are available in Rand including single, double, and quad occupancy rooms. Its suites share their own bathrooms. The hillside location offers a beautiful view of the woods and fields surrounding the college.", nil];
    
    Recipe *recipe108 = [Recipe new];
    recipe108.name = @"Reading Day";
    recipe108.ingredients = [NSArray arrayWithObjects:@"The Wednesday before finals start (Thursday of that week) is dedicated to studying. This “free” day between when classes and and finals begin is a time for students to recover, plan, and study.", nil];
    
    Recipe *recipe109 = [Recipe new];
    recipe109.name = @"Regents";
    recipe109.ingredients = [NSArray arrayWithObjects:@"Firmly rooted in a vision that articulates an integrated approach to the study of natural sciences and mathematics, Regents Hall is carrying the sciences at St. Olaf deep into the 21st century, housed in inspiring and innovative learning spaces explicitly designed to promote the student-faculty interactions for which St. Olaf is known.", nil];
    
    Recipe *recipe110 = [Recipe new];
    recipe110.name = @"Residence Life";
    recipe110.ingredients = [NSArray arrayWithObjects:@"St. Olaf’s beautiful residential campus is a center for academic, social, cultural, and recreational activities. The Residence Life Office strives to engage, motivate, and challenge students in 11 residence halls and 21 honor houses across campus serving 96% of the student body. We are committed to providing a safe, comfortable, and student centered living environment that promotes personal and academic success.", nil];
    
    Recipe *recipe111 = [Recipe new];
    recipe111.name = @"Room draw";
    recipe111.ingredients = [NSArray arrayWithObjects:@"Process in which students sign up for housing for the next year. Towards the end of the school year, students receive a room draw “number” in their P.O. and that number will determine the order in which they are eligible to choose where they want to live the following year.", nil];
    
    Recipe *recipe112 = [Recipe new];
    recipe112.name = @"Rølvaag";
    recipe112.ingredients = [NSArray arrayWithObjects:@"Named for the Norwegian immigrant, Ole E. Rølvaag (pronounced Røl·vaag) (1876-1931), novelist, educator, and St. Olaf graduate, Rølvaag Memorial Library was completed in 1942 and is the main library on campus. The many group study rooms, computer labs, and quiet nooks provide students with any area to call their own.", nil];
    
    /***********************************
     S
     **********************************/
    
    Recipe *recipe113 = [Recipe new];
    recipe113.name = @"SAC";
    recipe113.ingredients = [NSArray arrayWithObjects:@"The Student Activities Committee branch of SGA organizes diverse events and activities that cater to the varied interests of students. SAC provides students with unique escapes from their academic responsibilities. SAC upholds St. Olaf traditions such as Homecoming Week and the President’s Ball. SAC also has weekly movies and provides special events throughout the year that include comedians, magicians, novelty acts and even speed dating!", nil];
    
    Recipe *recipe114 = [Recipe new];
    recipe114.name = @"SARN";
    recipe114.ingredients = [NSArray arrayWithObjects:@"The Sexual Assault Resource Network takes a stand against sexual assault and intimate violence on campus through supporting survivors and raising awareness in the college community. SARN is a CONFIDENTIAL source on campus with the principle concern of making sure that survivors of sexual, domestic and emotional abuse find their needs and concerns met with compassion and competence. SARN services include: victims’ rights and legal advocacy, crisis intervention, referrals, assistance with administrative hearing processes, education and information on sexual assault, domestic violence, child abuse, and healthy relationships or just someone to talk to. Advocates are on call nightly from 8:00pm - 8:00am during the academic year at x3777.", nil];
    
    Recipe *recipe115 = [Recipe new];
    recipe115.name = @"SAS";
    recipe115.ingredients = [NSArray arrayWithObjects:@"The Student Accessibility Services is located in the ASC and gives students an opportunity to access academics differently and work with professional staff to establish accommodations with respect to disabilities ranging from physical to learning. Students who have not yet been evaluated for a disability but suspect that there might be a barrier to their academics can also work with a professional staff member.", nil];
    
    Recipe *recipe116 = [Recipe new];
    recipe116.name = @"SGA";
    recipe116.ingredients = [NSArray arrayWithObjects:@"The Student Government Association (SGA) is lead by students who want to make life on campus an adventure for their fellow peers. The ten branches of SGA bring concerts, political speakers, diversity celebrations, late-night activities, Homecoming, pizza bagels in the Pause, student representation to the Board of regents, volunteer opportunities, connections with alumni, funding for student organizations, and so much more!", nil];
    
    Recipe *recipe117 = [Recipe new];
    recipe117.name = @"SIS";
    recipe117.ingredients = [NSArray arrayWithObjects:@"The Student Information System (pronounced S.I.S.) is an all-in-one place for students to register for classes, look at their degree audit and look over their financial statements. You can use SIS on your desktop or in this application.", nil];
    
    Recipe *recipe118 = [Recipe new];
    recipe118.name = @"SOC";
    recipe118.ingredients = [NSArray arrayWithObjects:@"The Student Organization Committee is the branch of SGA that registers clubs, making them official Orgs. Orgs can apply to SOC for funding for events, speakers, equipment, etc, and also use the SORC poster room to create publicity for their organizations.", nil];
    
    Recipe *recipe119 = [Recipe new];
    recipe119.name = @"STOGROW";
    recipe119.ingredients = [NSArray arrayWithObjects:@"The Saint Olaf Garden Research and Organic Works (STOGROW) farm project is a student-run community initiative. STOGROW’s goals are to practice sustainable farming methods; to provide fresh, local vegetables, fruits, herbs, and flowers to our community; to foster agricultural awareness; and to provide education about sustainable food production.", nil];
    
    Recipe *recipe120 = [Recipe new];
    recipe120.name = @"Scared Scriptless";
    recipe120.ingredients = [NSArray arrayWithObjects:@"The student improv group at St. Olaf. Their mission is to entertain the community through improvisational theater. In addition, Scared Scriptless gives students the opportunity to perform improv theater regardless of their amount of previous experience.", nil];
    
    Recipe *recipe121 = [Recipe new];
    recipe121.name = @"Shakes";
    recipe121.ingredients = [NSArray arrayWithObjects:@"Throughout the year the Pause Kitchen comes up with new “specialty shakes” that usually pertain to the month or season. For example, in the fall the pumpkin pie shake is a big hit, and in the spring, the shamrock shake is a big seller. In addition to the specialty shakes, the Pause has quite a few regular flavors and toppings to choose from. All are delicious!", nil];
    
    Recipe *recipe122 = [Recipe new];
    recipe122.name = @"Skog";
    recipe122.ingredients = [NSArray arrayWithObjects:@"The shorthand version of Skoglund (pronounced Skog·lund) Center. Skoglund hosts varsity basketball and volleyball games in its 2,008-seat arena, and its natatorium is home to the men’s and women’s swimming and diving teams. Skoglund also has a field house, racquetball courts, wrestling room, sauna, locker rooms, an athletic training room, and the athletic department offices. Outdoor tennis courts are located behind the building, near the softball, baseball and soccer fields. In addition to housing athletics, Skoglund Center is used for large ensemble performances, including the annual Christmas Festival.", nil];
    
    Recipe *recipe123 = [Recipe new];
    recipe123.name = @"Spring concert";
    recipe123.ingredients = [NSArray arrayWithObjects:@"Just like the fall concert, this event is planned and hosted by MEC and is the big hit of the spring!", nil];
    
    Recipe *recipe136 = [Recipe new];
    recipe136.name = @"St. Olaf Extra";
    recipe136.ingredients = [NSArray arrayWithObjects:@"Of the many email alias’ on the Hill, the stolaf-extra alias has to be the most active! This list can be used for announcing issues not directly related to St. Olaf such as items for sale, houses for rent, wanted-to-buy announcements, non-profit Northfield events, etc. Any student, faculty, or staff member can subscribe to the list!", nil];
    
    Recipe *recipe124 = [Recipe new];
    recipe124.name = @"Student Activites";
    recipe124.ingredients = [NSArray arrayWithObjects:@"Home to the Student Government Association (SGA), the Office of Student Activities is always upbeat and full of energy! In addition to housing SGA, the office is responsible for helping over 190 student organizations, providing information about student transportation, ticket sales and much more!", nil];
    
    Recipe *recipe125 = [Recipe new];
    recipe125.name = @"Study Abroad";
    recipe125.ingredients = [NSArray arrayWithObjects:@"We are known for plentiful and diverse study abroad programs. Each year, more than 800 students study off-campus! Academic programs take place in Europe, Asia, the Middle East, Africa, North, South and Central America and the Pacific. Some programs extend the scope of particular majors, language concentrations or area studies; all add a cross-cultural dimension to a liberal arts education.", nil];
    
    Recipe *recipe126 = [Recipe new];
    recipe126.name = @"Swing Club";
    recipe126.ingredients = [NSArray arrayWithObjects:@"An organization for any and all students to learn and have fun swing dancing! The club offers lessons each week as well as open social dance time. Guest instructors and trips to the cities are also regular special events. Any style of swing dance is welcome–lindy hop, balboa, shag, blues, etc! Come by anytime, no partner necessary!", nil];
    
    Recipe *recipe127 = [Recipe new];
    recipe127.name = @"Swiped Events";
    recipe127.ingredients = [NSArray arrayWithObjects:@"Every ESAC class (Wellness Center/physical education class) requires that students go to informational sessions run by the Wellness Center on a variety of topics. The Wellness Center representatives will “swipe” the Ole Cards of the students to prove they attended the session, or collect your name on a sheet of paper at the end of the event.", nil];
    
    /***********************************
     T
     **********************************/
    
    Recipe *recipe128 = [Recipe new];
    recipe128.name = @"Taiko";
    recipe128.ingredients = [NSArray arrayWithObjects:@"The student-led, Taiko Group was formed in 2004. Taiko is a form of drumming that originated in Japan. It developed from the martial arts and is a unique rhythmic experience that requires physical and mental agility.", nil];
    
    Recipe *recipe129 = [Recipe new];
    recipe129.name = @"The Piper Center";
    recipe129.ingredients = [NSArray arrayWithObjects:@"Located in Tomson Hall, The Piper Center for Vocation and Career provides resources and experiences designed to help students leverage their liberal arts education to achieve their full potential. The Piper Center innovatively strives to equip St. Olaf students with resources for achieving immediate and life-long career success.", nil];
    
    Recipe *recipe130 = [Recipe new];
    recipe130.name = @"The Quad";
    recipe130.ingredients = [NSArray arrayWithObjects:@"Behind Buntrock Commons and within the space between Rolvaag, Holland, Regents, Tomson, Mellby, the Theater, and Boe, is the area known as the Quad. On beautiful, sunny days, students gather to talk, eat, play frisbee, or just enjoy the Olaf community feel!", nil];
    
    Recipe *recipe131 = [Recipe new];
    recipe131.name = @"Tomson";
    recipe131.ingredients = [NSArray arrayWithObjects:@"Tomson Hall houses the Education Department and the college’s six language departments, plus the World Languages Center. Other building occupants include offices that serve students, such as Admissions and Financial Aid, the Office of International and Off-Campus Studies, the Dean of Students and Residence Life, the Health Center, Office of the Registrar, and Academic Advising, and the Piper Center that helps St. Olaf students discern their vocations and plan careers. The President’s and Provost’s offices and the Office of the Treasurer/Business Office are also located in Tomson Hall.", nil];
    
    /***********************************
     U
     **********************************/
    
    Recipe *recipe133 = [Recipe new];
    recipe133.name = @"Um! Yah! Yah!";
    recipe133.ingredients = [NSArray arrayWithObjects:@"The school saying and song! Every Ole memorizes this once hitting the Hill:\n\nWe come from St. Olaf, we sure are the real stuff. Our team is the cream of the colleges great. We fight fast and furious, our team is injurious. Tonight Carleton College will sure meet its fate.\n\nUm! Yah! Yah!, Um! Yah! Yah!\nUm! Yah! Yah!, Um! Yah! Yah!\nUm! Yah! Yah!, Um! Yah! Yah!\nUm! Yah! Yah! Yah!\n\nUm! Yah! Yah!, Um! Yah! Yah!\nUm! Yah! Yah!, Um! Yah! Yah!\nUm! Yah! Yah!, Um! Yah! Yah!  \nUm! Yah! Yah! Yah!", nil];

    Recipe *recipe134 = [Recipe new];
    recipe134.name = @"Ultimate";
    recipe134.ingredients = [NSArray arrayWithObjects:@"St. Olaf has 4 Ultimate teams, both Men’s and Women’s. The top teams compete regularly at the national level, while the developmental teams are a great opportunity to learn the game and make awesome friends. These teams are open to any interested Ole, and travel around the country to participate in tournaments.", nil];
    
    Recipe *recipe135 = [Recipe new];
    recipe135.name = @"Urness Recital Hall";
    recipe135.ingredients = [NSArray arrayWithObjects:@"Opera and musical theater productions are staged in this hall in the Christiansen Hall of Music.", nil];
    

    /***********************************
     V
     **********************************/
    
    Recipe *recipe137 = [Recipe new];
    recipe137.name = @"Valhalla";
    recipe137.ingredients = [NSArray arrayWithObjects:@"This student conducted and operated band (pronounced Val·halla) is founded on the principles of making music, meeting other students, and having fun. Each year, Valhalla will open its doors to any student who wants to be part of a band–regardless of membership in other musical groups on campus or musical abilities. The band performs in two concerts per year and also commissions a student composer once a year.", nil];
    
    Recipe *recipe138 = [Recipe new];
    recipe138.name = @"Van-GO!";
    recipe138.ingredients = [NSArray arrayWithObjects:@"This transportation service allows students to reserve rides for: community service sites, off-campus student-work assignments, student teaching, classes at Carleton, and medical/dental/therapy appointments in town. Van-GO! operates Monday - Friday, 7am - 6pm. Students must make their reservations online, a day prior to needing a ride.", nil];
    
    Recipe *recipe139 = [Recipe new];
    recipe139.name = @"Vegan cookies";
    recipe139.ingredients = [NSArray arrayWithObjects:@"During the school week, The Cage sells cookies made with bananas, oats, and chocolate chips. These cookies go fast, so students rush to The Cage after classes to make sure they can get one!", nil];
    
    Recipe *recipe140 = [Recipe new];
    recipe140.name = @"Viking Chorus";
    recipe140.ingredients = [NSArray arrayWithObjects:@"The men’s first-year chorus is made up of 85+ member, 60% of which are not music majors. This chorus performs at Homecoming and Family weekend, Christmas Festival, and more!", nil];
    
    Recipe *recipe141 = [Recipe new];
    recipe141.name = @"Viking Theater";
    recipe141.ingredients = [NSArray arrayWithObjects:@"The college’s very own movie theater-style room is located in on the first floor of Buntrock. The space is perfect for movie showings, big meetings, and presentations.", nil];
    
    Recipe *recipe142 = [Recipe new];
    recipe142.name = @"Volunteer Network";
    recipe142.ingredients = [NSArray arrayWithObjects:@"The Volunteer Network (VN) is committed to providing volunteer opportunities for students that benefit both St. Olaf and the larger community. As a branch of the Student Government Association (SGA) the goal of VN is to make a variety of volunteer programs available to students; some will be one-time events and others will provide for lasting participation. VN provides a wide range of services for children, the elderly, individuals with special needs, pets, and more.", nil];
    
    /***********************************
     W
     **********************************/
    
    Recipe *recipe143 = [Recipe new];
    recipe143.name = @"Week One";
    recipe143.ingredients = [NSArray arrayWithObjects:@"This is the week in which first-year students get acquainted with campus before all the upper-class students arrive back.", nil];
    
    Recipe *recipe144 = [Recipe new];
    recipe144.name = @"Wellness Center";
    recipe144.ingredients = [NSArray arrayWithObjects:@"Serves as a resource to promote awareness and education on issues relating to healthy lifestyles. We provide prevention and intervention services for alcohol and other drug use and abuse concerns. Student Peer Educators (PE) who staff The Wellness Center, located in Buntrock Commons, are available to talk with students one-on-one during office hours. Students are encouraged to come in and talk with a PE on any health related issue.", nil];
    
    Recipe *recipe145 = [Recipe new];
    recipe145.name = @"Wind Chime Memorial";
    recipe145.ingredients = [NSArray arrayWithObjects:@"In the middle of the Quad, stands a beautiful wind chime. Built by members of the St. Olaf community over the summer of 2003, this Scandinavian-style wooden tower commemorates the lives of students who have died while enrolled at St. Olaf. The chimes, tuned to the key of D (the key of Beautiful Savior), are engraved with the names of those students. On windy days, the sound of the chimes can be heard almost everywhere on campus.", nil];
    
    Recipe *recipe146 = [Recipe new];
    recipe146.name = @"Wind Turbine (Big Ole)";
    recipe146.ingredients = [NSArray arrayWithObjects:@"In 2005 we became the first liberal arts college in the nation to construct a utility-grade wind turbine for the sole purpose of providing energy to the campus (Carleton College was the first to construct a turbine, but the electricity it produces is sold to an energy company and added to the general power grid). Our 1.65 megawatt self-generating wind turbine directly supplies up to one-third of the electricity used by the college.", nil];
    
    Recipe *recipe147 = [Recipe new];
    recipe147.name = @"Work-study";
    recipe147.ingredients = [NSArray arrayWithObjects:@"It is very common for students to have an on-campus (or off-campus — CBWS) “student work” job. These jobs are also known as work-study positions. Students are awarded a certain amount of “work-study” allowance from the financial aid office. Work-study jobs can be found all over campus, from the caf to the library to most offices.", nil];
    
    /***********************************
     Y
     **********************************/
    
    Recipe *recipe148 = [Recipe new];
    recipe148.name = @"Ytterboe";
    recipe148.ingredients = [NSArray arrayWithObjects:@"Ytterboe (pronounced Itt·er·boe) Hall houses 402 students in suites of four to ten residents. Each suite (or pod) consists of single and double rooms arranged around a common living area. This hall features a beautiful main lounge, study lounges, computer facilities, sinks in the rooms, and music practice rooms.", nil];
    
    /***********************************
     Z
     **********************************/
    
    Recipe *recipe149 = [Recipe new];
    recipe149.name = @"Zero Week";
    recipe149.ingredients = [NSArray arrayWithObjects:@"One week before first-years arrive, faculty and staff get back into the swing of things. Lots to do for the upcoming school year!", nil];
    
    Recipe *recipe150 = [Recipe new];
    recipe150.name = @"Zoom Yah! Yah!";
    recipe150.ingredients = [NSArray arrayWithObjects:@"Runners from across the country (13 states and Spain) have competed in this unique, indoor, full marathon on the Tostrud Center track. Members of the women’s cross country and track and field teams host the event as a fundraiser for their teams.", nil];
    recipe150.position = @"last";
    
    
    recipes = [NSArray arrayWithObjects:recipe1, recipe2, recipe151, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8, recipe9, recipe10, recipe11, recipe12, recipe13, recipe14, recipe15, recipe16, recipe17, recipe19, recipe20, recipe21, recipe22, recipe23, recipe24, recipe25, recipe26, recipe27, recipe28, recipe29, recipe30, recipe32, recipe33, recipe34, recipe35, recipe36, recipe37, recipe38, recipe39, recipe40, recipe41, recipe42, recipe43, recipe44, recipe45, recipe46, recipe47, recipe48, recipe49, recipe50, recipe51, recipe52, recipe53, recipe54, recipe55, recipe56, recipe57, recipe58, recipe59, recipe60, recipe61, recipe62, recipe63, recipe64, recipe65, recipe66, recipe67, recipe68, recipe69, recipe70, recipe71, recipe72, recipe73, recipe74, recipe75, recipe76, recipe77, recipe78, recipe79, recipe80, recipe81, recipe82, recipe83,recipe84, recipe85, recipe86, recipe87, recipe88, recipe89, recipe90, recipe91, recipe92, recipe93, recipe94, recipe95, recipe96, recipe97, recipe98, recipe99, recipe100, recipe129, recipe101, recipe102, recipe130, recipe103, recipe104, recipe105, recipe106, recipe107, recipe108, recipe109, recipe110, recipe111, recipe112, recipe113, recipe114, recipe115, recipe116, recipe117, recipe118, recipe119, recipe120, recipe121, recipe122, recipe123, recipe136, recipe124, recipe125, recipe126, recipe127, recipe128, recipe131, recipe133, recipe134, recipe135, recipe137, recipe138, recipe139, recipe140, recipe141, recipe142, recipe143, recipe144, recipe145, recipe146, recipe147, recipe148, recipe149, recipe150, nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [recipes count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomTableCell";
    RecipeTableCell *cell = (RecipeTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[RecipeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    Recipe *recipe = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        recipe = [searchResults objectAtIndex:indexPath.row];
    } else {
        recipe = [recipes objectAtIndex:indexPath.row];
    }
    
    cell.nameLabel.font = [cell.textLabel.font fontWithSize:16];
    cell.nameLabel.text = recipe.name;
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = nil;
        Recipe *recipe = nil;
        bool shouldDisplay = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            recipe = [searchResults objectAtIndex:indexPath.row];
            myInt = [searchResults indexOfObject:recipe];
            shouldDisplay = false;

        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            recipe = [recipes objectAtIndex:indexPath.row];
            myInt = [recipes indexOfObject:recipe];
            shouldDisplay = true;
        }
        
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        destViewController.recipe = recipe;
        destViewController.recipeList = recipes;
        destViewController.theIndex = myInt;
        destViewController.displaySegments = shouldDisplay;
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


// Handle adding a word button touched
- (void)addWord:(id)sender {
    [self performSegueWithIdentifier:@"addWord" sender:sender];

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
