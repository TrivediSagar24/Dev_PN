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


- (UIImage *)iconForSize:(NSUInteger)size {
    // Return custom icon for cluster
   // return [UIImage imageNamed:@"map_green_"];
    
    return [self getUIImageFromThisUIView:[self BlueViewMarker:0 markerCount:size]];
    
   // return [UIImage imageNamed:@"map_green_"];
}

- (UIImage *)iconForMarker {
    // Return custom icon for pin
    return [UIImage imageNamed:@"map_green_"];
}

- (UIImage *)iconForText:(NSString *)text withBaseImage:(UIImage *)image {
    return [UIImage imageNamed:@"map_green_"];
}

- (CGPoint)markerIconGroundAnchor {
    // If your marker icon center shifted, return custom value for anchor
    return CGPointMake(0, 0);
}

- (CGPoint)clusterIconGroundAnchor {
    // If your cluster icon center shifted, return custom value for anchor
    return CGPointMake(0, 0);
}

-(UIView *)BlueViewMarker:(NSUInteger)labelTextInt markerCount:(NSUInteger)markerCount
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 69, 60)];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 30, 21)];
    
    label.text = [NSString stringWithFormat:@"%lu",(unsigned long)markerCount];
    
    label.font = [UIFont systemFontOfSize:10];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor =RGBCOLOR(24.0, 59.0, 91.0);
    label.backgroundColor = RGBCOLOR(177.0, 177.0, 177.0);
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 21, 69, 38)];
//    iconMapUser.png
    
    
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


-(UIImage*)getUIImageFromThisUIView:(UIView*)aUIView
{
    
    UIGraphicsBeginImageContext(aUIView.bounds.size);
    
    // UIGraphicsBeginImageContextWithOptions(aUIView.bounds.size, aUIView.opaque, 2.0);
    
    // [aUIView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // [self drawViewHierarchyInRect:aUIView.frame afterScreenUpdates:NO];
    
    [aUIView drawViewHierarchyInRect:aUIView.layer.bounds afterScreenUpdates:YES];
    
    //    [aUIView.layer drawViewHierarchyInRect:aUIView.layer.bounds afterScreenUpdates:NO];
    
    //    [aUIView.layer draw]
    
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return viewImage;
}

@end