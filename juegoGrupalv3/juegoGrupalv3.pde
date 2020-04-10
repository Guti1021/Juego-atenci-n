import processing.serial.*;
import controlP5.*;
Serial port;

ControlP5 cp5;
ControlTimer c;
Textlabel t;

boolean prueba=false;
boolean enJuego=false;
boolean FrenoJugador1=false;
boolean FrenoJugador2=false;
boolean InicioTiempo=false;
int puntosJugador1=0;
int puntosJugador2=0;
  

//BOTONES --------------------------------------------------------
int retroceder;
int avanzar;
int [] datoBotones= new int[12];
int [] AciertosJugador1= new int[10];
int [] AciertosJugador2= new int[10];
int btn1Pl1;      
int btn2Pl1;
int btn3Pl1;
int btn4Pl1;
int btn5Pl1;      
int btn1Pl2;      
int btn2Pl2;
int btn3Pl2;      
int btn4Pl2;
int btn5Pl2;
boolean unaVez=false;
boolean unaVez2=false;
String sensores;

//TIEMPO------------------------------------------------------
int time = 5000;
int tiempo;

//Fondos
PImage fondoInicio;
PImage tablero;
PImage tableroDos;
PImage logo;
PImage btnNext;
PImage fondoDos;
PImage pantalla3;
PImage pantalla4;
PImage pantalla5;
PImage correcto;
PImage incorrecto;
//PImage [] gif;
//int contarImg;
//int frame;

//fuente
PFont fuente;

//ESTADOS
int estado =0;

//tecla
int presion = 0;

//RANDOM
//int numeros[];
//Variables del contador y numeros random
int contador = 5;
//int tiempoActual = 0;
int pasarCasilla =0;
int guardar = 0;
int actual=0;
int arr[];

int puntaje;

void setup()
{
  size(1920, 1080);

  //CONEXION
  port = new Serial(this, "COM5", 9600); 

  //IMAGENES DE FONDO
  fondoInicio= loadImage("FondInicial.png");
  tablero= loadImage("tablero.png");
  tableroDos= loadImage("tableroDos.png");
  logo= loadImage("logo.png");
  btnNext = loadImage("btn-next.png");
  fondoDos= loadImage("pantalla2.png");
  pantalla3=loadImage("pantalla3.png");
  pantalla4=loadImage("pantalla4.png");
  pantalla5=loadImage("pantalla5.png");
  correcto=loadImage("correcto.png");
  incorrecto=loadImage("incorrecto.png");

  /*contarImg= 7;
   gif= new PImage[contarImg];
   for (int i=0; i< contarImg; i++) {
   gif[i]=loadImage(i +".png");
   i++;
   }*/
  //FUENTE
  fuente= loadFont("ArialRoundedMTBold-120.vlw");
  textFont(fuente);
  
  //Contador
  //numeros = new int[10]; //indicacion de c uantos numeros va a guardar
  frameRate(30);
  cp5 = new ControlP5(this);
  c = new ControlTimer();
  t = new Textlabel(cp5,"--",1500,180);
  c.setSpeedOfTime(1);
  
  arr = new int [10];
  
  for(int i=0; i<9; i++)
  {
    arr[i] = int(random(1,5)); 
    println(arr[i]);
  }
  for(int i=0; i<AciertosJugador1.length; i++)
  {
    AciertosJugador1[i]=0;
    AciertosJugador2[i]=0;
  }
}


