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
}

- (IBAction)presentButtonClicked:(id)sender {
    
    ARPhotoPickerController *picker = [[ARPhotoPickerController alloc] init];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
