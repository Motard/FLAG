//
//  AmbulareGPSRecViewController.m
//  Ambulare
//
//  Created by Paulo Martins on 15/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareGPSRecViewController.h"

@interface AmbulareGPSRecViewController ()

@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation AmbulareGPSRecViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //Mostrar a Navigation Controller
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"startRec_viewDidLoad");
    //Desligar a viewGPSStatus
    self.vViewGPSStatus.alpha = 0;
    
    //  Bloco do GPS
    //***********************************************
    
    //mostra o ponto de localização actual
    self.mvMap.showsUserLocation = YES;
    
    //instanciar um objecto do tip CLLocationManager
    self.locationManager = [[CLLocationManager alloc]init];
    
    //Define-se como delegate ,para receber os updates
    self.locationManager.delegate = self;
    
    //Defenir a accuracy
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //liga o gps e pede actualização
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"Estou a obter a localização");
    
    
//    
//    CLLocationCoordinate2D  newLocation, oldLocation;
//    newLocation.latitude = 38.707508;
//    newLocation.longitude = -9.136618;
//    
//    oldLocation.latitude = 38.707591;
//    oldLocation.longitude = -9.133719;
//    
    //Desenhar a polyLine
    //[self drawRouteWithNewLocation:newLocation oldLocation:oldLocation];
    
    //Invoca o metodo que vai criar "observers" para captar utilizações do keyboard
    [self registerForKeyboardNotifications];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(newLocation != oldLocation)
    {
        //Obter as coordenadas da nova posição
        CLLocationCoordinate2D coordenada;
        coordenada.latitude = newLocation.coordinate.latitude;
        coordenada.longitude = newLocation.coordinate.longitude;
        
        //Define uma região baseada nas coordenadas actuais e aplica na mapView
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordenada, 500, 500);
        [self.mvMap setRegion:region animated:YES];
        
        //Mostra as coordenadas na label
        self.lcoordenadas.text = [NSString stringWithFormat:@"Lat:%lf  Long:%lf",coordenada.latitude,coordenada.longitude];
        
        //Desenhar a polyLine
        //[self drawRouteWithNewLocation:newLocation oldLocation:oldLocation];
    }
}

//      Bloco para detectar e reagir ao keyboard
//****************************************************

