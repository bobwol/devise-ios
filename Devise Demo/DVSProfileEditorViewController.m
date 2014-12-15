//
//  ProfileEditorViewController.m
//  Devise
//
//  Created by Grzegorz Lesiak on 20/11/14.
//  Copyright (c) 2014 Netguru.co. All rights reserved.
//

#import "DVSProfileEditorViewController.h"
#import <Devise/Devise.h>

#import "UIAlertView+Devise.h"
#import "DVSDemoUser.h"
#import "DVSDemoUserDataSource.h"

static NSString * const DVSProfileEditorEmailTitle = @"E-mail address";

@interface DVSProfileEditorViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) DVSDemoUserDataSource *userDataSource;

@end

@implementation DVSProfileEditorViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDataSource = [[DVSDemoUserDataSource alloc] init];
    
    [self addFormWithTitleToDataSource:DVSProfileEditorEmailTitle];
}

#pragma mark - UIButtons events

- (IBAction)saveButtonTouched:(UIBarButtonItem *)sender {
    DVSDemoUser *localUser = [DVSDemoUser localUser];
    
    localUser.dataSource = self.userDataSource;
    localUser.email = [self getValueForTitle:DVSProfileEditorEmailTitle];
    
    [localUser updateWithSuccess:^{
        [[[UIAlertView alloc] initWithTitle:@"Profile updated"
                                    message:@"Your profile was updated."
                                   delegate:self
                          cancelButtonTitle:[self titleForProfileUpdatedAlertCancelButton]
                          otherButtonTitles:nil] show];
    } failure:^(NSError *error) {
        [[UIAlertView dvs_alertViewForError:error] show];
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:[self titleForProfileUpdatedAlertCancelButton]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSString *)titleForProfileUpdatedAlertCancelButton {
    return @"Close";
}

@end
