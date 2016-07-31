//
//  SentegrityTAF_FirstTimeViewController.m
//  Sentegrity
//
//  Created by Ivo Leko on 27/07/16.
//  Copyright © 2016 Sentegrity. All rights reserved.
//

#import "ISHPermissionKit.h"
#import "Sentegrity_TrustFactor_Datasets.h"


#import "SentegrityTAF_FirstTimeViewController.h"
#import "SentegrityTAF_WelcomeViewController.h"
#import "SentegrityTAF_AskPermissionsViewController.h"
#import "SentegrityTAF_PasswordCreationViewController.h"
#import "SentegrityTAF_UnlockViewController.h"


typedef enum {
    CurrentStateUnknown = 0,
    CurrentStateWelcome,
    CurrentStateAskingPermissions,
    CurrentStatePasswordCreation,
    CurrentStateUnlock,
} CurrentState;

@interface SentegrityTAF_FirstTimeViewController () <SentegrityTAF_basicProtocol>

@property (strong, nonatomic) SentegrityTAF_PasswordCreationViewController *passwordCreationViewController;
@property (strong, nonatomic) SentegrityTAF_AskPermissionsViewController *askPermissionsViewController;
@property (strong, nonatomic) SentegrityTAF_WelcomeViewController *welcomeViewController;
@property (nonatomic, strong) SentegrityTAF_UnlockViewController *unlockViewController;

@property (nonatomic, strong) UIViewController *currentViewController;

//helper for managing viewController's views
@property (weak, nonatomic) IBOutlet ILContainerView *containerView;

//current Sentegrity First time state
@property (nonatomic) CurrentState currentState;


@end

@implementation SentegrityTAF_FirstTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.containerView setCurrentViewController:self];
    
    //show welcome screen
    [self showWelcome];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setCurrentViewController:(UIViewController *)currentViewController {
    
    //show currentViewController on the screen
    [self.containerView setChildViewController:currentViewController];
    _currentViewController = currentViewController;
    
}

- (void)updateUIForNotification:(enum DAFUINotification)event {
    // We don't expect this VC to be active during a change-password
    // sequence. If this becomes a valid situation, fix this code to dismiss
    // this VC (see DAFSkelUnlockViewController).
    
    NSAssert( !(event == ChangePasswordCancelled && _result != nil), @"Unexpected ChangePasswordCancelled");
}

- (void) dismissSuccesfullyFinishedViewController:(UIViewController *) vc {
    //clear current state
    CurrentState lastCurrentState = _currentState;
    _currentState = CurrentStateUnknown;
    
    //after welcome screen, we need to show permission screen
    if (lastCurrentState == CurrentStateWelcome) {
        [self showAskingForPermissions];
    }
    
    //after permission screen, we need to show password creation screen
    else  if (lastCurrentState == CurrentStateAskingPermissions) {
        [self showPasswordCreationWithResult:self.result];
    }
    
    //after creation of password, show unlock screen and run core detection
    else  if (lastCurrentState == CurrentStatePasswordCreation) {
        [self showUnlockWithResult:self.result];
    }

    //finished everything for first time run, proceed to DAF
    else {
        [self dismissViewControllerAnimated:NO completion: ^{
            self.result = nil;
        }];
    }
}



- (void) showWelcome {
    SentegrityTAF_WelcomeViewController *welcome = [[SentegrityTAF_WelcomeViewController alloc] init];
    welcome.delegate = self;
    
    //set new screen and state
    self.currentState = CurrentStateWelcome;
    self.welcomeViewController = welcome;
    self.currentViewController = welcome;
}

- (void) showAskingForPermissions {
    SentegrityTAF_AskPermissionsViewController *askingPermission = [[SentegrityTAF_AskPermissionsViewController alloc] init];
    askingPermission.delegate = self;
    askingPermission.permissions = self.applicationPermissions;
    askingPermission.activityDispatcher = self.activityDispatcher;
    
    //set new screen and state
    self.currentState = CurrentStateAskingPermissions;
    self.askPermissionsViewController = askingPermission;
    self.currentViewController = askingPermission;
}



- (void) showPasswordCreationWithResult: (DAFWaitableResult *)result {
    
    SentegrityTAF_PasswordCreationViewController *passwordCreationViewController;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        // iPhone View Controllers
        passwordCreationViewController = [[SentegrityTAF_PasswordCreationViewController alloc] initWithNibName:@"SentegrityTAF_PasswordCreationViewController_iPhone" bundle:nil];
        
    } else {
        
        // iPad View Controllers
        passwordCreationViewController = [[SentegrityTAF_PasswordCreationViewController alloc] initWithNibName:@"SentegrityTAF_PasswordCreationViewController_iPad" bundle:nil];
    }
    
    passwordCreationViewController.delegate = self;
    passwordCreationViewController.result = self.result;
    
    //set new screen and state
    self.currentState = CurrentStatePasswordCreation;
    self.passwordCreationViewController = passwordCreationViewController;
    self.currentViewController = passwordCreationViewController;
}

- (void) showUnlockWithResult: (DAFWaitableResult *)result{
    
    
    SentegrityTAF_UnlockViewController *unlockViewController;
    
    // Get the nib for the device
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        // iPhone View Controllers
        unlockViewController = [[SentegrityTAF_UnlockViewController alloc] initWithNibName:@"SentegrityTAF_UnlockViewController_iPhone" bundle:nil];
        
    } else {
        
        // iPad View Controllers
        unlockViewController = [[SentegrityTAF_UnlockViewController alloc] initWithNibName:@"SentegrityTAF_UnlockViewController_iPad" bundle:nil];
    }
    
    unlockViewController.delegate = self;
    [unlockViewController setResult:result];
    
    //set new screen and state
    self.currentState = CurrentStateUnlock;
    self.unlockViewController = unlockViewController;
    self.currentViewController = unlockViewController;
    
    
}





@end
