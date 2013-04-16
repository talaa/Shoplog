//
//  feedsViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 4/7/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import "feedsViewController.h"

@interface feedsViewController ()

@end

@implementation feedsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadthetweets{
    NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=20";
    
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
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{



}
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)viewDidLoad
{
    [self loadthetweets];
    if (!_tweets) {
        UIAlertView *oops=[[UIAlertView alloc]initWithTitle:@"Oops!" message:@"There is Error Downloading the Feeds" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [oops show];
    }
    
    NSLog(@"the tweets are :%@",_tweets);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
