//
//  PN_TextViewGlobalMethods.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/3/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "PN_TextViewGlobalMethods.h"

@implementation PN_TextViewGlobalMethods
{
    
    NSString *placeholderText;  // make a property
  
}

-(void)awakeFromNib
{
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView respondsToSelector: @selector(updateForTextChange)])
    {
        [self updateForTextChange];
    }
    
}

- (void) updateForTextChange
{
    if ([self.text length] == 0)
    {
        self.textColor = self.PlaceHolderColor;
        self.text = self.PlaceHolder;
    }
    else
    {
        self.textColor = self.NormalColor;
        self.text =@"";

    }
    
}

@end
