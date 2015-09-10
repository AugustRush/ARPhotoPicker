//
//  ARPhotoPickerController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerGroupController.h"
#import "ARPhotoPickerGroupCell.h"

@interface ARPhotoPickerGroupController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) PHFetchResult *fetchResult;

@end

@implementation ARPhotoPickerGroupController

static NSString *reuseIdentifier = @"ARPhotoPickerGroupCell";

#pragma mark - lifeCycle methods

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _initConfigs];
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

- (void)_initConfigs {
#if TARGET_IPHONE_SIMULATOR
    self.collectionType = PHAssetCollectionTypeSmartAlbum;
    self.collectionSubType = PHAssetCollectionSubtypeSmartAlbumUserLibrary;
#else
    self.collectionType = PHAssetCollectionTypeAlbum;
    self.collectionSubType = PHCollectionListSubtypeAny;
#endif
}

- (void)_setUp {
    
    self.navigationItem.title = @"My Photos";
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:
                             self.collectionType
                                                                     subtype:self.collectionSubType
                                                                     options:nil];
    self.fetchResult = result;
    [self.tableView registerNib:[UINib nibWithNibName:@"ARPhotoPickerGroupCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelItemClicked:)];
    self.navigationItem.leftBarButtonItem = cancelItem;
}

#pragma mark - custom event methods

- (void)cancelItemClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ARPhotoPickerGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PHAssetCollection *collection = [self.fetchResult objectAtIndex:indexPath.row];
    [cell configurationCellWithCollection:collection];
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

@end
