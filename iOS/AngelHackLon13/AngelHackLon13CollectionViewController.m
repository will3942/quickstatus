//
//  AngelHackLon13CollectionViewController.m
//  AngelHackLon13
//
//  Created by Joshua Balfour on 26/10/2013.
//  Copyright (c) 2013 Josh Balfour. All rights reserved.
//

#import "AngelHackLon13CollectionViewController.h"

@interface AngelHackLon13CollectionViewController ()

@end

@implementation AngelHackLon13CollectionViewController

NSMutableArray* data;
NSMutableArray* servers;
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
//UIButton* editButton;
static NSArray *endpoints = nil;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    data= [[NSMutableArray alloc] initWithObjects:@"",@"",[[NSArray alloc] initWithObjects:@"", nil],@"",@"", nil];
    servers = [[NSMutableArray alloc] initWithObjects:@"78.110.163.98",@"198.144.189.139", nil];
	// Do any additional setup after loading the view.
    if (endpoints == nil) {
        endpoints = [[NSMutableArray alloc] initWithObjects:@"temperature",@"tfl",@"bus",@"ip",@"ip", nil];
    }
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self refresh];
    flippedcells = [[NSMutableArray alloc] init];
 //   editButton = [UIButton buttonWithType:UIButtonTypeCustom];
 //   [editButton setImage:[UIImage imageNamed:@"pencil.png"] forState:UIControlStateNormal];
 //   edit = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pencil.png"]];
 //   [editButton setFrame:CGRectMake(115, 5, 24, 50)];
 //   editButton.transform = CGAffineTransformMakeRotation((10*M_PI)/9);
 //   [editButton addTarget:self action:@selector(convertToEdit:) forControlEvents:UIControlEventTouchUpInside];
}

static NSString* serverLocation = @"http://joshbalfour.co.uk/ah";
-(void)convertToEdit:(id)sender{
   // NSLog(@"hai");
}
-(void)refresh{
    for (int x = 0; x<endpoints.count; x++){
      //  NSLog(@"%@",[NSString stringWithFormat:@"%@/%@/%@.json",serverLocation,[NSString stringWithFormat:@"%d",x],endpoints[x]]);
        NSURL *url;
        if (x==0){
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@.json",serverLocation,[NSString stringWithFormat:@"%d",x],endpoints[x]]];
        } else if (x==1){
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/tfl/bikes.php",serverLocation,[NSString stringWithFormat:@"%d",x]]];
        } else if (x==2){
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/tfl/bus.php",serverLocation,[NSString stringWithFormat:@"%d",x]]];
        } else {
            
            //   url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@/%@",serverLocation,[NSString stringWithFormat:@"%d",x],endpoints[x],[servers objectAtIndex:x-1]]];
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@.php",serverLocation,[NSString stringWithFormat:@"%d",x],endpoints[x]]];
        }
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *resdata, NSError *error){
            if (error){
                // something fucked up somewhere
                NSLog(@"Error,%@", [error localizedDescription]);
            } else {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:resdata options:NSJSONReadingMutableLeaves error:nil];
                
                NSArray *arr =[json objectForKey:@"data"];
                int index=[arr[0] integerValue];
                id contents = arr[1];
                [data setObject:contents atIndexedSubscript:index];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            }
        }];
    }
}
/*
static NSString* mobileNumber = @"447927268623";
-(void)sendSMS:(NSString*)ip{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@%@%@&msg_type=SMS_FLASH&FROM=SERVER_STATUS",@"http://api.clickatell.com/http/sendmsg?user=HACKATHON26&password=fGqDeAm3w&api_id=3445633&to=",mobileNumber,@"&text=SERVER_ERR%20-%20Unable%20to%20reach%20",ip]]];
    NSLog(@"%@",url);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:nil];
    
}
 */
