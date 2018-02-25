//
//  AppExtensions.h
//  Malcolmn wizard
//
//  Created by Malcolmn Roberts on 2017/03/30.
//  Copyright © 2017 Malcolmn Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringExt)

+(NSString *)convertHTML:(NSString *)html;

@end



@interface UIViewController (UIViewControllerExt)


@end

@interface UITextField (UITextFieldExt)
@end

@interface UIButton (UIButtonExt)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@interface NSArray (NSArrayExt)

+ (NSArray*)arrayAppSortArray:(NSArray*)sortarray withKeys:(NSArray*)keys ascending:(BOOL)ascending;

@end

@interface UIFont (UIFontExt)

+ (UIFont*)AppFontForKey_01;

+ (UIFont*)AppFontSFSemiBold:(int)size;

+ (UIFont*)AppFontSFMedium;

+ (UIFont*)AppFontSFReg;

+ (UIFont*)AppFontSFReg:(int)size;


@end

@interface UIColor (UIColorExt)

+ (UIColor*)AppColorForNavBar;
+ (UIColor *)AppTabbarTintColor;


@end

@interface UIImage (UIImageExt)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