//Criar observers para detectar quando o keyboard aparece e desaparece e chamar o metodo apropriado
-(void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

//Para quando teclado aparece
-(void)keyboardWasShown:(NSNotification *) aNotification
{
    CGRect frameDaLabel = self.vBottomViewGetNomePercurso.frame;
    
    NSLog(@"keyboardWasShown");
    
    //Obter a altura e largura do teclado
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize =[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Reposicionar a view
    self.vBottomViewGetNomePercurso.frame = CGRectMake(frameDaLabel.origin.x, frameDaLabel.origin.y - kbSize.height, frameDaLabel.size.width, frameDaLabel.size.height);
}

//Para quando o teclado desaparece
-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGRect frameDaLabel = self.vBottomViewGetNomePercurso.frame;
    
    self.vBottomViewGetNomePercurso.frame = CGRectMake(frameDaLabel.origin.x, 340.0, frameDaLabel.size.width, frameDaLabel.size.height);
}
//____________________________________________dead end___________________________________________________________________


//      Bloco para contar o tempo
//****************************************************
-(void)timePassed
{
    NSDate *beginTime = [[NSDate alloc]init];
    
    
    //criar uma async track
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);

    
    dispatch_async(queue, ^
                   {
                       int oldTimeInterval = 0;
                       
                       
                       while (1)
                   {
                       NSDate *actualTime = [[NSDate alloc]init];
                       NSTimeInterval timeInterval = [actualTime timeIntervalSinceDate:beginTime];
                       
                       int timeIntervalAbsolute = timeInterval;
                       
                       if (timeIntervalAbsolute == oldTimeInterval)
                       {
                           continue;
                       }
                       
                       NSLog(@"%d",timeIntervalAbsolute);
                       
                       
                       oldTimeInterval = timeIntervalAbsolute;
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                       {
                           int timeIntervalSeconds = 0;
                           int timeIntervalMinutes = 0;
                           int timeIntervalHours = 0;

                           //timeIntervalSeconds = timeIntervalAbsolute;
                           
                           if (timeIntervalAbsolute>60)
                           {
                               timeIntervalSeconds = timeIntervalAbsolute;
                               do
                               {
                                   timeIntervalSeconds = timeIntervalSeconds-60;
                               }while (timeIntervalSeconds>60);
                           }else
                               timeIntervalSeconds = timeIntervalAbsolute;
                           
                           if ((timeIntervalAbsolute/60)>0)
                           {
                               timeIntervalMinutes = timeIntervalAbsolute;
                               do
                               {
                                   timeIntervalMinutes = timeIntervalMinutes/60;
                               }while (timeIntervalMinutes >60);
                           }
                           
                           
                           
                        if (timeIntervalSeconds > 9)
                            NSString * seconds = [NSString ]
                        self.lTotalTimeTracked.text = [NSString stringWithFormat:@"%d:%d:%d",timeIntervalHours,timeIntervalMinutes,timeIntervalSeconds];
                           
                       });
                       
                       
                   }
                       
    });
    
    
    
    
 

   
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)GravarPercurso:(id)sender
{
    //      Desligar o teclado
    [self.tfNomePercurso resignFirstResponder];
    
    if ([self.tfNomePercurso.text length] == 0)
        self.lAviso.text = @"Necessário introduzir nome para a rota";
    else
    {
        self.vBottomViewGetNomePercurso.alpha = 0;
        self.vViewGPSStatus.alpha = 1;
        
        [self timePassed];
    }
}

-(void)drawRouteWithNewLocation:(CLLocationCoordinate2D) newLocation oldLocation: (CLLocationCoordinate2D) oldLocation
{
    
        //http://www.raywenderlich.com/30001/overlay-images-and-overlay-views-with-mapkit-tutorial
        //http://www.devfright.com/mkdirections-tutorial/
    
    
        CLLocationCoordinate2D pointsToUse[2];
        pointsToUse[0] = CLLocationCoordinate2DMake(newLocation.latitude, newLocation.longitude);
        pointsToUse[1] = CLLocationCoordinate2DMake(oldLocation.latitude, oldLocation.longitude);
    
        //MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:pointsToUse count:2];
        //[self.mvMap addOverlay:myPolyline];
    
    
}


//- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay
//{
//    MKOverlayView* overlayView = nil;
//    
//    if(overlay == self.routeLine)
//    {
//        //if we have not yet created an overlay view for this overlay, create it now.
//        if(nil == self.routeLineView)
//        {
//            self.routeLineView = [[[MKPolylineView alloc] initWithPolyline:self.routeLine] autorelease];
//            self.routeLineView.fillColor = [UIColor redColor];
//            self.routeLineView.strokeColor = [UIColor redColor];
//            self.routeLineView.lineWidth = 3;
//        }
//        
//        overlayView = self.routeLineView;
//        
//    }
//    
//    return overlayView;
//    
//}

//- (void)addRoute {
//    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"EntranceToGoliathRoute" ofType:@"plist"];
//    NSArray *pointsArray = [NSArray arrayWithContentsOfFile:thePath];
//    
//    NSInteger pointsCount = pointsArray.count;
//    
//    CLLocationCoordinate2D pointsToUse[pointsCount];
//    
//    for(int i = 0; i < pointsCount; i++) {
//        CGPoint p = CGPointFromString(pointsArray[i]);
//        pointsToUse[i] = CLLocationCoordinate2DMake(p.x,p.y);
//    }
//    
//    MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:pointsToUse count:pointsCount];
//    
//    [self.mapView addOverlay:myPolyline];
//}


@end