void draw()
{
  
  if (0 < port.available()) 
  {     
    //otra forma de enviar los datos a processing es no usando serial.write, sino serial.println, sin embargo en processing no se utiliza port.read(), sino port.readStringUntil('\n');
    sensores =  port.readStringUntil('\n');    

    if (sensores != null)
    {
      println(sensores);
      //se crea un arreglo que divide los datos y los guarda dentro del arreglo, para dividir los datos se hace con split cuando le llegue el caracter 'T',
      String[] datosSensor = split(sensores, 'T');

      if (datosSensor.length == 12)
      {
        println(datosSensor[0]);
        println(datosSensor[1]);
        println(datosSensor[2]);
        println(datosSensor[3]);
        println(datosSensor[4]);
        println(datosSensor[5]);
        println(datosSensor[6]);
        println(datosSensor[7]);
        println(datosSensor[8]);
        println(datosSensor[9]);
        println(datosSensor[10]);
        println(datosSensor[11]);
        avanzar = int(trim(datosSensor[0]));      
        retroceder = int(trim(datosSensor[1]));
        btn1Pl1 = int(trim(datosSensor[2]));      
        btn2Pl1 = int(trim(datosSensor[3]));
        btn3Pl1 = int(trim(datosSensor[4]));      
        btn4Pl1 = int(trim(datosSensor[5]));
        btn5Pl1 = int(trim(datosSensor[6]));      
        btn1Pl2 = int(trim(datosSensor[7]));      
        btn2Pl2 = int(trim(datosSensor[8]));
        btn3Pl2 = int(trim(datosSensor[9]));      
        btn4Pl2 = int(trim(datosSensor[10]));
        btn5Pl2 = int(trim(datosSensor[11]));
        for(int i=2; i<datosSensor.length;i++){
          datoBotones[i]=int(trim(datosSensor[i]));
        }
      }
    }
  }
 

  if (estado==0)
  {
    inicial();
   
    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 1; 
        unaVez = true;
      }
    }
  } 
  if (estado == 1) {
    pantalla2();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 2; 
        unaVez = true;
      }
    }
    
     if (unaVez2==true) 
    {
      if(retroceder == 0)
      {
         unaVez2 = false; 
      }
    }
    
    if(unaVez2==false)
    {
      if(retroceder == 1)
      {
         estado = 0;
         unaVez2 = true; 
      }
    }  
  } 
  
  if(estado == 2) {
    pantalla3();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 3; 
        unaVez = true;
      }
    }
    
    if (unaVez2==true) 
    {
      if(retroceder == 0)
      {
         unaVez2 = false; 
      }
    }
    
  if(unaVez2==false)
    {
      if(retroceder == 1)
      {
         estado = 1;
         unaVez2 = true; 
      }
    }
    
  } 
  if (estado == 3) {
    
    
    
    pantalla4();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 4; 
        unaVez = true;
      }
    }
    
    if (unaVez2==true) 
    {
      if(retroceder == 0)
      {
         unaVez2 = false; 
      }
    }
    
  if(unaVez2==false)
    {
      if(retroceder == 1)
      {
         estado = 2;
         unaVez2 = true; 
      }
    }
  } 
  
  if (estado == 4) {
    pantalla5();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 5; 
        unaVez = true;
      }
    }
    
    if (unaVez2==true) 
    {
      if(retroceder == 0)
      {
         unaVez2 = false; 
      }
    }
    
  if(unaVez2==false)
    {
      if(retroceder == 1)
      {
         estado = 3;
         unaVez2 = true; 
      }
    }
  } 
  
  if (estado == 5) {
    pantalla6();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 6; 
        unaVez = true;
      }
    }
    
    
  }
  
  if (estado == 6) {
    pantalla7();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 7; 
        unaVez = true;
      }
    }
    
  } 
  if (estado == 7) {
    pantalla8();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 8; 
        unaVez = true;
      }
    }
    
  } else if (estado == 8) {
    pantalla9();
    
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 9; 
        unaVez = true;
      }
    }
    
  } else if (estado == 9) {
    pantalla9();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 10; 
        unaVez = true;
      }
    }
  } else if (estado == 10) {
    pantalla10();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 11; 
        unaVez = true;
      }
    }
  } else if (estado == 11) {
    pantalla11();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 12; 
        unaVez = true;
      }
    }
  } else if (estado == 12) {
    pantalla12();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 13; 
        unaVez = true;
      }
    }
  } else if (estado == 13) {
    pantalla13();
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 14; 
        unaVez = true;
      }
    }
  } else if (estado == 14) {
    pantalla14();
    enJuego=true;
    InicioTiempo = true;
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 15; 
        unaVez = true;
      }
    }
    InicioTiempo = false;
  }
  else if (estado == 15) {
    /// ESTA MONDA VA EN LA PANTALLA FINALL
    for(int i=0;i<AciertosJugador1.length;i++){
    println("Jugador1 "+AciertosJugador1[i]+"  Jugador2"+AciertosJugador2[i]);
    
    }
    pantalla15();
    
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 16; 
        unaVez = true;
        enJuego=false;
      }
    }
  }
  else if (estado == 16) {
    pantalla16();
    
    if (unaVez==true) 
    {
      if (avanzar == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez == false)
    {
      if (avanzar==1)
      {
        estado = 1; 
        unaVez = true;
      }
    }
    
    if (unaVez2==true) 
    {
      if (btn1Pl1 == 0)
      {
        unaVez2 = false;
      }
    }

    if (unaVez2 == false)
    {
      if (btn1Pl1==1)
      {
        estado = 5; 
        unaVez2 = true;
      }
    }
  }
  if(enJuego==true){
    fill(#898888);
  textSize(40);
  textAlign(LEFT);
  text("Jugador 1: "+puntosJugador1, 200, 900);
  text("Jugador 2: "+puntosJugador2, 1500, 900);
  for(int i =2; i<datoBotones.length;i++){
    if(datoBotones[i]==1){
      
      if(i>=2 && i<=6){
        println("acabamos de oprimir esta monda :"+i);
        if(FrenoJugador1==false){
          int correcion=i-1;
          if(correcion==guardar){
            puntosJugador1++;
            AciertosJugador1[pasarCasilla]=1;
          }
          FrenoJugador1=true;
        }
      }
      if(i>=7 && i<=11){
        if(FrenoJugador2==false){
          int correcion=i-6;
          if(correcion==guardar){
            puntosJugador2++;
            AciertosJugador2[pasarCasilla]=1;
          }
          FrenoJugador2=true;
        }
      }
    }
  }
  }
    
  
  
}

void keyPressed() { // cuando se oprime una tecla
  //println("" + keyCode); //para averiguar el codigo de las teclas
  if (keyCode == 32) {
    //estado= estado+1;
    //presion=1;
    println(estado);
  }
}

void keyReleased() {// cuando se suelta esa tecla
  if (keyCode == 32) {
    println("NO estoy presionando: "+presion);
    presion=0;
  }
}
//FONDO---------------------------------------------------------------------------
void fondo() {
  background(#fce4a2);
  image(tablero, 200, 200);
  image(logo, 76, 31);

  fill(#898888);
  textSize(50);
  textAlign(LEFT);
  text("Presiona el ", 600, 830);
  image(btnNext, 890, 770);
  text("para continuar", 1000, 830);
}

void fondoDos() {
  background(#fce4a2);
  image(tableroDos, 200, 200);
  image(logo, 76, 31);

  /*textSize(22);
  text("Jugador 1: #", 80, 506);
  text("Jugador 2: #", 511, 506);*/
}
//PANTALLA INICIAL ---------------------------------------------------------------------
void inicial() {
  text("hola", 100, 100);
  background(fondoInicio);

  /*
  if (presion==1) {
   estado=1;
   println("EL ESTADO ES: "+ estado + "Y STOP ESTA: " + stop);
   }*/
}

//PANTALLA 2 ---------------------------------------------------------------------------
void pantalla2() {
  background(fondoDos);
  //text("te odio mugre codigo", 300, 300);
}

//PANTALLA 3 ---------------------------------------------------------------------------
void pantalla3() {
  fondo();
  fill(#898888);
  textSize(30);
  String a="Al frente encontrarás algunos elementos que son distractores";
  text(a, 500, 270, 1500, 200);

  image(pantalla3, 400, 300);
}

//PANTALLA 4 ---------------------------------------------------------------------------
void pantalla4() {
  fondo();
  fill(#898888);
  textSize(30);
  String b="Estos elementos estan representados con números";
  text(b, 600, 270, 1500, 200);

  image(pantalla4, 700, 450);
}

//PANTALLA 5 ---------------------------------------------------------------------------
void pantalla5() {
  fondo();
  fill(#898888);
  textSize(28);
  String c="Para elegir un número debes colocar la figura en su respectivo espacio e inmediantamente quitarlo";
  textAlign(CENTER);
  text(c, 200, 270, 1500, 200);
  image(pantalla5, 500, 320);
  //frame=(frame+1)%contarImg;
  //image(gif[frame], 90, 118);
}

//PANTALLA 6 ---------------------------------------------------------------------------
void pantalla6() {
  fondo();
  fill(#898888);
  textSize(70);
  text("Ponga mucha", 750, 400);
  textSize(140);
  text("¡Atencion!", 630, 600);
}

//PANTALLA 7 ---------------------------------------------------------------------------
void pantalla7() {
  fondo();
  fill(#898888);
  textSize(70);
  text("Concentrece en el siguiente", 500, 400);
  textSize(140);
  text("enunciado", 630, 600);
}

//PANTALLA 8 ---------------------------------------------------------------------------
void pantalla8() {
  fondo();
  fill(#898888);
  textSize(65);
  textAlign(CENTER);
  String d="En mi mundo hay 5 números en dónde el último número que muestre es el siguiente";
  text(d, 650, 300, 600, 400);
}

//PANTALLA 9 TUTORIAL ---------------------------------------------------------------------------
void pantalla9() {
  fondo();

  fill(#898888);
  textSize(65);
  text("Tutorial", 830, 350);

  fill(#aa836f);
  noStroke();
  ellipse(950, 550, 300, 300);

  fill(255);
  textSize(130);
  if (estado==8) {
    text("1", 910, 600);
  } else if (estado==9) {
    text("2", 910, 600);
  } 
}

//PANTALLA 10 TUTORIAL ---------------------------------------------------------------------------
void pantalla10() {
  fondo();

  fill(#898888);
  textSize(65);
  text("Tutorial", 830, 350);

  fill(#aa836f);
  noStroke();
  ellipse(950, 550, 300, 300);

  fill(255);
  textSize(130);
  
    text("3", 910, 600);
  
}

//PANTALLA 11 TUTORIAL ---------------------------------------------------------------------------
void pantalla11() {
  fondo();

  fill(#898888);
  textSize(65);
  text("Tutorial", 830, 350);

  fill(#aa836f);
  noStroke();
  ellipse(950, 550, 300, 300);

  fill(255);
  textSize(130);
  
    text("4", 910, 600);
  
}

//PANTALLA 12 TUTORIAL ---------------------------------------------------------------------------
void pantalla12() {
  fondo();

  fill(#898888);
  textSize(65);
  text("Tutorial", 830, 350);

  fill(#aa836f);
  noStroke();
  ellipse(950, 550, 300, 300);

  fill(255);
  textSize(130);
  
    text("5", 910, 600);
  
}

//PANTALLA 13 ---------------------------------------------------------------------------
void pantalla13() {
  fondo();
  fill(#898888);
  textSize(70);
  text("Siguiendo la lógica", 650, 400);
  textSize(140);
  text("¡ Empecemos !", 450, 600);
}

//PANTALLA 14 JUEGO---------------------------------------------------------------------------
void pantalla14() {

  if(pasarCasilla==9){
    
    estado=15;
    enJuego=false;
    
    
  }else{
    
   
  fondoDos();
  textSize(30);
  t.setValue(c.toString());
  t.draw(this);
  //t.setPosition(mouseX, mouseY);
  
  
  contador = c.second();

 
  if(contador == 5)
  {
    c.reset();
    guardar=arr[pasarCasilla];
    pasarCasilla++;
    FrenoJugador1=false;
    FrenoJugador2=false;
  }
  
  actual=arr[pasarCasilla];
  fill(#898888);
  textSize(50);
  text(actual,900,400);
  }
}

void mousePressed() {
  c.reset();
}

//PANTALLA DE RESULTADOS---------------------------------------------------------------------------
void pantalla15() {
  fondoDos();
  fill(#898888);
  textSize(50);
  text("Puntaje",800,100);
 for(int i=0;i<AciertosJugador1.length;i++){
   text("Jugador1 ",300,400);
    text(""+AciertosJugador1[0],600,400);
    text(""+AciertosJugador1[1],700,400);
    text(""+AciertosJugador1[2],800,400);
    text(""+AciertosJugador1[3],900,400);
    text(""+AciertosJugador1[4],1000,400);
    text(""+AciertosJugador1[5],1100,400);
    text(""+AciertosJugador1[6],1200,400);
    text(""+AciertosJugador1[7],1300,400);
    text(""+AciertosJugador1[8],1400,400);
    text(""+AciertosJugador1[9],1500,400);
    text("Jugador2 ", 300, 600);
    text(""+AciertosJugador2[0], 600, 600);
    text(" "+AciertosJugador2[1],700,600);
    text(" "+AciertosJugador2[2],800,600);
    text(" "+AciertosJugador2[3],900,600);
    text(" "+AciertosJugador2[4],1000,600);
    text(" "+AciertosJugador2[5],1100,600);
    text(" "+AciertosJugador2[6],1200,600);
    text(" "+AciertosJugador2[7],1300,600);
    text(" "+AciertosJugador2[8],1400,600);
    text(" "+AciertosJugador2[9],1500,600);
    
    fill(#898888);
  textSize(50);
  textAlign(LEFT);
  text("Presiona el ", 600, 830);
  image(btnNext, 890, 770);
  text("para continuar", 1000, 830);
 }
}

//GANADOR
void pantalla16() {
  fondoDos();
  if(puntosJugador1 > puntosJugador2){
     fill(#898888);
     textSize(50);
     text("Excelente nivel de atencion jugador1", 400, 400);
     textSize(100);
     text("¡Ganaste!", 630, 600);
  }else if (puntosJugador2 > puntosJugador1){
     fill(#898888);
     textSize(50);
     text("Excelente nivel de atencion jugador 2", 400, 400);
     textSize(100);
     text("¡Ganaste!", 630, 600);
  }else{
    textSize(100);
     text("¡WOW!", 750, 400);
     textSize(50);
     text("Los 2 tienen el mismo nivel de atencion", 400, 600);
  }
  
   fill(#898888);
  textSize(20);
  textAlign(LEFT);
  text("Presiona", 510, 780);
  image(btnNext, 500, 800);
  text("para jugar de nuevo", 460, 900);
  
   fill(#898888);
  textSize(20);
  textAlign(LEFT);
  text("Presiona", 900, 780);
  textSize(50);
  text("1", 930, 840);
   textSize(20);
  text("para jugar de nuevo", 850, 900);
  
  fill(#898888);
  textSize(20);
  textAlign(LEFT);
  text("Presiona", 1300, 780);
  textSize(50);
  text("2", 1330, 840);
   textSize(20);
  text("para ir al tutorial", 1280, 900);
  
}
//BOTON1
void boton1Pl1(){
  if(btn1Pl1 == 1){
    if(guardar == 1){
      puntaje++;
      println(puntaje);
    }
  }
}
//BOTON2
void boton2Pl1(){
  if(btn2Pl1 == 1){
    if(guardar == 2){
      puntaje++;
      println(puntaje);
    }
  }
}
//BOTON3
void boton3Pl1(){
  if(btn3Pl1 == 1){
    if(guardar == 3){
      puntaje++;
      println(puntaje);
    }
  }
}
//BOTON4
void boton4Pl1(){
  if(btn3Pl1 == 1){
    if(guardar == 4){
      puntaje++;
      println(puntaje);
    }
  }
}
//BOTON5
void boton5Pl1(){
  if(btn3Pl1 == 1){
    if(guardar == 5){
      puntaje++;
      println(puntaje);
    }
  }
}

  /*int currentTime = millis();

  tiempo = 5 - millis ()/1000;
  textSize(30);
  text ("Tiempo: " + tiempo, 200, 40);


  

if(prueba==false)
{
  for (int i=0; i<numeros.length; i++) 
  {

      numeros[i]=int(random(1, 5));
     
    
    
    if(i==numeros.length-1)
    {
     prueba=true; 
    }

    //numeros[i]=int(random(1, 5));
     if (presion==1) {
     prueba= true;
     if (prueba==true) {
     //numeros[i]=
     }
     } else if (presion==0) {
     }
  }
}*/

//for (int i=0; i<numeros.length; i++) 
  //{
//text(numeros[i], 200, 200);
 // } 
 
/*contador++;

if(contador >= 50 && contador <= 200)
{
 text(numeros[0], 200, 200); 
}
else if(contador >= 201 && contador <= 400)
{
 text(numeros[1], 200, 200); 
}


  if (currentTime > time) {
    //background(#FF0004);//Estos colores se cambian por imágenes
  }*/
