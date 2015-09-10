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
@dynamic delegate;

#pragma mark - lifeCycle methods

- (instancetype)init {
    ARPhotoPickerGroupController *groupController = [[ARPhotoPickerGroupController alloc] init];
    
    self = [super initWithRootViewController:groupController];
    if (self) {
        _autoPushToUserPhotoLibrary = YES;
        groupController.autoPushToUserPhotoLibrary = _autoPushToUserPhotoLibrary;
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
