//
//  OlevilleViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "OlevilleViewController.h"

@interface OlevilleViewController ()

@end

@implementation OlevilleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITextView *myUITextView = [[UITextView alloc] initWithFrame:CGRectMake(0,-60,280,300)];
    myUITextView.text = @"One of the nation’s leading four-year residential colleges, St. Olaf offers an academically rigorous education with a vibrant faith tradition. Founded in 1874, St. Olaf is a liberal arts college of the church in the Lutheran tradition (ELCA). Committed to the liberal arts and incorporating a global perspective, St. Olaf fosters the development of the whole person in mind, body, and spirit.\n\nAcademic excellence informs St. Olaf College’s identity and characterizes its history. Through its curriculum, campus life, and off-campus programs, St. Olaf hones students’ critical thinking and nurtures their moral formation. The college encourages and challenges its students to be seekers of truth, to lead lives of unselfish service to others, and to be responsible and knowledgeable citizens of the world.\n\nWidely known for its world-class programs in mathematics and music, St. Olaf is also recognized for its innovative approaches to undergraduate science education and its commitment to environmental sustainability as evidenced in such initiatives as the adoption of green chemistry principles across the science curriculum.\n\nFor nearly half a century, St. Olaf has been at the forefront of global education and a pioneer in study abroad. Today, with 110 distinct international and off-campus programs in 46 countries, St. Olaf students enjoy a world of opportunities when pursuing their studies.\n\nSt. Olaf is an inclusive community that welcomes people of differing backgrounds and beliefs, a community that embraces spirituality and cultivates compassion. Conversations about faith are part of campus life and numerous opportunities are provided for students to grow in their faith and discover how they are called upon to serve others.\n\nSt. Olaf takes pride in its record of academic excellence. A leader among undergraduate colleges in producing prestigious Rhodes Scholars, Fulbright Fellows, and Peace Corps volunteers, St. Olaf ranks 11th overall among the nation’s baccalaureate colleges in the number of graduates who go on to earn doctoral degrees, with top ten rankings in the fields of mathematics/statistics, religion/theology, arts and music, medical sciences, education and the social service professions, chemistry and the physical sciences, life sciences, and foreign languages.";
    myUITextView.textColor = [UIColor blackColor];
    myUITextView.font = [UIFont systemFontOfSize:14];
    [myUITextView setBackgroundColor:[UIColor clearColor]];
    myUITextView.editable = NO;
    myUITextView.scrollEnabled = YES;
    [_textView addSubview:myUITextView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
