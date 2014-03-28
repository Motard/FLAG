//
//  AmbulareGPSRecViewController.m
//  Ambulare
//
//  Created by Paulo Martins on 15/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareGPSRecViewController.h"
#import "AmbulareAppDelegate.h"
#import "CoordenadasEntity.h"
#import "RotaEntity.h"

@interface AmbulareGPSRecViewController ()

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) double distanciaRota;
@property (nonatomic) bool record;
@property (nonatomic) int timeIntervalAbsolute;
@property (nonatomic) NSMutableArray *avgSpeedArr;
@property (nonatomic) double media;
@property (nonatomic) NSString *nomeRota;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation AmbulareGPSRecViewController

-(NSMutableArray *) avgSpeedArr
{
    if (!_avgSpeedArr)
    {
        _avgSpeedArr = [[NSMutableArray alloc]init];
    }
    return _avgSpeedArr;
}

-(NSMutableArray *) locationsArr
{
    if(!_locationsArr)
    {
        _locationsArr = [[NSMutableArray alloc]init];
    }
    return _locationsArr;
}



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
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    //liga o gps e pede actualização
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"Estou a obter a localização");
    
    //      Aceder ao AppDelegate já instanciado
    AmbulareAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
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
        
        //Guarda as coordenadas num NSMutableArray
        if(self.record)
        {
            [self.locationsArr addObject:newLocation];
        }
        
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
        
        //Porque os arrays não guardam tipos primitivos, tem de se converter o double em NSNumber
        NSNumber *tempNumber = [[NSNumber alloc]initWithDouble:avg];
        [self.avgSpeedArr addObject:tempNumber];
        
        int count = [self.avgSpeedArr count];
        double media = 0;
        
        for(int i = 1 ; i < count ; i ++ )
        {
            media += [[self.avgSpeedArr objectAtIndex:i] doubleValue];
        }
        
        media = media / (count-1);
        self.lAVGPace.text = [NSString stringWithFormat:@"%.2f",media];
        self.media = media;
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
                    while (self.record)
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
        self.nomeRota = self.tfNomePercurso.text;
        
        self.tfNomePercurso.text = @"";
        
        self.vBottomViewGetNomePercurso.alpha = 0;
        self.vViewGPSStatus.alpha = 1;
        
        //Passar a variavél record a true
        self.record = YES;
        
        [self timePassed];
    }
}

- (IBAction)stopGravarPercurso:(id)sender
{
    double latitude,longitude;
    CLLocation *coordenadas;
    
    
    
    //Parar o GPS
    [self.locationManager stopUpdatingLocation];
    
    self.record = NO;
    self.vBottomViewGetNomePercurso.alpha = 1;
    self.vViewGPSStatus.alpha = 0;

    
    //      Criar um novo objecto do tipo CoordenadasEntity e RotaEntity
    CoordenadasEntity *coordenadasEntity;
    RotaEntity *rotaEntity;
    
    int count = [self.locationsArr count];
    
    for (int i = 0; i < count; i++)
    {
        //Instanciar o coordenadasEntity
        coordenadasEntity = [NSEntityDescription insertNewObjectForEntityForName:@"CoordenadasEntity" inManagedObjectContext:self.managedObjectContext];
        
        //Conveter a location em latitude e longitude
        coordenadas = [self.locationsArr objectAtIndex:i];
        latitude = coordenadas.coordinate.latitude;
        longitude = coordenadas.coordinate.longitude;
        
        //Passar os valores obtidos para o CoordenadasEntity
        coordenadasEntity.nomeRota = self.nomeRota;
        coordenadasEntity.latitude = [NSNumber numberWithDouble:latitude];
        coordenadasEntity.longitude = [NSNumber numberWithDouble:longitude];
        coordenadasEntity.iD = [NSNumber numberWithInt:i];
        
//        
//        NSError *error;
//        
//        //Guardar no managedObjectContext
//        if(![self.managedObjectContext save:&error])
//        {
//            NSLog(@"ERRO!! %@",[error localizedDescription]);
//        }

    }
    
    //Guardar o resto dos dados na outra tabela
    rotaEntity = [NSEntityDescription insertNewObjectForEntityForName:@"RotaEntity" inManagedObjectContext:self.managedObjectContext];
    rotaEntity.nomeRota = self.nomeRota;
    rotaEntity.distancia = [NSNumber numberWithDouble:self.distanciaRota];
    rotaEntity.media = [NSNumber numberWithDouble:self.media];
    rotaEntity.tempo = [NSNumber numberWithInt:self.timeIntervalAbsolute];
    
    
    NSError *error;
    
    //Guardar no managedObjectContext
    if(![self.managedObjectContext save:&error])
    {
        NSLog(@"ERRO!! %@",[error localizedDescription]);
    }
    
    //Aceder ao AppDelegate já instanciado e gravar os dados 
    AmbulareAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate saveContext];

}


@end
