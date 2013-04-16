//
//  CarouselViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 1/8/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import "CarouselViewController.h"


#define NUMBER_OF_ITEMS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? 6: 6)
#define ITEM_SPACING 210


@interface CarouselViewController ()

@end

@implementation CarouselViewController
@synthesize carousel,username,usericon,text,origimage,originaluser,maintext,linktogo,Buttonclick,tweetsfinished,background, ContentActivity,Provideractivity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    NSLog(@"I am Coming from initwithNib ");
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)awakeFromNib{

    [self loadthetweets];
    if (!_tweets) {
        UIAlertView *oops=[[UIAlertView alloc]initWithTitle:@"Oops!" message:@"There is Error Downloading the Feeds" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [oops show];
    }
    

    NSLog(@"I am Coming from awakefromnib");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[carousel reloadData];
    NSLog(@"Iam Coming from view did load");
	// Do any additional setup after loading the view.
    carousel.type = iCarouselTypeCoverFlow2;
    /////////////////
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"I am Coming from View will Appear ");
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return NUMBER_OF_ITEMS;
}
-(void)loadthetweets{
    NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=6";
    
    NSURL *feedURL =[NSURL URLWithString:feedname];
    
    //The JSON Part
        
    NSData *dataurl =[NSData dataWithContentsOfURL:feedURL];
    //NSLog(@"The dataurlis %@",dataurl);
    if (dataurl) {
        NSError* error;
        _tweets= [NSJSONSerialization JSONObjectWithData:dataurl options:NSJSONReadingMutableLeaves
                                                   error:&error];
            }
    


}
-(void)loadfromtheweb:(NSNumber*)index1{
    dispatch_queue_t concurrentQueue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSUInteger index=[index1 integerValue];
    NSLog(@"The Index is %i",index);
    maintext=[[_tweets objectAtIndex:index]objectForKey:@"text"];
    NSArray *piecesOfOriginalString = [maintext componentsSeparatedByString:@"http"];
    NSString *firstetxt=[piecesOfOriginalString objectAtIndex:0];
     NSLog(@"The first text: %@",firstetxt);
    //NSLog(@"the Size of the array is %i",[piecesOfOriginalString count]);
    if ([piecesOfOriginalString count]>1) {
    NSString *link=[@"http" stringByAppendingString:[piecesOfOriginalString objectAtIndex:1]];
    
        
    
    linktogo=[NSURL URLWithString:link];
    text.text=firstetxt;
    
    NSLog(@"The link text: %@",link);
    //NSDictionary *new =[[[tweets objectAtIndex:index]objectForKey:@"entities"]objectForKey:@"urls"];
    NSDictionary *retweeted=[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"];
    if (retweeted) {
        NSString *urlll=[[[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"profile_image_url"];
        username.text=[[[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"screen_name"];
        dispatch_async(concurrentQueue2,^{
       
        NSURL *iiii=[NSURL URLWithString:urlll];
        usericon.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:iiii]];
        });
    }
    }else{
        username.text=@"Shoplog";
        usericon.image=[UIImage imageNamed:@"MyIcon copy_57.png"];
    }
    
[ContentActivity stopAnimating];
[ContentActivity hidesWhenStopped];
[Provideractivity stopAnimating];
[Provideractivity hidesWhenStopped];
[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];



}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
    	//load new item view instance from nib
        //control events are bound to view controller in nib file
        
    	view = [[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil] lastObject];
        background.layer.cornerRadius=20.0;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [Provideractivity startAnimating];
        [ContentActivity startAnimating];

        //[self performSelectorInBackground:@selector(loadthetweets) withObject:nil ];
        //[self performSelectorInBackground:@selector(loadfromtheweb:) withObject:nil];
        //[self performSelectorOnMainThread:@selector(loadthetweets) withObject:nil waitUntilDone:YES];
        
        
        //[self performSelectorInBackground:@selector(loadthetweets) withObject:nil];
        /*
        NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=20";
        
        NSURL *feedURL =[NSURL URLWithString:feedname];
        
        //The JSON Part
        NSData *data =[NSData dataWithContentsOfURL:feedURL];
        
        NSError* error;
        _tweets= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves
                                                   error:&error];
        
        
        
        maintext=[[_tweets objectAtIndex:index]objectForKey:@"text"];
        NSArray *piecesOfOriginalString = [maintext componentsSeparatedByString:@"http"];
        NSString *firstetxt=[piecesOfOriginalString objectAtIndex:0];
        NSLog(@"The first text: %@",firstetxt);
        text.text=firstetxt;
        if ([piecesOfOriginalString count]>1) {
        NSString *link=[@"http" stringByAppendingString:[piecesOfOriginalString objectAtIndex:1]];
        linktogo=[NSURL URLWithString:link];
        
        
        NSLog(@"The link text: %@",link);
        //NSDictionary *new =[[[tweets objectAtIndex:index]objectForKey:@"entities"]objectForKey:@"urls"];
        NSDictionary *retweeted=[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"];
        if (retweeted) {
            NSString *urlll=[[[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"profile_image_url"];
            NSURL *iiii=[NSURL URLWithString:urlll];
            usericon.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:iiii]];
            username.text=[[[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"screen_name"];
        }else{
        
            username.text=@"Shoplog";
            usericon.image=[UIImage imageNamed:@"MyIcon copy_57.png"];
        }
        }else{
            username.text=@"Shoplog";
            usericon.image=[UIImage imageNamed:@"MyIcon copy_57.png"];
        }
        [ContentActivity stopAnimating];
        [ContentActivity hidesWhenStopped];
        [Provideractivity stopAnimating];
        [Provideractivity hidesWhenStopped];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         */
        
        maintext=[[_tweets objectAtIndex:index]objectForKey:@"text"];
        NSArray *piecesOfOriginalString = [maintext componentsSeparatedByString:@"http"];
        NSString *firstetxt=[piecesOfOriginalString objectAtIndex:0];
        NSLog(@"The first text: %@",firstetxt);
        text.text=firstetxt;
        //NSLog(@"the Size of the array is %i",[piecesOfOriginalString count]);
        if ([piecesOfOriginalString count]>1) {
            NSString *link=[@"http" stringByAppendingString:[piecesOfOriginalString objectAtIndex:1]];
            
            
            
            linktogo=[NSURL URLWithString:link];
            
            
            NSLog(@"The link text: %@",link);
            //NSDictionary *new =[[[tweets objectAtIndex:index]objectForKey:@"entities"]objectForKey:@"urls"];
            NSDictionary *retweeted=[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"];
            if (retweeted) {
                NSString *urlll=[[[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"profile_image_url"];
                username.text=[[[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"screen_name"];
                NSURL *iiii=[NSURL URLWithString:urlll];
                usericon.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:iiii]];
                
                background.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self retrieveImageSourceTagsViaRegex:linktogo]]]];
               
            }else{
                username.text=@"Shoplog";
                usericon.image=[UIImage imageNamed:@"MyIcon copy_57.png"];
            }

        }else{
            username.text=@"Shoplog";
            usericon.image=[UIImage imageNamed:@"MyIcon copy_57.png"];
        }
        
        [ContentActivity stopAnimating];
        [ContentActivity hidesWhenStopped];
        [Provideractivity stopAnimating];
        [Provideractivity hidesWhenStopped];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        

        
        
        
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        
        dispatch_async(concurrentQueue, ^{
           
            //[self loadthetweets];
                       
        });
        
        
        
     
    }
         
    return view;
    
}
- (NSString*)retrieveImageSourceTagsViaRegex:(NSURL *)url1
{
    NSString *string = [NSString stringWithContentsOfURL:url1
                                                encoding:NSUTF8StringEncoding
                                                   error:nil];
    NSMutableArray *imagesarray=[[NSMutableArray alloc]init];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    [regex enumerateMatchesInString:string
                            options:0
                              range:NSMakeRange(0, [string length])
                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             
                             NSString *src = [string substringWithRange:[result rangeAtIndex:2]];
                             //NSLog(@"img src: %@", src);
                             [imagesarray addObject:src];
                             //NSString *imagesrc=[[NSString alloc]initWithString:src];
                             
                             
                         }];
    NSLog(@"The List of Images is %@",[imagesarray objectAtIndex:1]);
    return [imagesarray objectAtIndex:1];
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (IBAction)Gotolink:(id)sender {
    
    int ee=[carousel indexOfItemViewOrSubview:sender];
    maintext=[[_tweets objectAtIndex:ee]objectForKey:@"text"];
    NSArray *piecesOfOriginalString = [maintext componentsSeparatedByString:@"http"];
    //NSString *firstetxt=[piecesOfOriginalString objectAtIndex:0];
    NSString *link=[@"http" stringByAppendingString:[piecesOfOriginalString objectAtIndex:1]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
    //NSLog(@"The Url is %@",linktogo);
}

- (IBAction)Refresh:(id)sender {
    NSLog(@"I am Tapped ");
    
    /*
    NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=20";
    
    NSURL *feedURL =[NSURL URLWithString:feedname];
    
    //The JSON Part
    NSData *data =[NSData dataWithContentsOfURL:feedURL];
    
    NSError* error;
    _tweets= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves
                                               error:&error];
    
    for (int index=1; index<NUMBER_OF_ITEMS; index++) {
        maintext=[[_tweets objectAtIndex:index]objectForKey:@"text"];
        NSArray *piecesOfOriginalString = [maintext componentsSeparatedByString:@"http"];
        NSString *firstetxt=[piecesOfOriginalString objectAtIndex:0];
        NSLog(@"The first text: %@",firstetxt);
        NSString *link=[@"http" stringByAppendingString:[piecesOfOriginalString objectAtIndex:1]];
        linktogo=[NSURL URLWithString:link];
        text.text=firstetxt;
        
        NSLog(@"The link text: %@",link);
        //NSDictionary *new =[[[tweets objectAtIndex:index]objectForKey:@"entities"]objectForKey:@"urls"];
        NSDictionary *retweeted=[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"];
        if (retweeted) {
            NSString *urlll=[[[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"profile_image_url"];
            NSURL *iiii=[NSURL URLWithString:urlll];
            usericon.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:iiii]];
            username.text=[[[[_tweets objectAtIndex:index]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"screen_name"];
        }else{
            username.text=@"Shoplog";
            usericon.image=[UIImage imageNamed:@"MyIcon copy_57.png"];
        }
        
       
    }
    */
[carousel reloadData];


}
@end
