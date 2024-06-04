// Example programme showing the SimpleUIManager (declared in the SimpleUI_Classes tab)
// This is for version 1, where only Menus and Simple Buttons are possible
//
//
// (255/100) * (0.01*100)

SimpleUIManager uiManager;
int imageWidth;
int imageHeight;
String fs="";
PImage BackgroundImage = null;
float SlidePos = 0;

boolean BrightnessActive = false;
float BrightnessPreviousSliderPos = 0;
boolean GreyscaleActive = false;
PImage PreGreyBack;

class hsvdata
{
  public float h;
  public float s;
  public float v;
  
  public hsvdata(float hue, float sat, float val){
    
   h = hue;
   s = sat;
   v = val;
  }
}




void setup() {
  size(908,600);
  int top = 0;
  uiManager = new SimpleUIManager();
  
  String[] menu1Items =  { "New", "Save Preset", "Save Image", "Load Preset", "Load Image" };
  String[] menu2Items =  { "tom", "jerry", "rex","bugsbunny","thing5","thing6" };
  //String[] menu3Items =  { "fish", "cat", "dog","hen","verycutebunny","uglypug" };
  uiManager.addMenu("File", 1, top, menu1Items);
  uiManager.addMenu("menu2", 91, top, menu2Items);
  //uiManager.addMenu("menu3", 181, top, menu3Items);
  
  //uiManager.addSimpleButton("but 1", 100, 50);
  //uiManager.addSimpleButton("but 2", 180, 50);
  uiManager.addSimpleButton("Exit", 836, 0);
  
  uiManager.addToggleButton("toggle 1", 320, 20);
  uiManager.addToggleButton("toggle 2", 391, 20);
  
  SimpleButton  rectButton =   
  uiManager.addRadioButton("Select", 15, 130, "group1");
  uiManager.addRadioButton("Line", 15, 165, "group1");
  uiManager.addRadioButton("Rect", 15, 200, "group1");
  uiManager.addRadioButton("Circle", 15, 235, "group1");
  uiManager.addRadioButton("PolyLine", 15, 270, "group1");
  
  uiManager.addRadioButton("B & W", 810, 130, "group2");
  uiManager.addRadioButton("Greyscale", 810, 195, "group2");
  uiManager.addRadioButton("Transparency", 810, 260, "group2");
  uiManager.addRadioButton("Negative", 810, 325, "group2");
  uiManager.addRadioButton("HSV", 810, 390, "group2");
  uiManager.addRadioButton("Brightness", 810, 455, "group2");
  
  uiManager.addSlider("B&WSlide", 800, 164, false);
  uiManager.addSlider("GreyscaleSlide", 800, 229, false);
  uiManager.addSlider("TransparencySlide", 800, 294, false);
  uiManager.addSlider("NegativeSlide", 800, 359, false);
  uiManager.addSlider("HSVSlide", 800, 424, false);
  uiManager.addSlider("BrightnessSlide", 800, 489, false);
  
  rectButton.selected = true;
  //toolMode = rectButton.label;
  
  uiManager.addCanvas(100,100,790,590);
  
}


void draw() {
 background(255);
 //fill(255,0,0);
 //rect(0,0,300,300);

  
 
   uiManager.drawMe();
  if(this.BackgroundImage != null)
 {
   image(BackgroundImage, 101, 101);
   imageWidth = BackgroundImage.width;
   imageHeight = BackgroundImage.height;

 }
 
}

void newCanvas() {
  BackgroundImage = null;
  clear();
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " +  selection.getAbsolutePath());
    String SaveFilePath = selection.getAbsolutePath();
    PImage SaveCanvas = get(100,100,690,490);
    SaveCanvas.save(SaveFilePath+".jpg");
    fs=selection.getName();
  }
}

void loadAnImage(File fileNameObj)
{
  String pathAndFileName = fileNameObj.getAbsolutePath();
  
  PImage img = loadImage(pathAndFileName);
  
  img.resize(690, 490);//resizes image to fit canvas
  
  this.BackgroundImage = img;

}


void InvertRGB()
{
  for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++){
        
        // we get the pixel colour values here
        color thisPix = BackgroundImage.get(x,y);
        
        // and extract the seperate Red, Green and Blue values here
        int r = (int)red(thisPix);
        int g = (int)green(thisPix);
        int b = (int)blue(thisPix);
        int invertedred = 255 - r;
        int invertedgreen = 255 - g;
        int invertedblue = 255 - b;
        color newColour = color(invertedred,invertedgreen,invertedblue);
        BackgroundImage.set(x,y, newColour);
      }
  }

}

