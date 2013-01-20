//
//  FeedshoplogViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 1/8/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import "FeedshoplogViewController.h"

@interface FeedshoplogViewController ()

@end

@implementation FeedshoplogViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=2";
    
    //NSString *feedname=@"https://api.twitter.com/1/statuses/home_timeline.json?include_entities=true";
    NSURL *feedURL =[NSURL URLWithString:feedname];
    
    //The JSON Part
    NSData *data =[NSData dataWithContentsOfURL:feedURL];
    //[self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    NSError* error;
    NSArray *tweets= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves
                                                       error:&error];
    //NSLog(@"The feed 2 Display %@",feedURL);
    
    //NSString *new = [[[[tweets objectAtIndex:0 ]objectForKey:@"entities"]objectForKey:@"urls"]objectForKey:@"url"];
    NSDictionary *new =[[[tweets objectAtIndex:0]objectForKey:@"entities"]objectForKey:@"urls"];
    if(new!=nil)  {
        //NSLog(@"The feed 2 Display %@",new);
        NSDictionary *entity  = [[tweets objectAtIndex:0] objectForKey:@"entities"];
        NSArray *media        = [entity objectForKey:@"urls"];
        NSDictionary *media0  = [media objectAtIndex:0];
        NSString *display_url = [media0 objectForKey:@"expanded_url"];
        NSDictionary *retweeted=[[tweets objectAtIndex:1]objectForKey:@"retweeted_status"];
        //NSDictionary *newtweetentity=[[[tweets objectAtIndex:0]objectForKey:@"entities"]objectForKey:@"urls"];
        //NSArray *newtweetentity=[NSJSONSerialization JSONObjectWithData:URLEntity options:kNilOptions error:&error];
        NSLog(@"Url is %@",display_url );
        //NSLog(@"Url is %@",[newtweetentity objectForKey:@"expanded_url"]);
        NSLog(@"text is  %@",[[tweets objectAtIndex:0]objectForKey:@"text"]);
        
        NSLog(@"The Count is %@",retweeted);
        if (retweeted) {
            NSLog(@"User is %@",[[[[tweets objectAtIndex:0]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"screen_name"]);
            NSLog(@"Image is %@",[[[[tweets objectAtIndex:0]objectForKey:@"retweeted_status"]objectForKey:@"user"]objectForKey:@"profile_image_url"]);
            
        }
    }else {
        NSLog(@"this is not Working ");
    }

}
-(void)viewWillAppear:(BOOL)animated{
    ACAccountCredential *ddd=[[ACAccountCredential alloc]initWithOAuthToken:@"970310802-w4v8587KBIKtcdAhXH1nEPNJwKTWDHhPSP9sPky3" tokenSecret:@"RtEDtZw20UpfaiGjSybn9yiTs0LwVNkTSiBWPoMiQ4"];
    ACAccountType *twitterAccountType = [self.accountStore
                                         accountTypeWithAccountTypeIdentifier:
                                         ACAccountTypeIdentifierTwitter];
    ACAccount *shoplogaccount=[[ACAccount alloc]initWithAccountType:twitterAccountType];
    shoplogaccount.credential=ddd;
        
    self.accountStore = [[ACAccountStore alloc] init];
    
    
    
    
    //self.twitterAccount=[[ACAccount alloc]initWithAccountType:]
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
