//
//  employerInviteForJobCell.m
//  PeopleNect
//
//  Created by Apple on 09/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employerInviteForJobCell.h"

@implementation employerInviteForJobCell

-(void)awakeFromNib{
    
   // _lblEmployeeName.hidden = YES;
    
    _obj_SubcategoryCV.delegate = self;
    _obj_SubcategoryCV.dataSource =self;
    [_obj_SubcategoryCV reloadData];
}



-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [_obj_SubcategoryCV reloadData];
}

-(void)layoutSubviews{
    [_obj_SubcategoryCV reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return kAppDel.subCategoryFromInvited.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SubcategoryInfo *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubcategoryInfo" forIndexPath:indexPath];
    
    Cell.subCategoryView.layer.cornerRadius = 10;
    Cell.subCategoryView.clipsToBounds = YES;
    
    //Cell.subCategoryView.hidden = YES;
    
    [Cell.subcategoryBtn setTitle:[kAppDel.subCategoryFromInvited objectAtIndex:indexPath.item] forState:UIControlStateNormal];
    
    return Cell;
}


#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize calCulateSizze =[(NSString*)[NSString stringWithFormat:@" %@ ",[kAppDel.subCategoryFromInvited objectAtIndex:indexPath.row]]  sizeWithAttributes:NULL];
    
    CGFloat width =calCulateSizze.width+30;
    
    if (width> _obj_SubcategoryCV.frame.size.width )
    {
        width = _obj_SubcategoryCV.frame.size.width;
    }
    return CGSizeMake(width, 20);
}

@end
