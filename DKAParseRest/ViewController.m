//
//  ViewController.m
//  DKAParseRest
//
//  Created by Daniel Kerbel on 1/31/15.
//  Copyright (c) 2015 Daniel Kerbel. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import <Parse/Parse.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *createPersonButton;
@property (strong, nonatomic) IBOutlet UIButton *retrievePersonButton;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createPersonButtonPressed:(UIButton *)sender
{
    // Setup Progress Hud
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    [HUD show:YES];
    
    // RESTful POST Request
    
    PFObject *personClass = [PFObject objectWithClassName:@"People"];
    personClass[@"Name"] = @"Dan";
    personClass[@"LastName"] = @"Kerbel";
    
    [personClass saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [HUD hide:YES];
            MBProgressHUD *HUDTwo = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUDTwo];
            HUDTwo.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_green.png"]];
            HUDTwo.mode = MBProgressHUDModeCustomView;
            HUDTwo.delegate = self;
            HUDTwo.labelText = @"Object Created";
            [HUDTwo show:YES];
            [HUDTwo hide:YES afterDelay:2];
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }];

}

- (IBAction)retrievePersonButtonPressed:(UIButton *)sender
{
    // Setup Progress Hud
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    [HUD show:YES];
    
    // RESTful GET Request
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"xyxbSjn10jvcgboDV3fMvYd98GXPcC0n9gYGQZfa" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"u3fB8Egp0BevcKbMgtQqGYba0YjEliW92eYdzG7v" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:@"https://api.parse.com/1/classes/People" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [HUD hide:YES];
        
        MBProgressHUD *HUDTwo = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUDTwo];
        HUDTwo.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_green.png"]];
        HUDTwo.mode = MBProgressHUDModeCustomView;
        HUDTwo.delegate = self;
        HUDTwo.labelText = @"Object Retrieved";
        [HUDTwo show:YES];
        [HUDTwo hide:YES afterDelay:2];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}





















@end
