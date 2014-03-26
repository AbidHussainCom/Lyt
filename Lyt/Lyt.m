//
//  Lyt.h
//  Lyt
//
//  Created by Hermés Piqué on 26/03/14.
//  Copyright (c) 2014 Robot Media. All rights reserved.
//

#import "Lyt.h"

@interface UIView (LytUtils)

- (UIView*)lyt_ancestorSharedWithView:(UIView*)view;

- (void)lyt_addConstraint:(NSLayoutConstraint*)constraint toAncestorSharedWithView:(UIView*)view;

- (void)lyt_addConstraints:(NSArray*)constraints toAncestorSharedWithView:(UIView*)view;

@end

@implementation UIView (LytUtils)

- (UIView*)lyt_ancestorSharedWithView:(UIView*)view
{
    if (view == nil) return nil;
    if (self.superview == view) return view;
    return [self lyt_ancestorSharedWithView:view.superview];
}

- (void)lyt_addConstraint:(NSLayoutConstraint*)constraint toAncestorSharedWithView:(UIView*)view
{
    UIView *ancestor = [self lyt_ancestorSharedWithView:view];
    [ancestor addConstraint:constraint];
}

- (void)lyt_addConstraints:(NSArray*)constraints toAncestorSharedWithView:(UIView*)view
{
    UIView *ancestor = [self lyt_ancestorSharedWithView:view];
    [ancestor addConstraints:constraints];
}

@end

@implementation UIView (Lyt)

#pragma mark Alignment

- (NSLayoutConstraint*)lyt_alignTopToView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *constraint = [self lyt_constraintByAligningTopToView:view margin:margin];
    [self lyt_addConstraint:constraint toAncestorSharedWithView:view];
    return constraint;
}

- (NSLayoutConstraint*)lyt_alignRightToView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *constraint = [self lyt_constraintByAligningRightToView:view margin:margin];
    [self lyt_addConstraint:constraint toAncestorSharedWithView:view];
    return constraint;
}

- (NSLayoutConstraint*)lyt_alignBottomToView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *constraint = [self lyt_constraintByAligningBottomToView:view margin:margin];
    [self lyt_addConstraint:constraint toAncestorSharedWithView:view];
    return constraint;
}

- (NSLayoutConstraint*)lyt_alignLeftToView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *constraint = [self lyt_constraintByAligningLeftToView:view margin:margin];
    [self lyt_addConstraint:constraint toAncestorSharedWithView:view];
    return constraint;
}

- (NSArray*)lyt_alignSidesToView:(UIView*)view margin:(CGFloat)margin
{
    NSArray *constraints = [self lyt_constraintsByAligningSidesToView:view margin:margin];
    [self lyt_addConstraints:constraints toAncestorSharedWithView:view];
    return constraints;
}

- (NSLayoutConstraint*)lyt_alignCenterXToView:(UIView*)view
{
    return [self lyt_alignCenterXToView:view margin:0];
}

- (NSLayoutConstraint*)lyt_alignCenterXToView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *constraint = [self lyt_constraintByAligningCenterXToView:view margin:margin];
    [self lyt_addConstraint:constraint toAncestorSharedWithView:view];
    return constraint;
}

- (NSLayoutConstraint*)lyt_constraintByAligningTopToView:(UIView*)view
{
    return [self lyt_constraintByAligningTopToView:view margin:0];
}

- (NSLayoutConstraint*)lyt_constraintByAligningTopToView:(UIView*)view margin:(CGFloat)margin
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:margin];
}

- (NSLayoutConstraint*)lyt_constraintByAligningBottomToView:(UIView*)view
{
    return [self lyt_constraintByAligningBottomToView:view margin:0];
}

- (NSLayoutConstraint*)lyt_constraintByAligningBottomToView:(UIView*)view margin:(CGFloat)margin
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:margin];
}

- (NSLayoutConstraint*)lyt_constraintByAligningLeftToView:(UIView*)view
{
    return [self lyt_constraintByAligningLeftToView:view margin:0];
}

- (NSLayoutConstraint*)lyt_constraintByAligningLeftToView:(UIView*)view margin:(CGFloat)margin
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:margin];
}

- (NSLayoutConstraint*)lyt_constraintByAligningRightToView:(UIView*)view
{
    return [self lyt_constraintByAligningRightToView:view margin:0];
}