int busPos=0;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel* bg = [[UILabel alloc] init];
    [bg setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65]];
    if (indexPath.row==0){
        if (![[data objectAtIndex:indexPath.row] isEqual:@""]){
            [bg setText:[NSString stringWithFormat:@"%@°",[data objectAtIndex:indexPath.row]]];
        }
        //cell.backgroundColor = [UIColor grayColor];
        cell.backgroundColor = [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0f];
      //  cell.backgroundColor = [UIColor colorWithRed:15/255.0f green:57/255.0f blue:193/255.0f alpha:1.0f];
        
    } else if (indexPath.row>2){
        [bg setText:[data objectAtIndex:indexPath.row]];
        if ([[data objectAtIndex:indexPath.row] isEqual:@"up"]){
            cell.backgroundColor =[UIColor colorWithRed:2/255.0f green:236/255.0f blue:199/255.0f alpha:1.0f];
        } else if ([[data objectAtIndex:indexPath.row] isEqual:@"down"]){
     //       [self sendSMS:[servers objectAtIndex:indexPath.row-2]];
            [bg setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]];
         //   cell.backgroundColor = [UIColor grayColor];
          //  cell.backgroundColor  = [UIColor colorWithRed:14/255.0f green:116/255.0f blue:195/255.0f alpha:1.0f];
            cell.backgroundColor = [UIColor colorWithRed:231/255.0f green:76/255.0f blue:60/255.0f alpha:1.0f];
        }
    } else if (indexPath.row==1){
        int numberOfBikes = [[data objectAtIndex:indexPath.row] integerValue];
        [bg setText:[data objectAtIndex:indexPath.row]];
        [bg setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]];
        if (numberOfBikes>=5){
            cell.backgroundColor =[UIColor colorWithRed:2/255.0f green:236/255.0f blue:199/255.0f alpha:1.0f];
        } else if (5>numberOfBikes>2){
            cell.backgroundColor = [UIColor colorWithRed:243/255.0f green:156/255.0f blue:18/255.0f alpha:1.0f];
        } else if (numberOfBikes<=2){
            cell.backgroundColor = [UIColor colorWithRed:231/255.0f green:76/255.0f blue:60/255.0f alpha:1.0f];
        }
    } else if (indexPath.row==2){
        busPos=0;
        //NSLog(@"asdfgh:%@",[data objectAtIndex:indexPath.row])
        [bg setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20]];
        [bg setText:[(NSArray*)[data objectAtIndex:indexPath.row] objectAtIndex:0]];
        bg.numberOfLines = 3;
        cell.backgroundColor =[UIColor colorWithRed:155/255.0f green:89/255.0f blue:182/255.0f alpha:1.0f];
    }
    if ([[data objectAtIndex:indexPath.row] isEqual:@""]){
        cell.backgroundColor = [UIColor colorWithRed:243/255.0f green:156/255.0f blue:18/255.0f alpha:1.0f];
        [bg setText:@"..."];
    }
    
    
    [bg setTextAlignment:NSTextAlignmentCenter];
    [cell setBackgroundView:bg];
    
    return cell;
}
NSMutableArray* flippedcells;

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>1){
        UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
        UIViewAnimationOptions  anim = UIViewAnimationOptionTransitionFlipFromLeft;
        NSString* toChangeTo;
        if (indexPath.row==2){
            busPos++;
            if (busPos>=[(NSArray*)[data objectAtIndex:indexPath.row] count]){
                busPos=0;
            }
            toChangeTo = [(NSArray*)[data objectAtIndex:indexPath.row] objectAtIndex:busPos];
            
        } else {
            if (![flippedcells containsObject:indexPath]){
                anim = UIViewAnimationOptionTransitionFlipFromRight;
                [flippedcells addObject:indexPath];
                toChangeTo = [servers objectAtIndex:indexPath.row-3];
                [(UILabel*)cell.backgroundView setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18]];
                
            //    [(UILabel*)cell.backgroundView addSubview:editButton];
                
            } else {
                [flippedcells removeObject:indexPath];
                if (indexPath.row!=2){
                    toChangeTo = [data objectAtIndex:indexPath.row];
                }
                
                [(UILabel*)cell.backgroundView setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]];
            //    [editButton removeFromSuperview];
            }
        }
        
        [UIView transitionWithView:cell duration:0.5 options:anim animations:^{
            [(UILabel*)cell.backgroundView setText:toChangeTo];
            //any animateable attribute here.
            
           // cell.frame = CGRectMake(3, 14, 100, 100);
            
        } completion:^(BOOL finished) {
            //whatever you want to do upon completion
            
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
