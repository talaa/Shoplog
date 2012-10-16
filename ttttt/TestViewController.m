//
//  TestViewController.m
//  ttttt
//
//  Created by Tamer Alaa on 9/16/12.
//  Copyright (c) 2012 Tamer Alaa. All rights reserved.
//
typedef enum SocialButtonTags
{
    SocialButtonTagFacebook,
    SocialButtonTagSinaWeibo,
    SocialButtonTagTwitter
} SocialButtonTags;


#import "TestViewController.h"
#import "AddProductDetailViewController.h"
#import "DetailViewController.h"
#import "CreateShoplogTagImage.h"

//#import "MyCustomCell.h"
//#import "HeaderView.h"

@interface TestViewController ()

@end

@implementation TestViewController
{
    NSMutableArray *_objectChanges;
    NSMutableArray *_sectionChanges;
}
@synthesize testarray,mycustomcell,myheaderview,mypopover,detailPopViewController,sharebutton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
//[self.collectionView setNeedsLayout ];


}


- (void) viewWillDisappear: (BOOL) animated {
    [super viewWillDisappear: animated];
    //NSLog( @"In viewWillDisappear" );
    // Force any text fields that might be being edited to end so the text is stored
    [self.collectionView.window endEditing: YES];
}
- (void)viewDidLoad
{
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"ShopLog";
    self.sharing=NO;
    _objectChanges = [NSMutableArray array];
    _sectionChanges = [NSMutableArray array];
    //[self.collectionView reloadData];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.selectedPhotos = [@[] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma the Storyboard Part
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AddCatalogue"]) {
        //  Get a reference to our detail view
        AddProductDetailViewController *addvw = (AddProductDetailViewController *)[segue destinationViewController];
        addvw.edit_add=YES;
        //  Pass the managed object context to the destination view controller
        addvw.managedObjectContext = self.managedObjectContext;
    }
    if ([[segue identifier] isEqualToString:@"Additem"]) {
        //  Get a reference to our detail view
        AddProductDetailViewController *addvw = (AddProductDetailViewController *)[segue destinationViewController];
        
        NSIndexPath *indexpath=[[self.collectionView indexPathsForSelectedItems]lastObject];
        NSLog(@"The String is %i",indexpath.section);
        addvw.edit_add=YES;
        //addvw.cataloguenamefield.text=[[[self.fetchedResultsController sections]objectAtIndex:indexpath.section]name];
        addvw.title=[[[self.fetchedResultsController sections]objectAtIndex:indexpath.section]name];
        NSLog(@"The Header is %@",[[[self.fetchedResultsController sections]objectAtIndex:indexpath.section]name]);
        //  Pass the managed object context to the destination view controller
        addvw.managedObjectContext = self.managedObjectContext;
    }
    
    if ([[segue identifier] isEqualToString:@"ShowDetail1"]) {
        //  Get a reference to our detail view
        DetailPopViewController  *detailview = (DetailPopViewController *)[segue destinationViewController];
        //[self.navigationController presentModalViewController:navController animated:YES];
        [detailview setDetailItem:sender] ;
    
    
    }
        
    //NSLog(@"The Segue is as Follows : %@",[segue identifier]);
}

