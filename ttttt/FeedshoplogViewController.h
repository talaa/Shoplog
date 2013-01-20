//
//  FeedshoplogViewController.h
//  ttttt
//
//  Created by Tamer Alaa on 1/8/13.
//  Copyright (c) 2013 Tamer Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>


@interface FeedshoplogViewController : UITableViewController

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *twitterAccount;

@end
