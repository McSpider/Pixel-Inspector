//
//  TransparentWindow.h
//  RoundedFloatingPanel
//
//  Created by Matt Gemmell on Thu Jan 08 2004.
//  <http://iratescotsman.com/>
//


#import <Cocoa/Cocoa.h>

@interface TransparentWindow : NSWindow
{
  NSPoint initialLocation;
  int snapMargin;
  int screenMargin;
  
  BOOL isMovable;
}

@property int snapMargin,screenMargin;
@property BOOL isMovable;

@end
