//
//  ARPhotoPickerController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerController.h"
#import "ARPhotoPickerGroupController.h"
#import "ARPhotoPickerMacros.h"

NSString *const ARPhotoPickerControllerOriginalImageKey = @"ARPhotoPickerControllerOriginalImageKey";

@interface ARPhotoPickerController ()<ARPhotoPickerGroupControllerDelegate>

@end

@implementation ARPhotoPickerController
@dynamic delegate;

#pragma mark - lifeCycle methods

- (instancetype)init {
    ARPhotoPickerGroupController *groupController = [[ARPhotoPickerGroupController alloc] init];
    self = [super initWithRootViewController:groupController];
    if (self) {
        _autoPushToUserPhotoLibrary = YES;
        _allowsMultipleSelection = YES;
        groupController.autoPushToUserPhotoLibrary = _autoPushToUserPhotoLibrary;
        groupController.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setUp];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ARPhotoPickerAssetsControllerDismissNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ARPhotoPickerAssetsControllerSelectAssetNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

- (void)_setUp {
    
//    self.navigationBar.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//    [self.navigationBar setBarTintColor:[UIColor blackColor]];
//    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
//                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]};
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(assetsControllerDidDismissed:)
                                                 name:ARPhotoPickerAssetsControllerDismissNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(assetsControllerDidSelectAsset:)
                                                 name:ARPhotoPickerAssetsControllerSelectAssetNotification
                                               object:nil];
}

#pragma mark - ARPhotoPickerGroupControllerDelegate methods

- (void)photoPickerGroupControllerDidCancel:(ARPhotoPickerGroupController *)controller {
    if ([self.delegate respondsToSelector:@selector(photoPickerControllerDidCancel:)]) {
        [self.delegate photoPickerControllerDidCancel:self];
    }
}

#pragma mark - asset controller notification methods

- (void)assetsControllerDidDismissed:(NSNotification *)notification {
    if ([self.delegate respondsToSelector:@selector(photoPickerControllerDidCancel:)]) {
        [self.delegate photoPickerControllerDidCancel:self];
    }
}

- (void)assetsControllerDidSelectAsset:(NSNotification *)notification {
    PHAsset *asset = notification.object;
    if ([self.delegate respondsToSelector:@selector(photoPickerController:didPickingMediaWithAsset:)]) {
        [self.delegate photoPickerController:self didPickingMediaWithAsset:asset];
    }
}

@end