void BlackAndWhite()
{
    for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++){
        
        // we get the pixel colour values here
        color thisPix = BackgroundImage.get(x,y);
        
        // and extract the seperate Red, Green and Blue values here
        int r = (int)red(thisPix);
        int g = (int)green(thisPix);
        int b = (int)blue(thisPix);
        //int greyscale = (r+g+b) / 3;
        int blackandwhite;
        color Pixel = color(r,g,b);
        float Bright  = brightness(Pixel);
         if (Bright < 170)
          {
            blackandwhite = 0;
          }
         else {
            blackandwhite = 255;
          }
       
        color newColour = color(blackandwhite,blackandwhite,blackandwhite);
        BackgroundImage.set(x,y, newColour);
        
      }
    }

}

void Greyscale()
{
  if (GreyscaleActive == false); {
    GreyscaleActive = true;
    BrightnessActive = false;
    PreGreyBack = BackgroundImage;
  }
}

void GreyscaleManagement(float SlidePos, PImage BackgroundImage)
{
  if(GreyscaleActive == true) {
    for (int Y = 0; Y < imageHeight; Y++) {
      for (int X = 0; X < imageWidth; X++) {
        color thisPix = PreGreyBack.get(X,Y);
        int R = (int)red(thisPix);
        int G = (int)green(thisPix);
        int B = (int)blue(thisPix);
        float GreyValue = (R + G + B) / (2.5 + SlidePos);
        //print(GreyValue);
        color newColour = color(GreyValue, GreyValue, GreyValue);
        BackgroundImage.set(X,Y, newColour);
      }
    }
  }
  else return;
}

void Brightness()
{
  if (BrightnessActive == false) {
    BrightnessActive = true;
    GreyscaleActive = false;
    print(BrightnessActive);
  }
}

void BrightnessManagement(float SlidePos, PImage BackgroundImage)
{
  print("YOU WANT THIS THING HERE" + BrightnessActive);
  if (BrightnessActive == true) {
    if (SlidePos > BrightnessPreviousSliderPos) {
      BrightnessPreviousSliderPos = SlidePos;
      for (int Y = 0; Y < imageHeight; Y++) {
        for (int X = 0; X < imageWidth; X++) {
          color thisPix = BackgroundImage.get(X,Y);
          int R = (int)red(thisPix);
          int G = (int)green(thisPix);
          int B = (int)blue(thisPix);
          R = R + 1;
          G = G + 1;
          B = B + 1;
          color newColour = color(R, G, B);
          BackgroundImage.set(X,Y, newColour);
        }
      }
    }
    else if (SlidePos < BrightnessPreviousSliderPos) {
     BrightnessPreviousSliderPos = SlidePos;
     for (int Y = 0; Y < imageHeight; Y++) {
        for (int X = 0; X < imageWidth; X++) {
          color thisPix = BackgroundImage.get(X,Y);
          int R = (int)red(thisPix);
          int G = (int)green(thisPix);
          int B = (int)blue(thisPix);
          R = R - 1;
          G = G - 1;
          B = B - 1;
          color newColour = color(R, G, B);
          BackgroundImage.set(X,Y, newColour);
        }
      }
    }
  }
}

void HSV()
{

   for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++){
        
        // we get the pixel colour values here
        color thisPix = BackgroundImage.get(x,y);
        
        // and extract the seperate Red, Green and Blue values here
        int r = (int)red(thisPix);
        int g = (int)green(thisPix);
        int b = (int)blue(thisPix);
        
        hsvdata hsvCol = RGBtoHSV(r, g, b);
        hsvCol.h += 25;
       
       
        color newRGBcol = HSVtoRGB(hsvCol.h, hsvCol.s, hsvCol.v);
       
   
        BackgroundImage.set(x,y, newRGBcol);
       
      }
  }
}
void RGB()
{

   for (int y = 0; y < imageHeight; y++) {
      for (int x = 0; x < imageWidth; x++){
        
        // we get the pixel colour values here
        color thisPix = BackgroundImage.get(x,y);
        
        // and extract the seperate Red, Green and Blue values here
        int r = (int)red(thisPix);
        int g = (int)green(thisPix);
        int b = (int)blue(thisPix);
        hsvdata hsvCol = RGBtoHSV(r, g, b);
        hsvCol.h -= 25;
       
       
        color newRGBcol = HSVtoRGB(hsvCol.h, hsvCol.s, hsvCol.v);
       

       BackgroundImage.set(x,y, newRGBcol);
       
      }
  }

}

