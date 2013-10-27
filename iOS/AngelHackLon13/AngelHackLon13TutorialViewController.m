//
//  AngelHackLon13TutorialViewController.m
//  AngelHackLon13
//
//  Created by Joshua Balfour on 27/10/2013.
//  Copyright (c) 2013 Josh Balfour. All rights reserved.
//

#import "AngelHackLon13TutorialViewController.h"
#import "AngelHackLon13CollectionViewController.h"

@interface AngelHackLon13TutorialViewController ()

@end

@implementation AngelHackLon13TutorialViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
NSTimer *timer;
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    //bg
    UIImageView* bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"out_of_focus3.jpg"]];
    [bg setFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, self.parentViewController.view.frame.size.height)];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bg];
    
    
    // next button
    UIButton* next = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [next setFrame:CGRectMake(self.parentViewController.view.frame.size.width-175, self.parentViewController.view.frame.size.height-100, 150, 50)];
    [next setTitle:@"Next" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    next.layer.borderWidth=1.0f;
    next.layer.cornerRadius = 10;
    next.layer.borderColor=[[[next titleLabel] textColor] CGColor];
    [self.view addSubview:next];
    
    
    firstExampleTile = [[UILabel alloc] initWithFrame:CGRectMake(self.parentViewController.view.frame.size.width/2 - 75, 150, 150, 200)];
    [firstExampleTile setBackgroundColor:[UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0f]];
    [firstExampleTile setText:@"25°"];
    [firstExampleTile setTextColor:[UIColor whiteColor]];
    [firstExampleTile setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65]];
    [firstExampleTile setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *firstExampleTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, 150)];
    [firstExampleTitle setTextAlignment:NSTextAlignmentCenter];
    [firstExampleTitle setTextColor:[UIColor whiteColor]];
    [firstExampleTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [firstExampleTitle setText:@"There are many different tiles, like temperature"];
    firstExampleTitle.numberOfLines = 3;
    
   
    
    [self.view addSubview:firstExampleTile];
    [self.view addSubview:firstExampleTitle];

   
    
  //  [UIView commitAnimations];
    
   
    secondExampleTile = [[UILabel alloc] initWithFrame:CGRectMake(self.parentViewController.view.frame.size.width/2 - 75, 150, 150, 200)];
    secondExampleTile.backgroundColor =[UIColor colorWithRed:2/255.0f green:236/255.0f blue:199/255.0f alpha:1.0f];  [secondExampleTile setText:@"Up"];
    [secondExampleTile setTextColor:[UIColor whiteColor]];
    [secondExampleTile setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65]];
    [secondExampleTile setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *secondExampleTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, 150)];
    [secondExampleTitle setTextAlignment:NSTextAlignmentCenter];
    [secondExampleTitle setTextColor:[UIColor whiteColor]];
    [secondExampleTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [secondExampleTitle setText:@"There are many different tiles, like server status"];
    secondExampleTitle.numberOfLines = 3;
    
    
    [self.view addSubview:secondExampleTile];
    [self.view addSubview:secondExampleTitle];
    
    
 //   [UIView commitAnimations];
 
    thirdExampleTile = [[UILabel alloc] initWithFrame:CGRectMake(self.parentViewController.view.frame.size.width/2 - 75, 150, 150, 200)];
    thirdExampleTile.backgroundColor =[UIColor colorWithRed:243/255.0f green:156/255.0f blue:18/255.0f alpha:1.0f];  [thirdExampleTile setText:@"3"];
    [thirdExampleTile setTextColor:[UIColor whiteColor]];
    [thirdExampleTile setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65]];
    [thirdExampleTile setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *thirdExampleTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, 150)];
    [thirdExampleTitle setTextAlignment:NSTextAlignmentCenter];
    [thirdExampleTitle setTextColor:[UIColor whiteColor]];
    [thirdExampleTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30]];
    [thirdExampleTitle setText:@"There are many different tiles, like boris bike availability"];
    thirdExampleTitle.numberOfLines = 3;
    
    
    [self.view addSubview:thirdExampleTile];
    [self.view addSubview:thirdExampleTitle];
    
    thirdExampleTile.alpha= 0;
    thirdExampleTitle.alpha= 0;
    
    secondExampleTile.alpha= 0;
    secondExampleTitle.alpha= 0;
    
    firstExampleTitle.alpha= 0;
    firstExampleTile.alpha= 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
        firstExampleTitle.alpha= 1;
        firstExampleTile.alpha= 1;
    
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
        firstExampleTitle.alpha= 0;
        firstExampleTile.alpha= 0;
    
    [UIView commitAnimations];

/*    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
        secondExampleTitle.alpha= 1;
        secondExampleTile.alpha= 1;
    
    [UIView commitAnimations];
    
  */
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

        thirdExampleTitle.alpha= 1;
    
        thirdExampleTile.alpha= 1;
    
    
    [UIView commitAnimations];
    
    
}
UILabel* firstExampleTile;
UILabel* secondExampleTile;
UILabel* thirdExampleTile;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)next:(id)sender{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, 150)];
    //  [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:55]];
    [title setText:@"QuickStatus"];
    [title setTextAlignment:NSTextAlignmentCenter];
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(150, 200)];
    aFlowLayout.sectionInset = UIEdgeInsetsMake(130, 5, 0, 5);
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    AngelHackLon13CollectionViewController *table = [[AngelHackLon13CollectionViewController alloc]initWithCollectionViewLayout:aFlowLayout];
    [table.view addSubview:title];
    
    [[self navigationController] pushViewController:table animated:YES];
}
@end
