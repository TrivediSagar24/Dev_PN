//
//  searchTableViewCell.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "searchTableViewCell.h"

@implementation searchTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _employeeMapCategoryCollection.backgroundColor = [UIColor clearColor];
    _employeeMapCategoryCollection.delegate  = self;
    _employeeMapCategoryCollection.dataSource = self;
    _employeeMapCategoryCollection.showsVerticalScrollIndicator = NO;
    [_employeeMapCategoryCollection reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(defaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
}
- (void)defaultsChanged:(NSNotification *)notification {
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    
    if ([[defaults objectForKey:@"reload"] isEqualToString:@"collectionReload"]) {
        [_employeeMapCategoryCollection reloadData];
    }else{
        kAppDel.SelectedFollowUp = @"0";
        [_employeeMapCategoryCollection reloadData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [_employeeMapCategoryCollection reloadData];
}

-(void)layoutSubviews{
    [_employeeMapCategoryCollection reloadData];

}
- (IBAction)btnCandidatureClicked:(id)sender
{
}

#pragma mark - collectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kAppDel.subCategorymap.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    employeeCategoryMapCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"employeeCategoryMapCell" forIndexPath:indexPath];
    
    if (indexPath.row == kAppDel.subCategorymap.count) {
        kAppDel.SelectedFollowUp = @"0";
    }
    Cell.categoryMapView.layer.cornerRadius =  Cell.categoryMapView.frame.size.height/2;
    
    Cell.categoryMapView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    
    Cell.categoryMapView.clipsToBounds = YES;
    
    [Cell.categoryMapBtn setTitle:[kAppDel.subCategorymap objectAtIndex:indexPath.item] forState:UIControlStateNormal];
    
//    Cell.categoryMapBtn.tag = indexPath.item;
    
    //[Cell.categoryMapBtn addTarget:self action:@selector(ButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
   
    
    if ([kAppDel.userSelectedStatus isEqualToString:@"1"] && [kAppDel.userInvitedStatus isEqualToString:@"0"]) {
        
         [ Cell.categoryMapBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    if ([kAppDel.userSelectedStatus isEqualToString:@"0"] && [kAppDel.userInvitedStatus isEqualToString:@"0"]) {
        
        [ Cell.categoryMapBtn setTitleColor:[UIColor colorWithRed:32.0/255.0 green:88.0/255.0 blue:140.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    if ([kAppDel.applicationStatus isEqualToString:@"1"] || [kAppDel.userInvitedStatus isEqualToString:@"1"] || [kAppDel.SelectedFollowUp isEqualToString:@"1"]) {
        [ Cell.categoryMapBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];

    }
    return Cell;
}

-(void)ButtonSelected:(UIButton*)sender
{

    employeeCategoryMapCell * Cell = (employeeCategoryMapCell*)[_employeeMapCategoryCollection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:sender.tag inSection:0]];
    
    Cell.categoryMapBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    Cell.categoryMapBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    Cell.categoryMapBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    Cell.categoryMapBtn.selected = !Cell.categoryMapBtn.selected;
    
    if (sender.selected )
    {
        Cell.categoryMapBtn.backgroundColor = [UIColor colorWithRed:32.0/255.0 green:88.0/255.0 blue:140.0/255.0 alpha:1.0];
    }
    else
    {
        Cell.categoryMapBtn.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
}

#pragma mark - collectionView flowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize calCulateSizze =[(NSString*)[NSString stringWithFormat:@" %@ ",[kAppDel.subCategorymap objectAtIndex:indexPath.row]]  sizeWithAttributes:NULL];
    
    CGFloat width =calCulateSizze.width+10;
    
    if (width> _employeeMapCategoryCollection.frame.size.width )
    {
        width = _employeeMapCategoryCollection.frame.size.width;
    }
    
    return CGSizeMake(width, 20);
}


@end