- (NSLayoutConstraint*)lyt_constraintByAligningRightToView:(UIView*)view margin:(CGFloat)margin
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:margin];
}

- (NSLayoutConstraint*)lyt_constraintByAligningCenterXToView:(UIView*)view
{
    return [self lyt_constraintByAligningCenterXToView:view margin:0];
}

- (NSLayoutConstraint*)lyt_constraintByAligningCenterXToView:(UIView*)view margin:(CGFloat)margin
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:margin];
}

- (NSLayoutConstraint*)lyt_constraintByAligningCenterYToView:(UIView*)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
}

- (NSArray*)lyt_constraintsByAligningCenterToView:(UIView*)view
{
    NSLayoutConstraint *centerXConstraint = [self lyt_constraintByAligningCenterXToView:view];
    NSLayoutConstraint *centerYConstraint = [self lyt_constraintByAligningCenterYToView:view];
    return @[centerXConstraint, centerYConstraint];
}

- (NSArray*)lyt_constraintsByAligningSidesToView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *leftConstraint = [self lyt_constraintByAligningLeftToView:view margin:margin];
    NSLayoutConstraint *rightConstraint = [self lyt_constraintByAligningRightToView:view margin:-margin];
    return @[leftConstraint, rightConstraint];
}

- (NSArray*)lyt_constraintsByAligningToView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *leftConstraint = [self lyt_constraintByAligningLeftToView:view margin:margin];
    NSLayoutConstraint *rightConstraint = [self lyt_constraintByAligningRightToView:view margin:-margin];
    NSLayoutConstraint *topConstraint = [self lyt_constraintByAligningTopToView:view margin:margin];
    NSLayoutConstraint *bottomConstraint = [self lyt_constraintByAligningBottomToView:view margin:-margin];
    return @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
}

#pragma mark Placement

- (NSLayoutConstraint*)lyt_placeAboveView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *constraint = [self lyt_constraintByPlacingAboveView:view margin:margin];
    [self lyt_addConstraint:constraint toAncestorSharedWithView:view];
    return constraint;
}

- (NSLayoutConstraint*)lyt_placeBelowView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *constraint = [self lyt_constraintByPlacingBelowView:view margin:margin];
    [self lyt_addConstraint:constraint toAncestorSharedWithView:view];
    return constraint;
}

- (NSLayoutConstraint*)lyt_placeLeftToView:(UIView*)view margin:(CGFloat)margin
{
    NSLayoutConstraint *constraint = [self lyt_constraintByPlacingLeftToView:view margin:margin];
    [self lyt_addConstraint:constraint toAncestorSharedWithView:view];
    return constraint;
}

- (NSLayoutConstraint*)lyt_constraintByPlacingLeftToView:(UIView*)view margin:(CGFloat)margin
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:margin];
}

- (NSLayoutConstraint*)lyt_constraintByPlacingAboveView:(UIView*)view margin:(CGFloat)margin
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:margin];
}

- (NSLayoutConstraint*)lyt_constraintByPlacingBelowView:(UIView*)view margin:(CGFloat)margin
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:margin];
}

#pragma mark Sizing

- (NSLayoutConstraint*)lyt_constraintWithWidth:(CGFloat)width
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
}

- (NSLayoutConstraint*)lyt_constraintWithHeight:(CGFloat)height
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
}

- (NSLayoutConstraint*)lyt_constraintByMatchingWidthToView:(UIView*)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
}

- (NSLayoutConstraint*)lyt_constraintByMatchingHeightToView:(UIView*)view
{
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
}

- (NSArray*)lyt_constraintsByMatchingSizeToView:(UIView*)view
{
    NSLayoutConstraint *widthConstraint = [self lyt_constraintByMatchingWidthToView:view];
    NSLayoutConstraint *heightConstraint = [self lyt_constraintByMatchingHeightToView:view];
    return @[widthConstraint, heightConstraint];
}

- (NSArray*)lyt_constraintsWithSize:(CGSize)size
{
    NSLayoutConstraint *widthConstraint = [self lyt_constraintWithWidth:size.width];
    NSLayoutConstraint *heightConstraint = [self lyt_constraintWithHeight:size.height];
    return @[widthConstraint, heightConstraint];
}

@end
