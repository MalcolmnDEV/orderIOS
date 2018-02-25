//
//  RedButton.m
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import "RedButton.h"

@interface RedButton()

@property (strong,nonatomic) CALayer *backgroundLayer, *highlightBackgroundLayer;

@end

@implementation RedButton

#pragma mark - UIButton Overrides

+ (RedButton *)buttonWithType:(UIButtonType)type
{
    return [super buttonWithType:UIButtonTypeCustom];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        [self setupRedButton];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupRedButton];
    }
    
    return self;
}

- (void) setupRedButton
{
    [self drawButton];
    [self drawBackgroundLayer];
    [self drawHighlightBackgroundLayer];
    
    _highlightBackgroundLayer.hidden = YES;
    
    self.titleLabel.font = [UIFont AppFontSFReg];
}

- (void)layoutSubviews
{
    _backgroundLayer.frame = self.bounds;
    _highlightBackgroundLayer.frame = self.bounds;
    
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    _highlightBackgroundLayer.hidden = !highlighted;
    [CATransaction commit];
    
    [super setHighlighted:highlighted];
}

#pragma mark - Layer setters

- (void)drawButton
{
    CALayer *layer = self.layer;
    
    layer.cornerRadius = 5;
    layer.borderWidth = 1;
    layer.borderColor = [UIColor colorWithRed:0.894f green:0.149f blue:0.184f alpha:1.00f].CGColor;
}

- (void)drawBackgroundLayer
{
    if (!_backgroundLayer)
    {
        _backgroundLayer = [CALayer layer];
        
        _backgroundLayer.backgroundColor = [UIColor colorWithRed:0.894f green:0.149f blue:0.184f alpha:1.00f].CGColor;
        _backgroundLayer.cornerRadius = 5;
        
        [self.layer insertSublayer:_backgroundLayer atIndex:0];
    }
}

- (void)drawHighlightBackgroundLayer
{
    if (!_highlightBackgroundLayer)
    {
        _highlightBackgroundLayer = [CALayer layer];
        _highlightBackgroundLayer.backgroundColor = [UIColor colorWithRed:0.780f green:0.086f blue:0.122f alpha:1.00f].CGColor;
        _highlightBackgroundLayer.cornerRadius = 5;
        [self.layer insertSublayer:_highlightBackgroundLayer atIndex:1];
    }
}

@end
