//
//  ColorView.m
//  Pixel Inspector
//
//  Created by Benjamin Kohler on 12/06/19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView
@synthesize delegate;

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

- (void)keyDown:(NSEvent *)theEvent
{
  // Override the keyDown method to prevent the default system beep when pressing a key.
}

- (void)keyUp:(NSEvent *)theEvent
{
  uint key = 0;
  
  NSString *character = [theEvent charactersIgnoringModifiers];
  unichar code = [character characterAtIndex:0];

  switch (code)  {
    case NSUpArrowFunctionKey: {
      key = 1;
      break;
    }
    case NSDownArrowFunctionKey: {
      key = 2;
      break;
    }
    case NSLeftArrowFunctionKey: {
      key = 3;
      break;
    }
    case NSRightArrowFunctionKey: {
      key = 4;
      break;
    }
    case 27: { // Escape key
      key = 5;
      break;
    }
  }
  
  if ([delegate respondsToSelector:@selector(changeViewColor:)] && key != 0)
    [self.delegate changeViewColor:key];
}

- (void)mouseUp:(NSEvent *)theEvent
{
  if ([delegate respondsToSelector:@selector(closeColorWindow)])
    [self.delegate closeColorWindow];
}

- (BOOL)acceptsFirstResponder
{
  return YES;
}
- (BOOL)becomeFirstResponder
{
  return YES;
}
- (BOOL)resignFirstResponder
{
  return YES;
}

@end
