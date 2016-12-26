        //
//  CustomClusterIconGenerator.m
//  ObjCDemoApp
//
//  Created by Narendra Pandey on 05/12/16.
//  Copyright © 2016 Google. All rights reserved.
//

#import "CustomClusterIconGenerator.h"
#import "PN_Constants.h"
@implementation CustomClusterIconGenerator

/* icon for marker cluster */
- (UIImage *)iconForSize:(NSUInteger)size {
    return [self getUIImageFromThisUIView:[self BlueViewMarker:0 markerCount:size]];
}
/* icon for individual marker */
- (UIImage *)iconForMarker {
    return [UIImage imageNamed:@"map_green_"];
}
/* icon for individual marker */
- (UIImage *)iconForText:(NSString *)text withBaseImage:(UIImage *)image {
    return [UIImage imageNamed:@"map_green_"];
}
- (CGPoint)markerIconGroundAnchor {
    return CGPointMake(0, 0);
}
- (CGPoint)clusterIconGroundAnchor {
    return CGPointMake(0, 0);
}
/* Custom marker for Clustering marker  */
-(UIView *)BlueViewMarker:(NSUInteger)labelTextInt markerCount:(NSUInteger)markerCount{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 69, 60)];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 30, 21)];
    label.text = [NSString stringWithFormat:@"%lu",(unsigned long)markerCount];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor =RGBCOLOR(24.0, 59.0, 91.0);
    label.backgroundColor = RGBCOLOR(177.0, 177.0, 177.0);
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 21, 69, 38)];
   NSString *EmployeeUserID = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"];
    if (EmployeeUserID !=nil) {
        [btn setImage:[UIImage imageNamed:@"map2_"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"iconMapUser.png"] forState:UIControlStateNormal];
    }
    [view addSubview:label];
    [view addSubview:btn];
    return view;
}
/* View to image conversion  */
-(UIImage*)getUIImageFromThisUIView:(UIView*)aUIView{
    UIGraphicsBeginImageContext(aUIView.bounds.size);
    [aUIView drawViewHierarchyInRect:aUIView.layer.bounds afterScreenUpdates:YES];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

@end