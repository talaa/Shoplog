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
#import "Shoplogactivity.h"



//#import "MyCustomCell.h"
//#import "HeaderView.h"

@interface TestViewController ()

@end

@implementation TestViewController
{
    NSMutableArray *_objectChanges;
    NSMutableArray *_sectionChanges;
}
@synthesize testarray,mycustomcell,myheaderview,mypopover,detailPopViewController,sharebutton,searcharray;
#pragma Icloud Part 
- (void)reloadFetchedResults:(NSNotification*)note {
    NSLog(@"Underlying data changed ... refreshing!");
    [self.collectionView reloadData];
    [self controllerDidChangeContent:self.fetchedResultsController ];
    //[self.collectionView setNeedsDisplay];
    //[self performFetch];
}
- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [self controllerDidChangeContent:self.fetchedResultsController ];
    [self.collectionView reloadData];
//[self.collectionView setNeedsLayout ];


}
- (void)handleOpenURL:(NSURL *)url {
    [self.navigationController popToViewController:self animated:YES];
    //NSData *dataimported=[NSData dataWithContentsOfURL:url];
    NSMutableArray *recievedarray=[NSMutableArray arrayWithContentsOfURL:url];
    NSLog(@"The Recived Array is %i",[recievedarray count]);
    for (NSDictionary  *tempdict in recievedarray) {
        //Shoplog *moc=[[Shoplog alloc]init];
        NSManagedObjectContext *context=self.managedObjectContext;
        Shoplog *newMOC=[ExtendedManagedObject createManagedObjectFromDictionary:tempdict inContext:context];
        
        //  Commit item to core data
        NSError *error;
        if (![newMOC.managedObjectContext save:&error])
            NSLog(@"Failed to add new picture with error: %@", [error domain]);
        else{
            NSLog(@"The New Item is :%@",newMOC);
            
        }

         
         
        [self.collectionView reloadData];
        [recievedarray removeAllObjects];
        //[Shoplog createManagedObjectFromDictionary:tempdict inContext:self.managedObjectContext];
    }
   // NSKeyedUnarchiver *importunarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:dataimported];
    //NSLog(@"The Unarchiver is %@:",importunarchiver);
    //NSMutableArray *ggg=[importunarchiver decodeObject];
    //NSLog(@"The Fuck Array is :%@",ggg);
    //NSMutableArray *ggg=[importunarchiver];
    //NSMutableArray *ggg=[NSKeyedUnarchiver unarchiveObjectWithData:dataimported];
    //Shoplog *pii=[[Shoplog alloc]initWithCoder:NSK];
    //Shoplog *pi=[NSKeyedUnarchiver unarchiveObjectWithData:dataimported];
    //NSLog(@"The Shoplog file%@",pi.managedObjectContext);
    //Shoplog *pi=[[NSKeyedUnarchiver alloc]initForReadingWithData:dataimported];
    //NSLog(@"The Fuck Array is :%@",ggg);
    //pi=[importunarchiver unarchive];
    //NSMutableArray *fucarray=[[NSMutableArray alloc]initWithContentsOfURL:url];
    //NSMutableArray *fucarray=[[NSMutableArray alloc]initWithContentsOfFile:url];
    //NSLog(@"The url is :%@",url);
    //NSLog(@"The Fuck Array is :%@",fucarray);
    //[self addimporteditems:[Shoplog importedarray:url]];
    //[self addimporteditems:fucarray];
    
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
    //self.addarray = [@[] mutableCopy];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadFetchedResults:)
                                                 name:@"SomethingChanged"
                                               object:[[UIApplication sharedApplication] delegate]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"I have Received Memory Warning ");
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
        //NSIndexPath *indexpath=[[self.collectionView indexPathsForSelectedItems]sender];
        //DetailPopViewController  *detailview = (DetailPopViewController *)[segue destinationViewController];
        //[self.navigationController presentModalViewController:navController animated:YES];
        
        //[detailview setDetailItem:sender] ;
        //[self presentViewController:detailview animated:YES completion:nil];
    
    
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
        Cc.ratinglabel.text=[[object valueForKey:@"rating"]stringValue];
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
    NSString *Headlabel=[[NSString alloc]initWithString:[[[self.fetchedResultsController sections]objectAtIndex:indexPath.section]name]];
    
    Hv.Headerviewlabel.text=Headlabel;
    Hv.searchstring=Headlabel;
    //Hv.Headerviewlabel.text=[[[self.fetchedResultsController sections]objectAtIndex:indexPath.section]name];
    [self.searcharray addObject:[[[self.fetchedResultsController sections]objectAtIndex:indexPath.section]name]];
     //NSLog(@"I am Searching Right now%@ ",self.searcharray);
    [Hv.searchButton addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchDown];
    //[Hv.searchButton performSelector:@selector(buttonPressed) withObject:Headlabel];
    
    return Hv;



}

