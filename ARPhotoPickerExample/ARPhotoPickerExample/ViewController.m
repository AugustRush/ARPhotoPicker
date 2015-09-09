//
//  ViewController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARPhotoPicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)presentButtonClicked:(id)sender {
    
    ARPhotoPickerGroupController *picker = [[ARPhotoPickerGroupController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:picker];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
