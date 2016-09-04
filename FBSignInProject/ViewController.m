//
//  ViewController.m
//  FBSignInProject
//
//  Created by LandtoSky on 9/4/16.
//  Copyright © 2016 landtosky2018. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

#pragma mark - Facebook Login
- (IBAction)onLoginFacebook:(id)sender {
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    
    if([FBSDKAccessToken currentAccessToken]){
        [self fetchUserInfo];
    }else{
        [login
         logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 NSLog(@"Process error");
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             } else {
                 NSLog(@"Logged in with token : @%@", result.token);
                 if ([result.grantedPermissions containsObject:@"email"]) {
                     
                     [self performSelectorOnMainThread:@selector(fetchUserInfo) withObject:nil waitUntilDone:YES];
                 }
             }
         }];
    }
}

- (void)fetchUserInfo {
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, first_name, last_name, email, friends"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 //                 NSLog(@"facebook fetched info : %@", result);
                 
                 
                 NSDictionary *temp = (NSDictionary *)result;
                 NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                 [userInfo setObject:[temp objectForKey:@"id"] forKey:@"user_facebook_id"];
                 //                 [userInfo setObject:@"974491135946165" forKey:@"user_facebook_id"];
                 
                 [userInfo setObject:[temp objectForKey:@"email"] forKey:@"user_email"];
                 
                 
                 
                 if([commonUtils checkKeyInDic:@"first_name" inDic:[temp mutableCopy]]) {
                     [userInfo setObject:[temp objectForKey:@"first_name"] forKey:@"user_first_name"];
                 }
                 if([commonUtils checkKeyInDic:@"last_name" inDic:[temp mutableCopy]]) {
                     [userInfo setObject:[temp objectForKey:@"last_name"] forKey:@"user_last_name"];
                 }
                 
                 

                 NSString *fbProfilePhoto = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [temp objectForKey:@"id"]];
                 [userInfo setObject:fbProfilePhoto forKey:@"user_photo_url"];
                 
                 

                     [self requestUserSignUp:userInfo];
               

             }else {
                 NSLog(@"Facebook Fetch Error %@",error);
             }
         }];
        
    }
    
}

- (void) requestUserSignUp:(NSDictionary *)param{
  
    NSLog(@"FB User Info ==>\n%@", param);
    
}


@end
