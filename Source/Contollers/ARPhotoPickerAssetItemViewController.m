//
//  ARPhotoPickerAssetItemViewController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerAssetItemViewController.h"

@interface ARPhotoPickerAssetItemViewController ()

@end

@implementation ARPhotoPickerAssetItemViewController

#pragma mark - lifeCycle methods

- (instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        _asset = asset;
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
    self.view.backgroundColor = [UIColor redColor];
}

@end
