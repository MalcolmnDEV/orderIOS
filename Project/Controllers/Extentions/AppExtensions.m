//
//  AppExtensions.m
//  Malcolmn wizard
//
//  Created by Malcolmn Roberts on 2017/03/30.
//  Copyright © 2017 Malcolmn Roberts. All rights reserved.
//

#import "AppExtensions.h"

@implementation NSString (NSStringExt)

+(NSString *)convertHTML:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

@end

@implementation UIViewController (UIViewControllerExt)


@end


@implementation NSDictionary (NSDictionaryExt)


@end

@implementation UITextField (UITextFieldExt)
+(UITextField *)defaultContentInsets:(UITextField *)textField
{
//    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
//    [textField setLeftViewMode:UITextFieldViewModeAlways];
//    [textField setLeftView:spacerView];
    
    return textField;
}
@end;

@implementation UIButton (UIButtonExt)
+(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end;

@implementation NSArray (NSArrayExt)

+ (NSArray*)arrayAppSortArray:(NSArray*)sortarray withKeys:(NSArray*)keys ascending:(BOOL)ascending
{
    // array that contains descriptors based on the keys array
    NSMutableArray *descriptors = [[NSMutableArray alloc] init];
    for (NSString *key in keys)
    {
        NSSortDescriptor *sort_descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
        [descriptors addObject:sort_descriptor];
    }
    NSArray *sorted = [sortarray sortedArrayUsingDescriptors:descriptors];
    return sorted;
}

@end


@implementation UIFont (UIFontExt)

+ (UIFont*)AppFontForKey_01
{
    return [UIFont fontWithName:@"Helvetica Neue" size:14];
}

+ (UIFont*)AppFontSFSemiBold:(int)size
{
    return [UIFont fontWithName:@"SF UI Text Semibold" size:size];
}

+ (UIFont*)AppFontSFMedium
{
    return [UIFont fontWithName:@"SF UI Text Medium" size:9];
}

+ (UIFont*)AppFontSFReg:(int)size
{
    return [UIFont fontWithName:@"SF UI Text Regular" size:size];
}

+ (UIFont*)AppFontSFReg
{
    return [UIFont fontWithName:@"SF UI Text Regular" size:16];
}

@end

@implementation UIColor (UIColorExt)


+ (UIColor*)AppColorForNavBar
{
    return [UIColor colorWithRed:0.047 green:0.165 blue:0.212 alpha:1.00];
}

+ (UIColor *)AppTabbarTintColor
{
    return [UIColor colorWithRed:229/255.0f green:63/255.0f blue:63/255.0f alpha:1];
}


@end


@implementation UIImage (UIImageExt)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end























