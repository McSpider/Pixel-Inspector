//
//  ColorView.h
//  Pixel Inspector
//
//  Created by Benjamin Kohler on 12/06/19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ColorViewDelegate
@optional

- (void)closeColorWindow;
- (void)changeViewColor:(uint)key;

@end

@interface ColorView : NSView {
  id delegate;
}

@property (nonatomic, assign) id delegate;

@end