-(IBAction)buttonPressed:(id)sender{
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    CGPoint point = [tap locationInView:self.view];
    //NSIndexPath *HeaderIndexPath=[self.collectionView indexPathForItemAtPoint:<#(CGPoint)#>]
    HeaderView *Hvv=[[HeaderView alloc]init];
    //Hvv.searchButton.viewForBaselineLayout.layer.frame.origin
    NSIndexPath *indexpahser=[self.collectionView indexPathForItemAtPoint:point];
    NSString *searchterm=[[[self.fetchedResultsController sections]objectAtIndex:indexpahser.section]name];
    [PopoverView showPopoverAtPoint:point inView:self.collectionView withStringArray:[NSArray arrayWithObjects:@"Sync", @"Search", nil] delegate:self];
    /*
    UIActivityViewController *activityViewController2 =[[UIActivityViewController alloc]initWithActivityItems:self.searcharray applicationActivities:nil];
    
    
    [self presentViewController:activityViewController2 animated:YES completion:^{}];
 
     */
    NSLog(@"I am Searching Right now%@ ",searchterm);


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
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    self.detailPopViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"popviewdetail"];
                    
                    NSManagedObject *obj =[self.fetchedResultsController objectAtIndexPath:indexPath];
                    [self.detailPopViewController setDetailItem:obj];
                    NSLog(@"Waiting");
                    UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:self.detailPopViewController];
                    
                    self.detailPopViewController.delegate=self;
                    [pop presentPopoverFromRect:attributes.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                    self.mypopover=pop;
                    //[self performSegueWithIdentifier:@"ShowDetail1" sender:collectionView ];
                    
                
                }else{
                self.detailPopViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"popviewdetail"];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.detailPopViewController];
                //UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:self.detailPopViewController];
                UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:navController];
                self.detailPopViewController.delegate=self;
                //[self.navigationController presentViewController:navController animated:YES completion:nil];
                //[self.navigationController presentViewController:self.detailPopViewController animated:YES completion:nil];

                
                
                
                [pop setPopoverContentSize:CGSizeMake(280, 280)];
                [pop presentPopoverFromRect:attributes.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                NSManagedObject *obj =[self.fetchedResultsController objectAtIndexPath:indexPath];
                
                [detailPopViewController setDetailItem:obj];
                self.mypopover=pop;
                }
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


- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
        //NSLog(@"I have Saved Already the Object ");
    [self didClickdeleteButton];
    if ([[notification name] isEqualToString:@"TestNotification"])
        [self.collectionView reloadData];
        NSLog (@"Successfully received the test notification!");
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
        //NSLog(@"The Selected Photo Count %i",[self.selectedPhotos count]);
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
        //[self.addarray removeAllObjects];
    }
}
-(void)Activityshowmethod{
    NSLog(@"The Selected Photo Count %i",[self.selectedPhotos count]);
    //UIActivityViewController *activityViewController2 =[[UIActivityViewController alloc]init];
    NSMutableArray *newArray=[[NSMutableArray alloc]init];
    NSMutableArray *newArraytext=[[NSMutableArray alloc]init];
    Shoplogactivity *shopactivity=[[Shoplogactivity alloc]init];
    
    [shopactivity setSelectedthings:self.selectedPhotos];
    for (Shoplog * ChosenPhot in self.selectedPhotos) {
        
        NSString *initalTextString = [NSString
                                      stringWithFormat:@"I am Sending from my Shoplog Collection: %@",
                                      ChosenPhot.categoryname];
        //[newArraytext arrayByAddingObject:initalTextString];
        [newArraytext addObject:initalTextString];
        CreateShoplogTagImage *createimagetag=[[CreateShoplogTagImage alloc]init];
        UIImage *newimage=[createimagetag Imagetag:ChosenPhot];
        
        [newArray addObject:newimage];

    }
    //NSMutableArray *addArray=[[NSMutableArray alloc]initWithObjects:newArray,newArraytext, nil];
    
    //[self.addarray addObjectsFromArray:newArray];
    NSMutableArray *addArray=[[NSMutableArray alloc]initWithArray:newArray];
    [addArray addObjectsFromArray:newArraytext];
    //[self.addarray addObjectsFromArray:newArraytext];
    [addArray addObjectsFromArray:[self makefile]];
    //NSLog(@"The addarray is  %@",self.addarray);
    //UIActivityViewController *activityViewController2 =[[UIActivityViewController alloc]initWithActivityItems:self.addarray applicationActivities:@[shopactivity]];
    //testitemprovider *tetet=[[testitemprovider alloc]init];
    //NSArray *items = [NSArray arrayWithObjects:tetet,nil];
    UIActivityViewController *activityViewController2 =[[UIActivityViewController alloc]initWithActivityItems:addArray applicationActivities:@[shopactivity]];
    
    [self presentViewController:activityViewController2 animated:YES completion:^{}];
}

-(NSMutableArray*)makefile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Shoplog.slog"];
    //NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
    NSLog(@"The String of the Path is :%@",self.selectedPhotos);
    //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.selectedPhotos];
    
    
    NSMutableArray *ftarray=[[NSMutableArray alloc]init];
    int r;
    for (r=0; r<[self.selectedPhotos count]; r++) {
        
    
        for (Shoplog *rrr in self.selectedPhotos) {
            
        NSDictionary *tempdict=[rrr toDictionary];
        NSLog(@"The NSObject is :%@",tempdict);
        [ftarray addObject:tempdict];
        }
    }
    //NSLog(@"The String of the Path is :%@",ftarray);
    [ftarray writeToFile:filePath atomically:YES];
    //NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:self.selectedPhotos];
    //[self.selectedPhotos writeToFile:filePath atomically:YES];
    
    //[savedData writeToFile:filePath atomically:YES];
    NSURL *turl=[[NSURL alloc]initFileURLWithPath:filePath];
    NSMutableArray *jjooll=[[NSMutableArray alloc]initWithObjects:turl, nil];
    NSLog(@"The String of the Path is :%@",documentsDirectory);
    
    return jjooll;



}
-(void)didClickdeleteButton {
    NSLog(@"i was here ");
    if ([mypopover isPopoverVisible]) {
        [mypopover dismissPopoverAnimated:YES];
        //[mypopover release];
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    if (popoverController == mypopover) {
        //[mypopover release];
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
