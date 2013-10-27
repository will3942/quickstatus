//
//  AngelHackLon13TableViewController.m
//  AngelHackLon13
//
//  Created by Joshua Balfour on 26/10/2013.
//  Copyright (c) 2013 Josh Balfour. All rights reserved.
//

#import "AngelHackLon13TableViewController.h"

@interface AngelHackLon13TableViewController ()

@end

@implementation AngelHackLon13TableViewController
NSMutableArray* data;
NSTimer *timer;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    data= [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
    return self;
}
static NSArray *endpoints = nil;
NSTimer *timer;
- (void)viewDidLoad
{
    [super viewDidLoad];
 //   plusses = [[NSMutableArray alloc] initWithObjects:NULL,NULL,NULL,NULL, nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // start refreshing every x seconds
    if (endpoints == nil) {
        endpoints = [[NSMutableArray alloc] initWithObjects:@"temperature",@"ip",@"ip",@"ip", nil];
    }
    [self refresh];
    /*timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(refresh:)
                                   userInfo:nil
                                    repeats:YES];*/
}

static NSString* serverLocation = @"http://joshbalfour.co.uk/ah";

-(void)refresh{
    for (int x = 0; x<endpoints.count; x++){
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"&%@&%@&%@=",serverLocation,[NSString stringWithFormat:@"%d",x],endpoints[x]]];
        NSLog(@"%@",[NSString stringWithFormat:@"%@/%@/%@.json",serverLocation,[NSString stringWithFormat:@"%d",x],endpoints[x]]);
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@.json",serverLocation,[NSString stringWithFormat:@"%d",x],endpoints[x]]];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *resdata, NSError *error){
            if (error){
                // something fucked up somewhere
                NSLog(@"Error,%@", [error localizedDescription]);
            } else {
              //  NSString* response= [[NSString alloc] initWithData:resdata encoding:NSASCIIStringEncoding];

                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:resdata options:NSJSONReadingMutableLeaves error:nil];

                NSArray *arr =[json objectForKey:@"data"];
                int index=[arr[0] integerValue];
                NSString* contents = arr[1];
                NSLog(@"%@",contents);
                [data setObject:contents atIndexedSubscript:index];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
    }
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [data count];
}
//NSMutableArray *plusses;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[data objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:65];
    // Configure the cell...
  /*  if ([cell.textLabel.text isEqual:@""]){
        UILabel *plus = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 70, 70)];
        plus.layer.cornerRadius = 35;
        plus.backgroundColor = [UIColor blueColor];
        [plus setText:@"+"];
        [plus setTextColor:[UIColor whiteColor]];
        [plus setTextAlignment:NSTextAlignmentCenter];
        [plus setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:70]];
        [cell addSubview:plus];
        plusses[indexPath.row]=plus;
    } else {
        [plusses[indexPath.row] removeFromSuperview];
    }
    */
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

@end
