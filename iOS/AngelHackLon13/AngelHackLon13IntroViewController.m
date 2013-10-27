//
//  AngelHackLon13IntroViewController.m
//  AngelHackLon13
//
//  Created by Joshua Balfour on 27/10/2013.
//  Copyright (c) 2013 Josh Balfour. All rights reserved.
//

#import "AngelHackLon13IntroViewController.h"
#import "AngelHackLon13TutorialViewController.h"

@interface AngelHackLon13IntroViewController ()

@end

@implementation AngelHackLon13IntroViewController

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
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    
    //bg
    UIImageView* bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"out_of_focus.jpg"]];
    [bg setFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, self.parentViewController.view.frame.size.height)];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bg];
    
    //welcome text
    
    UILabel* welcome = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.parentViewController.view.frame.size.width-40, 250)];
    welcome.numberOfLines = 3;
    [welcome setText:@"Welcome to QuickStatus"];
    [welcome setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50]];
    [welcome setTextColor:[UIColor whiteColor]];
    [self.view addSubview:welcome];
    
    // next button
    UIButton* next = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [next setFrame:CGRectMake(self.parentViewController.view.frame.size.width-175, self.parentViewController.view.frame.size.height-100, 150, 50)];
    [next setTitle:@"Next" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    next.layer.borderWidth=1.0f;
    next.layer.cornerRadius = 10;
    next.layer.borderColor=[[[next titleLabel] textColor] CGColor];
    [self.view addSubview:next];
}

-(void)next:(id)sender{
    AngelHackLon13TutorialViewController* tutorial = [[AngelHackLon13TutorialViewController alloc] init];
    
    [[self navigationController] pushViewController:tutorial animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
