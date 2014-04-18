//
//  DBZ_LoginView.m
//  Universal Presenter Remote
//
//  Created by Brendan Boyle on 4/16/14.
//  Copyright (c) 2014 DBZ Technology. All rights reserved.
//

#import "DBZ_LoginView.h"
#import "DBZ_ServerCommunication.h"

@interface DBZ_LoginView ()

@end

@implementation DBZ_LoginView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateInterface:) name:@"UpdateInterface" object:nil];
    [DBZ_ServerCommunication setupUid];
    [DBZ_ServerCommunication checkStatus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateInterface:(NSNotification *)notification {
    int inttoken = [DBZ_ServerCommunication temptoken];
    if (inttoken > 10) {
        [_tokenLabel setText:[NSString stringWithFormat:@"%d",inttoken]];
    }
    switch ([DBZ_ServerCommunication controlmode]) {
        case 0:
            [_connectButton setEnabled:NO];
            [_connectButton setTitle:@"Connecting..." forState:UIControlStateDisabled];
            break;
        case 1:
            [_connectButton setEnabled:NO];
            [_connectButton setTitle:@"Waiting..." forState:UIControlStateDisabled];
            break;
        case 2:
            [_connectButton setEnabled:YES];
            [_connectButton setTitle:@"Connect" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [DBZ_ServerCommunication connectSetup];
}

@end
