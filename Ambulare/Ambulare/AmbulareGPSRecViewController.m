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
@property (nonatomic) double distanciaRota;
@property (nonatomic) bool record;
@property (nonatomic) int timeIntervalAbsolute;

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
        
        
        //Calcular a distancia entre os dois pontos
        //***************************************************
        CLLocationDistance distance = [oldLocation distanceFromLocation:newLocation];
        
        //      Apresentar a distancia na label Distance
        if(self.record)
        {
            self.distanciaRota += distance;
            if (self.distanciaRota <= 999)
            {
                self.lUnidadeDistancia.text = @"mt";
                self.lDistance.text = [NSString stringWithFormat:@"%3.0f",self.distanciaRota];
            }
            else
            {
                self.lUnidadeDistancia.text = @"Km";
                self.lDistance.text = [NSString stringWithFormat:@"%3.1f",self.distanciaRota/1000];
            }
        }
        
        NSLog(@"%.3f",distance);
        NSLog(@"%.3f",self.distanciaRota);
        
        //Obter a velocidade
        double speed = newLocation.speed; //isto vem em metros/segundo
        speed = speed * 3.6;
        self.lSpeed.text = [NSString stringWithFormat:@"%.2f",speed];
        
        NSLog(@"SPEED - %f",speed);
        
        //      Obter a média
        NSTimeInterval sinceLastUpdate = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
        double avg = (distance/sinceLastUpdate)*3.6;
        self.lAVGPace.text = [NSString stringWithFormat:@"%.2f",avg];
        
        NSLog(@"AVG - %f",avg);
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
//____________________________________________________________________________________________
//____________________________________________dead end________________________________________


//      BLOCO PARA CONTAR O TEMPO
//****************************************************
-(void)timePassed
{
    //Obter o tempo inicial
    NSDate *beginTime = [[NSDate alloc]init];
    
    
    //criar uma async track
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);

    
    dispatch_async(queue, ^
    {
                    int oldTimeInterval = 0;
                    NSDate *actualTime;
                       
                    // Alterar para uma condição contar enquanto estiver a gravar
                    while (1)
                    {
                       //       Contar o tempo em cada iteração do ciclo
                       actualTime = [[NSDate alloc]init];
                       NSTimeInterval timeInterval = [actualTime timeIntervalSinceDate:beginTime];
                       
                        //      Converter o tipo NSTimeInterval em int(corta as 4 casas decimais do NSTimeInterval)
                       self.timeIntervalAbsolute = timeInterval;
                       
                       if (self.timeIntervalAbsolute == oldTimeInterval)
                       {
                           continue;
                       }
                       
                       NSLog(@"%d",self.timeIntervalAbsolute);
                       
                       
                       oldTimeInterval = self.timeIntervalAbsolute;
                       
                        //Como é necessário efetuar tarefas UI volta-se a chamar a tread main_queue
                       dispatch_async(dispatch_get_main_queue(), ^
                       {
                           int timeIntervalSeconds = 0;
                           int timeIntervalMinutes = 0;
                           int timeIntervalHours = 0;
                           NSString *timeSeconds, *timeMInutes, *timeHours;

                           //Calcular os segundos, minutos e horas
                           if (self.timeIntervalAbsolute > 60)
                           {
                               timeIntervalSeconds = self.timeIntervalAbsolute;
                               do
                               {
                                   timeIntervalSeconds = timeIntervalSeconds - 60;
                               }while (timeIntervalSeconds > 60);
                           }else
                               timeIntervalSeconds = self.timeIntervalAbsolute;
                           
                           
                           if ((self.timeIntervalAbsolute/60) > 0)
                           {
                               timeIntervalMinutes = self.timeIntervalAbsolute/60;
                               
                               while (timeIntervalMinutes > 60)
                               {
                                   timeIntervalMinutes = timeIntervalMinutes - 60;
                               }
                               NSLog(@"timeINtervalMinutes - %d",timeIntervalMinutes);
                           }
                           
                           if (((self.timeIntervalAbsolute / 60) / 60) > 0)
                           {
                               timeIntervalHours = ((self.timeIntervalAbsolute / 60) / 60);
                               while (timeIntervalHours > 24)
                               {
                                   timeIntervalHours = timeIntervalHours - 24 ;
                               } ;
                           }
                           
                           if(timeIntervalSeconds == 60)
                               timeIntervalSeconds = 0;
                           if(timeIntervalMinutes == 60)
                               timeIntervalMinutes = 0;
                           if(timeIntervalHours == 24)
                               timeIntervalHours = 0;
                           
                           if (timeIntervalSeconds < 10)
                               timeSeconds = [NSString stringWithFormat:@"0%d",timeIntervalSeconds];
                           else
                            timeSeconds = [NSString stringWithFormat:@"%d",timeIntervalSeconds];
                           
                           if(timeIntervalMinutes < 10)
                               timeMInutes = [NSString stringWithFormat:@"0%d",timeIntervalMinutes];
                           else
                               timeMInutes = [NSString stringWithFormat:@"%d",timeIntervalMinutes];
                           
                           if(timeIntervalHours < 10)
                               timeHours = [NSString stringWithFormat:@"0%d",timeIntervalHours];
                           else
                               timeHours = [NSString stringWithFormat:@"%d",timeIntervalHours];
                            
                           self.lTotalTimeTracked.text = [NSString stringWithFormat:@"%@:%@:%@",timeHours,timeMInutes,timeSeconds];
                           
                       });
                   }
    });
}
//____________________________________________________________________________________________
//____________________________________________dead end________________________________________



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
        
        //Passar a variavél record a true
        self.record = YES;
        
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
