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

@interface ARPhotoPickerAssetItemViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, weak) NSLayoutConstraint *imageCenterXConstraint;
@property(nonatomic, weak) NSLayoutConstraint *imageCenterYConstraint;
@property(nonatomic, weak) NSLayoutConstraint *imageWidthConstraint;
@property(nonatomic, weak) NSLayoutConstraint *imageHeightConstraint;

@property(nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;

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

  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.delegate = self;
  [self.view addSubview:self.scrollView];

  self.imageView = [[UIImageView alloc] init];
  self.imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.imageView.backgroundColor = [UIColor grayColor];
  [self.scrollView addSubview:self.imageView];

  // layout
  [self.scrollView makeConstraints:^(ELConstraintsMaker *make) {
    make.ELAllEdges.equalTo(@0);
  }];

  [self.imageView makeConstraints:^(ELConstraintsMaker *make) {
    make.ELCenter.equalTo(self.scrollView);
    make.ELWidth.equalTo(self.scrollView);
  }];
  // imageView gesture
  self.doubleTapGesture = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(doubleTapGestureHandle:)];
  self.doubleTapGesture.numberOfTapsRequired = 2;
  [self.imageView addGestureRecognizer:self.doubleTapGesture];

  // fill image
  [_asset requestOriginalImageCompletion:^(UIImage *image, NSDictionary *info) {
    self.imageView.image = image;
    [self aspectToFitHeightWithImage:image];
  }];
}

- (void)aspectToFitHeightWithImage:(UIImage *)image {
  CGFloat ratio = image.size.height / image.size.width;
  self.imageHeightConstraint =
      [NSLayoutConstraint constraintWithItem:self.imageView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.imageView
                                   attribute:NSLayoutAttributeWidth
                                  multiplier:ratio
                                    constant:0];
  [self.imageHeightConstraint setActive:YES];
  [self.view layoutIfNeeded];
}

#pragma mark - event methods

- (void)doubleTapGestureHandle:(UITapGestureRecognizer *)tap {
  if (tap.state == UIGestureRecognizerStateEnded) {
    [self.imageWidthConstraint setActive:NO];
  }
}

@end
