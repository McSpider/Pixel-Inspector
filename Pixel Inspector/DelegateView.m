//
//  DelegateView.m
//  Pixel Inspector
//
//  Created by Ben K on 12/06/19.
//  All code is provided under the New BSD license.
//

#import "DelegateView.h"

@implementation DelegateView
@synthesize delegate;

- (id)initWithFrame:(NSRect)frame
{
  if (![super initWithFrame:frame])
		return nil;
  
  // Initialization code here.
  delegate = nil;
  
  return self;
}

- (void)keyDown:(NSEvent *)theEvent
{
  if ([delegate respondsToSelector:@selector(viewKeyDown:)])
    [self.delegate viewKeyDown:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent
{    
  if ([delegate respondsToSelector:@selector(viewKeyUp:)])
    [self.delegate viewKeyUp:theEvent];
}


- (void)mouseDown:(NSEvent *)theEvent
{
  if ([delegate respondsToSelector:@selector(viewMouseDown:)])
    [self.delegate viewMouseDown:theEvent];
}

- (void)mouseUp:(NSEvent *)theEvent
{
  if ([delegate respondsToSelector:@selector(viewMouseUp:)])
    [self.delegate viewMouseUp:theEvent];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
  if ([delegate respondsToSelector:@selector(viewMouseDragged:)])
    [self.delegate viewMouseDragged:theEvent];
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