# pragma The Collection Views Entries

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)collectionView:(UICollectionView*)collectionView
     numberOfItemsInSection:(NSInteger)section {
    //NSArray* sectionArray = [_data objectAtIndex:section];
    //return 6;
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects]+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                    cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    int x;
    x=indexPath.row;
    int y;
    y=[[[self.fetchedResultsController sections]objectAtIndex:indexPath.section]numberOfObjects];
    //NSLog(@"The count is %i   %i",y,x);
    //NSString *cellid=[[NSString alloc]init];
    MyCustomCell *Cc = [[MyCustomCell alloc]init];
    if (indexPath.row<y) {
        Cc = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"forIndexPath:indexPath];
        
        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        Cc.celllabel.text = [[object valueForKey:@"price"] stringValue];
        Cc.cellImage.image = [UIImage imageWithData:[object valueForKey:@"image"]] ;
    } else {
       Cc = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell1"forIndexPath:indexPath];
        Cc.celllabel.hidden=YES;
        Cc.cellImage.image=[UIImage imageNamed:@"plus-sign.png"];
        
    }
    
    
    
    //Cc.celllabel.text = [NSString stringWithFormat:@"Section:%d, Item:%d",indexPath.section, indexPath.item];
    //NSLog(@"The text is :%@",[NSString stringWithFormat:@"Section:%d, Item:%d",indexPath.section, indexPath.item]);
    return Cc;
}
-(UICollectionReusableView *)collectionView:
(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath{

    HeaderView *Hv =[self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    //NSManagedObject *obj=[self.fetchedResultsController objectAtIndexPath:indexPath];
    Hv.Headerviewlabel.text=[[[self.fetchedResultsController sections]objectAtIndex:indexPath.section]name];
    //Hv.Headerviewlabel.text=[NSString stringWithFormat:@"Section:%d",indexPath.section];;
    return Hv;



}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSManagedObject *obj =[self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.selectedPhotos removeObject:obj];

}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
       
    int jjj=[[[self.fetchedResultsController sections]objectAtIndex:indexPath.section]numberOfObjects];
    BOOL ee= jjj>indexPath.row;
    //NSLog(@"The Integre Logic is %i",ee);
    //NSLog(@"The First Logic is :%i",jj);
    if (ee) {
        if (!self.sharing) {
            //Youtube Method
            UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
            //NSLog(@"The Attributes are :%@",attributes);
            //DetailPopViewController *detailpop=[[DetailPopViewController alloc]init];
            
            
            //UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:detailpop];
            if ([mypopover isPopoverVisible]) {
                [mypopover dismissPopoverAnimated:YES];
            } else {
                
                self.detailPopViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"popviewdetail"];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.detailPopViewController];
                //UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:self.detailPopViewController];
                UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:navController];
                self.detailPopViewController.delegate=self;
                //[self.navigationController presentViewController:navController animated:YES completion:nil];
                //[self.navigationController presentViewController:self.detailPopViewController animated:YES completion:nil];

                
                
                
                [pop setPopoverContentSize:CGSizeMake(400, 500)];
                [pop presentPopoverFromRect:attributes.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                NSManagedObject *obj =[self.fetchedResultsController objectAtIndexPath:indexPath];
                
                [detailPopViewController setDetailItem:obj];
                self.mypopover=pop;
                
            }
                        
            
            [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        } else {
            // Todo: Multi-Selection
            NSManagedObject *obj =[self.fetchedResultsController objectAtIndexPath:indexPath];
            [self.selectedPhotos addObject:obj];
            
            //NSLog(@"The Selected Photos are %@ ",self.selectedPhotos);
        
            
        }
    }
    //[mypopover dismissPopoverAnimated:YES];
    
    
    
    
}

- (IBAction)Fuckyou:(UIStoryboardSegue *)segue
{
    
    
}

