#import "PVParkMapViewController.h"
#import "PVMapOptionsViewController.h"
#import "PVPark.h"
 
@interface PVParkMapViewController ()
 
@property (nonatomic, strong) PVPark *park;
@property (nonatomic, strong) NSMutableArray *selectedOptions;
 
@end

@implementation PVParkMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.selectedOptions = [NSMutableArray array];
    self.park = [[PVPark alloc] initWithFilename:@"MagicMountain"];
 
 
    CLLocationDegrees latDelta = self.park.overlayTopLeftCoordinate.latitude - self.park.overlayBottomRightCoordinate.latitude;
 
    // think of a span as a tv size, measure from one corner to another
    MKCoordinateSpan span = MKCoordinateSpanMake(fabsf(latDelta), 0.0);
 
    MKCoordinateRegion region = MKCoordinateRegionMake(self.park.midCoordinate, span);
 
    self.mapView.region = region;    
}

- (void)loadSelectedOptions {
    // To be implemented ...
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PVMapOptionsViewController *optionsViewController = segue.destinationViewController;
    optionsViewController.selectedOptions = self.selectedOptions;
}

- (IBAction)closeOptions:(UIStoryboardSegue *)exitSegue {
    PVMapOptionsViewController *optionsViewController = exitSegue.sourceViewController;
    self.selectedOptions = optionsViewController.selectedOptions;
    [self loadSelectedOptions];
}

- (IBAction)mapTypeChanged:(id)sender {
    switch (self.mapTypeSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}

@end
