//
//  CHImageTileView.m
//
//  RELEASED UNDER THE MIT LICENSE
//
//  Created by Cameron Kenly Hunt on 2/18/10.
//  Copyright 2010 Cameron Kenley Hunt All rights reserved.
//  http://cameron.io/project/chgridview
//

#include <math.h>
#import "CHImageTileView.h"

@implementation CHImageTileView
@synthesize image, scalesImageToFit;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseId{
	if(self = [super initWithFrame:frame reuseIdentifier:reuseId]){
		if(image == nil)
			image = [[UIImage alloc] init];
		
		scalesImageToFit = YES;
	}
	return self;
}

- (void)setImage:(UIImage *)i{
	image = i;
}

- (void)drawContentRect:(CGRect)rect{
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGSize imageSize = [image size];
	
	float newWidth = 0.0f;
	float newHeight = 0.0f;
	float leftOffset = rect.origin.x;
	float topOffset = rect.origin.y;
	
	if(scalesImageToFit){
		float size = fmax(rect.size.width, rect.size.height);
		
		float widthScale = imageSize.width / size;
		float heightScale = imageSize.height / size;
		
		float scale = fmin(widthScale, heightScale);
		
		newWidth = imageSize.width / scale;
		newHeight = imageSize.height / scale;
	}else{
		newWidth = imageSize.width;
		newHeight = imageSize.height;
	}
	
	if(rect.size.height < newHeight) topOffset += ceil((rect.size.height - newHeight) / 2);
	if(rect.size.width < newWidth) leftOffset += ceil((rect.size.width - newWidth) / 2);
	
	CGRect imageRect = CGRectMake(leftOffset, topOffset, newWidth, newHeight);
	
	CGContextSaveGState(c);
	CGContextTranslateCTM(c, 0.0f, rect.size.height + rect.origin.y);
	CGContextScaleCTM(c, 1.0f, -1.0f);
	CGContextDrawImage(c, imageRect, [image CGImage]);
	CGContextRestoreGState(c);
	
	//draw border
	
	CGRect borderRect = CGRectIntersection(rect, imageRect);
	if(borderRect.size.height < rect.size.height) borderRect.size.height = rect.size.height;
	
	CGContextClipToRect(c, borderRect);
	
	//CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:1.0f alpha:0.15f] CGColor]);
	//CGContextStrokeRectWithWidth(c, rect, 4.0f);
	
	CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:0.0f alpha:0.4f] CGColor]);
	CGContextStrokeRectWithWidth(c, rect, 2.0f);
	
	/*NSString *title = [NSString stringWithFormat:@"%i",indexPath.tileIndex];
	float textWidth = rect.size.width - (15.0 * 2);
	UIFont *f = [UIFont boldSystemFontOfSize:16.0];
	
	[[UIColor whiteColor] set];
	CGContextSetShadow(c, CGSizeMake(0, -1.0), 1.0);
	
	CGSize fontSize = [title sizeWithFont:f forWidth:textWidth lineBreakMode:UILineBreakModeTailTruncation];
	[title drawInRect:CGRectMake(15.0, ceil((rect.size.height - fontSize.height) / 2), textWidth, fontSize.height) withFont:f lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];*/
}

@end
