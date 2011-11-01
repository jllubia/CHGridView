//
//  CHSectionTitleView.h
//
//  RELEASED UNDER THE MIT LICENSE
//
//  Created by Cameron Kenly Hunt on 2/18/10.
//  Copyright 2010 Cameron Kenley Hunt All rights reserved.
//  http://cameron.io/project/chgridview
//

#import <UIKit/UIKit.h>

@interface CHSectionHeaderView : UIView {
	UIView			*topLine;
	
	int				section;
	NSString		*title;
	CGFloat			yCoordinate;
}

@property (nonatomic) int					section;
@property (nonatomic, strong) NSString		*title;
@property (nonatomic) CGFloat				yCoordinate;

//subclasses should implement drawRect: but must draw title on their own

@end