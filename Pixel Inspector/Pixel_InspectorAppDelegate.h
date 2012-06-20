//
//  Pixel_InspectorAppDelegate.h
//  Pixel Inspector
//
//  Created by Ben K on 2011/08/12.
//  All code is provided under the New BSD license.
//

#import <Cocoa/Cocoa.h>
#import "DelegateView.h"
#import "TransparentWindow.h"

@interface Pixel_InspectorAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate> {
@private
  NSWindow *window;
  TransparentWindow *fullWindow;

  IBOutlet DelegateView *fullView;
  int hue;
  int saturation;
  
  BOOL colorMode;
  IBOutlet NSTextField *infoMessage;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)testColor:(id)sender;
- (void)closeColorWindow;
- (void)changeViewColor:(uint)key;

@end
