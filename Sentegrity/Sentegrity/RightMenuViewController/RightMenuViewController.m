//
//  RightMenuViewController.m
//  Sentegrity
//
//  Created by Kramer on 6/12/15.
//  Copyright (c) 2015 Sentegrity. All rights reserved.
//

#import "RightMenuViewController.h"

// Get the trustfactor storage class
#import "Sentegrity_TrustFactor_Storage.h"

// RESideMenu
#import "RESideMenu.h"

// Flat Colors
#import "Chameleon.h"

// Alerts
#import "SCLAlertView.h"

@interface RightMenuViewController ()

// Create the tableview
@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set the background color
    [self.view setBackgroundColor:[UIColor flatWhiteColor]];
    
    // Set the tableview
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (54), self.view.frame.size.width, 54 * 4) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3: {
            // Reset Stores
            
            // Create the alert
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            
            // Use Blocks for the reset button
            [alert addButton:@"Reset" actionBlock:^{
                // handle successful validation here
                NSLog(@"Chose to reset the stores");
                
                // Create an error
                NSError *error;
                
                // Get the documents path and list all the files in it
                NSArray * dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[Sentegrity_TrustFactor_Storage sharedStorage] storePath] error:&error];
                
                // Check for an error
                if (error != nil) {
                    NSLog(@"Error getting contents of directory: %@", error.debugDescription);
                    // Error out
                    return;
                }
                
                // Create a predicate to get only the .store files
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self ENDSWITH '.store'"];
                
                // List only the .store files
                NSArray *storageFiles = [dirContents filteredArrayUsingPredicate:predicate];
                
                // Remove the files
                for (NSString *store in storageFiles) {
                    NSLog(@"Removing Store: %@", store);
                    
                    // Remove each store
                    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", [[Sentegrity_TrustFactor_Storage sharedStorage] storePath], store] error:&error];
                    
                    // Check for an error
                    if (error != nil) {
                        NSLog(@"Error getting contents of directory: %@", error.debugDescription);
                        // Error out
                        return;
                    }
                }
            }];
            
            // Show the alert
            [alert showWarning:self title:@"Reset Assertion Stores" subTitle:@"Are you sure you want to reset the Assertion Stores?" closeButtonTitle:@"Cancel" duration:0.0f]; // Warning
    
            break;
        }
        default:
            [self.sideMenuViewController hideMenuViewController];
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"User Debug", @"System Debug", @"Computation Info", @"Reset Stores"];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end