//
//  TransparentWindow.m
//  RoundedFloatingPanel
//
//  Created by Matt Gemmell on Thu Jan 08 2004.
//  <http://iratescotsman.com/>
//


#import "TransparentWindow.h"

@implementation TransparentWindow
@synthesize snapMargin,screenMargin;

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
	if (![super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO]) {
    return nil;
  }
    
	[self setLevel: NSModalPanelWindowLevel];
	[self setBackgroundColor:[NSColor clearColor]];
	[self setAlphaValue:1.0];
	[self setOpaque:NO];
	[self setHasShadow:NO];
  [self setSnapMargin:5];
  [self setScreenMargin:5];
	return self;
}


- (BOOL)canBecomeMainWindow
{
  return YES;
}

- (BOOL)canBecomeKeyWindow
{
  return YES;
}


- (void)mouseDragged:(NSEvent *)theEvent
{
  NSPoint currentLocation;
  NSPoint newOrigin;
  NSRect  screenFrame = [[NSScreen mainScreen] frame];
  NSRect  windowFrame = [self frame];
	int windowWidth = windowFrame.size.width;
  
  currentLocation = [self convertBaseToScreen:[self mouseLocationOutsideOfEventStream]];
  newOrigin.x = currentLocation.x - initialLocation.x;
  newOrigin.y = currentLocation.y - initialLocation.y;
  
  if ((newOrigin.y + windowFrame.size.height) > (NSMaxY(screenFrame) - (21+screenMargin) - snapMargin)){
		// Prevent dragging into the menu bar area
		newOrigin.y = NSMaxY(screenFrame) - windowFrame.size.height - (21+screenMargin);
  }
  //else if (newOrigin.y < NSMinY(screenFrame) + snapMargin && newOrigin.y > NSMinY(screenFrame) - snapMargin) {
  else if (newOrigin.y < NSMinY(screenFrame)+screenMargin + snapMargin) {
      // Prevent dragging off bottom of screen
      newOrigin.y = NSMinY(screenFrame)+screenMargin;
  }
  //if (newOrigin.x > NSMinX(screenFrame) - snapMargin && newOrigin.x < NSMinX(screenFrame) + snapMargin) {
  if (newOrigin.x < NSMinX(screenFrame)+screenMargin + snapMargin) {
      // Prevent dragging off left of screen
      newOrigin.x = NSMinX(screenFrame)+screenMargin;
  }
  //else if (newOrigin.x < NSMaxX(screenFrame) - windowWidth + snapMargin && newOrigin.x > NSMaxX(screenFrame) - windowWidth - snapMargin) {
  else if (newOrigin.x > NSMaxX(screenFrame)-screenMargin - windowWidth - snapMargin) {
      // Prevent dragging off right of screen
      newOrigin.x = NSMaxX(screenFrame)-screenMargin - windowWidth;
  }
  
  [self setFrameOrigin:newOrigin];
}


- (void)mouseDown:(NSEvent *)theEvent
{    
  NSRect windowFrame = [self frame];    
  initialLocation = [self convertBaseToScreen:[theEvent locationInWindow]];
  initialLocation.x -= windowFrame.origin.x;
  initialLocation.y -= windowFrame.origin.y;
}


@end
