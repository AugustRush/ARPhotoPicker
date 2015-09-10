//
//  ARPhotoPickerController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerController.h"
#import "ARPhotoPickerGroupController.h"

@interface ARPhotoPickerController ()

@end

@implementation ARPhotoPickerController

#pragma mark - lifeCycle methods

- (instancetype)init {
    self = [super initWithRootViewController:[[ARPhotoPickerGroupController alloc] init]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setUp];
}

- (void)dealloc {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

- (void)_setUp {
    
}

@end