void Line()
{
  strokeWeight(8);
  line(mouseX, mouseY, pmouseX, pmouseY);
}

void Circle()
{
  noStroke();
  ellipse(mouseX, mouseY, pmouseX, pmouseY);
}

hsvdata RGBtoHSV(int r, int g, int b)
{
   int minRGB = min( r, g, b );
   int maxRGB = max( r, g, b );
   float value = maxRGB/255f; 
   int delta = maxRGB - minRGB;
   float hue = 0;
   float saturation;

   if( maxRGB != 0 ) 
    saturation = delta / (float)maxRGB; 
    

   
   else  {// it's black, so we don't know the hue
    return new hsvdata(-1, 0, 0);
   }
   if (delta == 0){
     delta = 1;
   }
  
  if( b == maxRGB ) hue = 4 + ( r - g ) / delta;   // between magenta, blue, cyan
  if( g == maxRGB ) hue = 2 + ( b - r ) / delta;   // between cyan, green, yellow
  if( r == maxRGB ) hue = ( g - b ) / delta;       // between yellow, Red, magenta
  
  hue = hue * 60;
  if (hue < 0) hue += 360;
  return new hsvdata(hue, saturation, value);
}




color HSVtoRGB(float hue, float sat, float val)
{
    float v;
    float red, green, blue;
    float m;
    float sv;
    int sextant;
    float fract, vsf, mid1, mid2;

    red = val;   // default to gray
    green = val;
    blue = val;
    v = (val <= 0.5) ? (val * (1.0 + sat)) : (val + sat - val * sat);
    m = val + val - v;
    sv = (v - m) / v;
    hue /= 60.0;  //get into range 0..6
    sextant = floor(hue);  // int32 rounds up or down.
    fract = hue - sextant;
    vsf = v * sv * fract;
    mid1 = m + vsf;
    mid2 = v - vsf;

    if (v > 0)
    {
        switch (sextant)
        {
            case 0: red = v; green = mid1; blue = m; break;
            case 1: red = mid2; green = v; blue = m; break;
            case 2: red = m; green = v; blue = mid1; break;
            case 3: red = m; green = mid2; blue = v; break;
            case 4: red = mid1; green = m; blue = v; break;
            case 5: red = v; green = m; blue = mid2; break;
        }
    }
    return color(red * 255, green * 255, blue * 255);
}


void mousePressed(){
  uiManager.handleMouseEvent("mousePressed",mouseX,mouseY);
}

void mouseReleased(){
  uiManager.handleMouseEvent("mouseReleased",mouseX,mouseY);
}

void mouseClicked(){
  uiManager.handleMouseEvent("mouseClicked",mouseX,mouseY);
}

void mouseMoved(){
    uiManager.handleMouseEvent("mouseMoved",mouseX,mouseY);
}

void mouseDragged(){
   uiManager.handleMouseEvent("mouseDragged",mouseX,mouseY);
}


void simpleUICallback(UIEventData eventData){
  // first boolean is for extra data, second boolean is to show mouseMoves, which you might not want
  eventData.printMe(true, true);
  
  switch(eventData.uiLabel){
          case "New":
            newCanvas();
            break;
          case "Load":
             selectInput("Open image", "loadAnImage");
             break;
          case "Save as":
             selectOutput("Save Image as", "fileSelected");
             break;
          case "HSV":
              HSV();
              break;
          case "RGB":
              RGB();
              break;
          case "InvertRGB":
             InvertRGB();
             break;
         case "BlackAndWhite":
             BlackAndWhite();
             break;
         case "Greyscale":
             Greyscale();
             break;
         case "GreyscaleSlider":
             SlidePos = eventData.sliderPosition;
             GreyscaleManagement(SlidePos, BackgroundImage);
             break;
         case "Brightness":
             Brightness();
             break;
         case "BrightnessSlider":
             SlidePos = eventData.sliderPosition;
             BrightnessManagement(SlidePos, BackgroundImage);
             break;
         case "Line":
             Line();
             break;
         case "Circle":
             Circle();
             break;   
       
        }
 
}