-(IBAction)shareButtonTapped:(id)sender {
    //UIBarButtonItem *shareButton = (UIBarButtonItem *)sender;
    // 1
    if (!self.sharing) {
        self.sharing = YES;
        [sharebutton setStyle:UIBarButtonItemStyleDone];
        [sharebutton setTitle:@"Done"];
        [self.collectionView setAllowsMultipleSelection:YES];
        NSLog(@"I am allowing Multiple Sharing ");
        
    } else {
        // 2
        self.sharing = NO;
        [sharebutton setStyle:UIBarButtonItemStyleBordered];
        [sharebutton setTitle:@"Share"];
        [self.collectionView setAllowsMultipleSelection:NO];
         NSLog(@"I am NOT allowing Multiple Sharing ");
        NSLog(@"The Selected Photo Count %i",[self.selectedPhotos count]);
        // 3
        if ([self.selectedPhotos count] > 0) {
            [self Activityshowmethod];
            //[self showMailComposerAndSend];
        }
        // 4
        for(NSIndexPath *indexPath in
            self.collectionView.indexPathsForSelectedItems) {
            [self.collectionView
             deselectItemAtIndexPath:indexPath animated:NO];
        }
        [self.selectedPhotos removeAllObjects];
    }
}
-(void)Activityshowmethod{
    for (Shoplog * ChosenPhot in self.selectedPhotos) {
        NSString *initalTextString = [NSString
                                      stringWithFormat:@"Fun Fact: %@",
                                      ChosenPhot.categoryname];
        CreateShoplogTagImage *createimagetag=[[CreateShoplogTagImage alloc]init];
        UIImage *newimage=[createimagetag Imagetag:ChosenPhot];
        UIActivityViewController *activityViewController =
        [[UIActivityViewController alloc]
         initWithActivityItems:@[newimage,
         initalTextString] applicationActivities:nil];
        [self presentViewController:activityViewController
                           animated:YES completion:nil];
    }
    
}
-(void)showMailComposerAndSend {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer =
        [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Check out these Flickr Photos"];
        NSMutableString *emailBody = [NSMutableString string];
        
        for(Shoplog *ChosenPhoto in self.selectedPhotos)
        {
            
            //NSString *tetsimage=[[NSString alloc]initWithData:ChosenPhoto.image encoding:NSUTF8StringEncoding];
            //NSLog(@"The Images Data are %@",ChosenPhoto.image);
            //NSLog(@"The images string are :%@",tetsimage);
            //NSString *url = [Flickr flickrPhotoURLForFlickrPhoto:flickrPhoto size:@"m"];
            [mailer addAttachmentData:ChosenPhoto.image mimeType:@"image/png" fileName:@"Photo"];
            [emailBody appendFormat:@"Sent from my  '%@' Collection",ChosenPhoto.categoryname ];
            //[mailer addAttachmentData:ChosenPhoto.image];
            //[emailBody appendFormat:@"<div><img src='%@'></div><br>",tetsimage];
        }
        [mailer setMessageBody:emailBody isHTML:YES];
        [self presentViewController:mailer animated:YES
                         completion:^{}];
         
    } else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Mail Failure"
                              message:
                              @"Your device doesn't support in-app email"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}
- (void)mailComposeController:
(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES
                                   completion:^{}];
}
-(void)didClickdeleteButton {
    NSLog(@"i was here ");
    if ([mypopover isPopoverVisible]) {
        [mypopover dismissPopoverAnimated:YES];
        [mypopover release];
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    if (popoverController == mypopover) {
        [mypopover release];
    }
}



#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shoplog" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"categoryname" cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}


-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = @(sectionIndex);
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = @(sectionIndex);
            break;
    }
    
    [_sectionChanges addObject:change];
    //NSLog(@"The new section changes are :%@",_sectionChanges);
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [_objectChanges addObject:change];
     //NSLog(@"The new Objects changes are :%@",_objectChanges);
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
    //NSLog(@"section changes: %i", [_sectionChanges count]);
    //NSLog(@"obj changes: %i", [_objectChanges count]);
    if ([_sectionChanges count] > 0)
    {
        [self.collectionView performBatchUpdates:^{
            
            for (NSDictionary *change in _sectionChanges)
            {
               
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    
                    switch (type)
                    {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue ]]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    
    if ([_objectChanges count] > 0 && [_sectionChanges count] == 0)
    {
        [self.collectionView performBatchUpdates:^{
            
            for (NSDictionary *change in _objectChanges)
            {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    //NSLog(@"The new Objects changes are :%@",key);
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type)
                    {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertItemsAtIndexPaths:@[obj]];
                            [self.collectionView.window endEditing:YES];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                            [self.collectionView.window endEditing:YES];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                            //NSLog(@"The new Updated changes are :%@",obj);
                            [self.collectionView.window endEditing:YES];
                            break;
                        case NSFetchedResultsChangeMove:
                            [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                             //NSLog(@"The new moved changes are :%@",obj);
                            [self.collectionView.window endEditing:YES];
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    
    [_sectionChanges removeAllObjects];
    [_objectChanges removeAllObjects];
}



@end
