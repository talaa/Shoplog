//
//  CollectionReusableViewHeader.m
//  ttttt
//
//  Created by Mena Bebawy on 12/8/15.
//  Copyright © 2015 Tamer Alaa. All rights reserved.
//

#import "CollectionReusableViewHeader.h"

@implementation CollectionReusableViewHeader

-(IBAction)searchButtonPressed:(id)sender{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.section.text forKey:@"Searchterm"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Searchactivated" object:self userInfo:dict];
    
    NSLog(@"My Name is :%@",self.section.text);
}


@end
