//
//  ARPhotoPickerPreviewController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerPreviewController.h"
#import "ARPhotoPickerAssetItemViewController.h"

@interface ARPhotoPickerPreviewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *assets;

@end

@implementation ARPhotoPickerPreviewController

#pragma mark - lifeCycle methods

- (instancetype)initWithAssets:(NSArray *)assets {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@30.f}];
    if (self) {
        self.assets = assets;
        self.dataSource = self;
        self.delegate = self;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setUp];
}

#pragma mark - private methods

- (void)_setUp {
    self.view.backgroundColor = [UIColor blackColor];
    
    if (self.assets.count > 0) {
        ARPhotoPickerAssetItemViewController *assetItemViewController = [[ARPhotoPickerAssetItemViewController alloc] initWithAsset:self.assets[0]];
        
        [self setViewControllers:@[assetItemViewController]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO completion:nil];
    }
}

#pragma mark - UIPageViewControllerDelegate methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    ARPhotoPickerAssetItemViewController *assetItemViewContoller = (ARPhotoPickerAssetItemViewController *)viewController;
    PHAsset *asset = assetItemViewContoller.asset;
    NSUInteger index = [self.assets indexOfObject:asset];
    if (index > 0) {
        PHAsset *beforeAsset = self.assets[index - 1];
        ARPhotoPickerAssetItemViewController *beforeAssetItemViewContoller = [[ARPhotoPickerAssetItemViewController alloc] initWithAsset:beforeAsset];
        return beforeAssetItemViewContoller;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    ARPhotoPickerAssetItemViewController *assetItemViewContoller = (ARPhotoPickerAssetItemViewController *)viewController;
    PHAsset *asset = assetItemViewContoller.asset;
    NSUInteger index = [self.assets indexOfObject:asset];
    if (index < self.assets.count - 1) {
        PHAsset *afterAsset = self.assets[index + 1];
        ARPhotoPickerAssetItemViewController *afterAssetItemViewContoller = [[ARPhotoPickerAssetItemViewController alloc] initWithAsset:afterAsset];
        return afterAssetItemViewContoller;
    }
    return nil;
}

#pragma mrk - UIPageViewControllerDataSource methods

@end
