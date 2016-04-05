//this class is for an object.  An array of them will be created each time RSSGrabber is run.
//Each object knows its url, city, state, lat, and long.  It may eventually also know its sensative area for mousepressed

class MapItem  {
  //global class variables:

  //String URL;
  String Headline;
  String Blurb;
  String City;
  String Country;
  float Lat;
  float Long;
  boolean isOverlooked;

  int xlocal;  //the location of the circle where the location exists
  int ylocal;

  int ylocalLine;  //the lenght of th line between the point on the map and the article
  
  String cityCountry;
  
 
  int ytext;  //the y location of where the cityCountry exists at any given time.  
  

  color unselected = color(6,10,191);
  color selected = color(0, 155,  224);
  boolean isSelected = false;

  PFont Arial;
  PFont ArialSmall;
  PFont ArialMedium;
  PFont ArialMediumItalic;

  float distance;  //the amount of space between the map visualization and the article visualization
  float distanceLeft; //the amount of line left to draw

  int articleX;  //location for article at the bottom of the page
  int articleY;
  
  

  //Constructor

  MapItem (String tempHeadline, String tempBlurb, String tempCity, String tempCountry, float tempLat, float tempLong, boolean tempIsOverlooked, int tempPosition)  {

    //this is where the constructor will hit the database and collect the info it needs, and dump it in the following array:

    //URL=tempURL;
    Headline=tempHeadline;
    Blurb=tempBlurb;
    City=tempCity;
    Country=tempCountry;
    Lat=tempLat;
    Long=tempLong; 
    isOverlooked = tempIsOverlooked;

    xlocal = int(map(Long, -180, 180, 0, 588));
    ylocal = int(map(Lat-32, 90, -90, 0, 349));  //31 because this map does not cover the arctic
    
    ytext = tempPosition * 15;  //this gives us the number of pixels down it appears at. Each item scoots south fifteen pixels

    ylocalLine = ylocal;
    
    cityCountry = City + ", " + Country;  //A string with both City and Country in it

    smooth();

    Arial = loadFont("ArialMT-20.vlw");
    ArialSmall = loadFont("ArialMT-10.vlw");
    ArialMedium = loadFont ("ArialMT-12.vlw");
    ArialMediumItalic = loadFont ("Arial-ItalicMT-12.vlw");

    articleX=30;
    articleY=380;
    
    
    if (isOverlooked) {
      
      //println ("This is an overlooked item");
      
      unselected = color(21, 142, 26);
      selected = color(70, 203, 75);
    }

  }

  void display()  {

    //check and set the dot color

    smooth();

    if (isSelected) {

      fill(selected);    
    }

    else{
      fill(unselected);
    }

    //create the dot on the map
    ellipse(xlocal, ylocal, 10, 10);


    textFont(ArialSmall, 10); 
    
    if ((!isOverlooked)&& (ytext < 190) && (ytext >= 0)) {
      
        //give us the text names of the countries
        
        text(cityCountry, 610, 63 + ytext);  
        
        //println (ytext);
    
    }
    
    else if ((isOverlooked) && (ytext <190) && (ytext >=0))        {
      
      text(cityCountry, 610, 335 + ytext);  
      
    }

    //create the graphic items particula for items that are selected
    if (isSelected) { 

      stroke(selected);
      strokeWeight(3);

      line (xlocal , ylocal+3, xlocal, ylocalLine);

      ylocalLine=constrain(ylocalLine+6, 0, 380);

      if (ylocalLine >=articleY) {

        displayArticle();

      }

      noStroke(); 
      fill(255);
      ellipse(xlocal, ylocal, 6, 6);

    }

  }

  void displayArticle() { 

    //make the bckground rectangle

    fill(255, 200);
    stroke(selected);
    strokeWeight(3);
    rect (articleX, articleY, 530, 140);

    fill (selected);
    noStroke();

    textFont(Arial, 20); 
    text(Headline, articleX+20, articleY+25, 450, 200);
    
    
    textFont(ArialSmall, 10); 
    text(cityCountry, articleX+20, articleY+80);
    
    fill (0);
    textFont(ArialMedium, 12); 
    text(Blurb, articleX+20, articleY+85, 450, 250);
    
    //fill (160,160,160);
    //textFont (ArialMediumItalic);
    //text(URL, articleX+20, articleY+110);

  }

}




