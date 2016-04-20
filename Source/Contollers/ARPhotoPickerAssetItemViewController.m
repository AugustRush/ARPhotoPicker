//
//  ARPhotoPickerAssetItemViewController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerAssetItemViewController.h"
#import "PHAsset+ARPhotoPicker.h"
#import <EasyLayout.h>

@interface ARPhotoPickerAssetItemViewController () <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, assign) BOOL scaled;

//@property(nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;

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

#pragma mark - system methods

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - private methods

- (void)_setUp {

  self.scrollView = [[UIScrollView alloc] init];
  //  self.scrollView.minimumZoomScale = 1.0;
  //  self.scrollView.maximumZoomScale = 2.0;
  self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
  self.scrollView.delegate = self;
  [self.view addSubview:self.scrollView];

  self.contentView = [[UIView alloc] init];
  [self.scrollView addSubview:self.contentView];

  self.imageView = [[UIImageView alloc] init];
  self.imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.imageView.backgroundColor = [UIColor grayColor];
  [self.contentView addSubview:self.imageView];

  // layout

  [self.scrollView makeConstraints:^(ELConstraintsMaker *make) {
    make.ELAllEdges.equalTo(@0);
  }];

  [self.contentView makeConstraints:^(ELConstraintsMaker *make) {
    make.ELAllEdges.equalTo(@0);
    make.ELSize.equalTo(self.view);
  }];

  [self.imageView makeConstraints:^(ELConstraintsMaker *make) {
    make.ELCenter.equalTo(@0);
    make.ELWidth.equalTo(self.contentView);
  }];

  // contentView gesture
  UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(doubleTapGestureHandle:)];
  doubleTapGesture.numberOfTapsRequired = 2;
  [self.contentView addGestureRecognizer:doubleTapGesture];

  UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(singleTapGestureHandle:)];
  [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
  [self.contentView addGestureRecognizer:singleTapGesture];

  // fill image
  [_asset requestOriginalImageCompletion:^(UIImage *image, NSDictionary *info) {
    self.imageView.image = image;
    [self aspectToFitHeightWithImage:image];
  }];
}

- (void)aspectToFitHeightWithImage:(UIImage *)image {
  CGFloat ratio = image.size.height / image.size.width;
  [self.imageView updateConstraints:^(ELConstraintsMaker *make) {
    make.ELHeight.equalTo(self.imageView.ELWidth)
        .multiplier(ratio)
        .constraint();
  }];
  [self.view layoutIfNeeded];
}

- (void)animatedZoomWithScale:(CGFloat)scale {
  [self.contentView updateConstraints:^(ELConstraintsMaker *make) {
    make.ELWidth.equalTo(self.view).multiplier(scale);
  }];
  [UIView animateWithDuration:0.25
                   animations:^{
                     [self.scrollView layoutIfNeeded];
                   }];
}

- (void)animatedNavigationBarAndStatusBarHidden:(BOOL)hidden {
  [[UIApplication sharedApplication]
      setStatusBarHidden:hidden
           withAnimation:UIStatusBarAnimationNone];
  [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

#pragma mark - event methods

- (void)doubleTapGestureHandle:(UITapGestureRecognizer *)tap {
  if (tap.state == UIGestureRecognizerStateEnded) {
    CGFloat scale = CGRectGetHeight(self.view.bounds) /
                    CGRectGetHeight(self.imageView.bounds);
    if (!_scaled) {
      [self animatedZoomWithScale:scale];
      [self animatedNavigationBarAndStatusBarHidden:YES];
    } else {
      [self animatedZoomWithScale:1.0];
    }
    self.scaled = !self.scaled;
  }
}

- (void)singleTapGestureHandle:(UITapGestureRecognizer *)tap {
  if (tap.state == UIGestureRecognizerStateEnded) {
    BOOL isHidden = self.navigationController.isNavigationBarHidden;
    [self animatedNavigationBarAndStatusBarHidden:!isHidden];
  }
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [self animatedNavigationBarAndStatusBarHidden:YES];
}

@end
