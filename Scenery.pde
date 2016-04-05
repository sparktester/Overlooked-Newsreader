class Scenery  {

  PFont Arial;
  PFont ArialSmall;

  int lastSelected;

  boolean firstTimeThrough;
  
  PImage map;
  PImage nyt;
  
  int nytcounter;
  
  String NYTActiveTriangle;
  String OverlookedActiveTriangle;


  Scenery ()   {

    smooth();

    Arial = loadFont("ArialMT-20.vlw");
    ArialSmall = loadFont("ArialMT-10.vlw");

    map = loadImage("map.gif");
    nyt = loadImage("nyt.gif");

    lastSelected = 0;  
    
    nytcounter = 0;
    
    NYTActiveTriangle = "down";   //says which triangle is highlighted at any given moment - up, down, or both
    OverlookedActiveTriangle = "down";   //says which triangle is highlighted at any given moment

  }

  void display() {
    fill (255);  //white background for the top
    rect(0, 352, width, height);

    fill(240);  //grey right-side
    noStroke();
    rect(595, 3, 202, height-3);
    
    noTint();
    image(map, 3, 3);


    fill(88);
    textFont(Arial, 20); 
    text("recently covered", 645, 25);
    
    text("recently missed", 652, 293);
    
    //display scroll triangles
    
    triangle(630, 32, 620, 47, 640, 47);    //nyt top
    
     triangle(630, 267, 620, 252, 640, 252);  //nyt bottom
    
    triangle(630, 302, 620, 317, 640, 317);   //overlooked top
     
    triangle(630, 537, 620, 522, 640, 522);  //overlooked bottom
    
    
    
    
    //display rolling text at bottom
    tint(255, 255, 255, 30); 
    image(nyt, 0-nytcounter, visualization[0].articleY-28);  //used 0 for no particular reason other than there probably will always be one

    image(nyt, 0+2228-nytcounter, visualization[0].articleY-28);  //used 0 for no particular reason other than there probably will always be one

    if (nytcounter>=2228) 
    { nytcounter=-1;
    }
    nytcounter=nytcounter+1;
    
  }

  void displayMapItems(){

    //int w=0;  //this is the number of pixels down the name needs to be

    for (int i=0; i<visualization.length; i++){
      smooth();

      visualization[i].display();
      //println(i);

      //w=w+15;  //incrimenting w further down
    }
    
     //w=0;  // go back to the top of the page
    for (int i=0; i<overlookedVisualization.length; i++){
      smooth();

      overlookedVisualization[i].display();
      //println(i);

      //w=w+15;  //incrimenting w further down
    }

  }


  void mouseLogicMap (int mouseX, int mouseY) {

    if (mouseX < 600) {

      println ("test");

      //check if something has been clicked in visualization on the map      
      for (int i=0; i< visualization.length ; i++){

        if (((mouseX >(visualization[i].xlocal)-10)&&(mouseX <(visualization[i].xlocal)+10)) && ((mouseY >(visualization[i].ylocal)-10)&&(mouseY <(visualization[i].ylocal)+10)))  
        {     
          
          if (lastSelected <= overlookedVisualization.length) {
            
            overlookedVisualization[lastSelected].isSelected = false;   //turn off the color for the last selected item if it was in overlooked
            overlookedVisualization[lastSelected].ylocalLine = overlookedVisualization[lastSelected].ylocal;  
        }
          
           if (lastSelected <= visualization.length) {
            
            visualization[lastSelected].isSelected = false;   //turn off the color for the last selected item if it was in visualization
            visualization[lastSelected].ylocalLine = visualization[lastSelected].ylocal;  
        }


          visualization[i].isSelected=true;  //i'm putting this here instead of mapItem for modularity

          lastSelected = i;

          //visualization[i].displayArticle();

        } //close if

      } //close for
      
      //check if something has been clicked in overlookedVisualization on the map
      
      for (int i=0; i < overlookedVisualization.length ; i++){

        if (((mouseX >(overlookedVisualization[i].xlocal)-10)&&(mouseX <(overlookedVisualization[i].xlocal)+10)) && ((mouseY >(overlookedVisualization[i].ylocal)-10)&&(mouseY <(overlookedVisualization[i].ylocal)+10)))  
        {     
          
          if (lastSelected <= overlookedVisualization.length) {
            
            overlookedVisualization[lastSelected].isSelected = false;   //turn off the color for the last selected item if it was in overlooked
            overlookedVisualization[lastSelected].ylocalLine = overlookedVisualization[lastSelected].ylocal;  
        }
          
           if (lastSelected <= visualization.length) {
            
            visualization[lastSelected].isSelected = false;   //turn off the color for the last selected item if it was in visualization
            visualization[lastSelected].ylocalLine = visualization[lastSelected].ylocal;  
        }
          

          overlookedVisualization[i].isSelected=true;  //i'm putting this here instead of mapItem for modularity

          lastSelected = i;

          //visualization[i].displayArticle();

        } //close if

      } //close for

    }//close if the click is on the map
    
    
    else if ((mouseY > 47) && (mouseY <252)) {  //they're clicking somewhere in visualization
    
        float tempMouseY = float(mouseY);
        
        float clickIndex = ((tempMouseY-63)/15)*15;
        
        println (clickIndex);
        
           for (int i=0; i < visualization.length ; i++){
             
             if ((clickIndex >= (visualization[i].ytext)-10)&&(clickIndex <= (visualization[i].ytext+5))) {
               
               println ("city:" + visualization[i].City);
               
               
               ///start process:
               if (lastSelected <= overlookedVisualization.length) {
            
            overlookedVisualization[lastSelected].isSelected = false;   //turn off the color for the last selected item if it was in overlooked
            overlookedVisualization[lastSelected].ylocalLine = overlookedVisualization[lastSelected].ylocal;  
        }
          
           if (lastSelected <= visualization.length) {
            
            visualization[lastSelected].isSelected = false;   //turn off the color for the last selected item if it was in visualization
            visualization[lastSelected].ylocalLine = visualization[lastSelected].ylocal;  
        }
          

          visualization[i].isSelected=true;  //i'm putting this here instead of mapItem for modularity

          lastSelected = i;
              
               
             }//end if
             
           }//end for
    
  }//end elseif
  
   else if ((mouseY > 317) && (mouseY <522)) {  //they're clicking somewhere in visualization
    
        float tempMouseY = float(mouseY);
        
        float clickIndex = ((tempMouseY-335)/15)*15;
        
        println (clickIndex);
        
           for (int i=0; i < overlookedVisualization.length ; i++){
             
             if ((clickIndex >= (overlookedVisualization[i].ytext)-10)&&(clickIndex <= (overlookedVisualization[i].ytext+5))) {
               
               println ("city:" + overlookedVisualization[i].City);
               
               if (lastSelected <= overlookedVisualization.length) {
            
            overlookedVisualization[lastSelected].isSelected = false;   //turn off the color for the last selected item if it was in overlooked
            overlookedVisualization[lastSelected].ylocalLine = overlookedVisualization[lastSelected].ylocal;  
        }
          
           if (lastSelected <= visualization.length) {
            
            visualization[lastSelected].isSelected = false;   //turn off the color for the last selected item if it was in visualization
            visualization[lastSelected].ylocalLine = visualization[lastSelected].ylocal;  
        }
          

          overlookedVisualization[i].isSelected=true;  //i'm putting this here instead of mapItem for modularity

          lastSelected = i;

             }//end if
             
           }//end for
    
     }//end elseif
    //check for the triangles to see if we should move things up or down

      
      if ((mouseX <= 640) && (mouseX >= 620) && (mouseY >= 32) && (mouseY <= 47))  //the first triangle has been triggered
        {  
          
                for (int i=0; i< visualization.length ; i++){
                    
                  visualization[i].ytext = visualization[i].ytext -15;
                  
                }  //end for
          
        }//end if first triangle
        
      if ((mouseX <= 640) && (mouseX >= 620) && (mouseY >= 252) && (mouseY <= 267))  //the second triangle has been triggered
        {  
          
                for (int i=0; i< visualization.length ; i++){
                    
                  visualization[i].ytext = visualization[i].ytext +15;
                  
                }  //end for
        }//close second if
        
       if ((mouseX <= 640) && (mouseX >= 620) && (mouseY >= 302) && (mouseY <= 317))  //the third triangle has been triggered
        {  
          
                for (int i=0; i< overlookedVisualization.length ; i++){
                    
                  overlookedVisualization[i].ytext = overlookedVisualization[i].ytext -15;
                  
                }  //end for
          
        }//end if third triangle
        
         if ((mouseX <= 640) && (mouseX >= 620) && (mouseY <= 537) && (mouseY >= 522))  //the fourth triangle has been triggered
        {  
          
                for (int i=0; i< visualization.length ; i++){
                    
                  overlookedVisualization[i].ytext = overlookedVisualization[i].ytext +15;
                  
                }  //end for
        }//close fourth if
        
      //int clickIndex = ((mouseY-35)/15);  

      //visualization[lastSelected].isSelected = false;

      //visualization[lastSelected].ylocalLine = visualization[lastSelected].ylocal;

      //visualization[clickIndex].isSelected=true;  //i'm putting this here instead of mapItem for modularity

      //lastSelected = clickIndex;

   

  }   //close mouselogicmap

}  //close class

