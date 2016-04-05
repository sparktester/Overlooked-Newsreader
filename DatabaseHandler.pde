//this class exists only to deal with the database.  I may not use it in the final version.

 
 //Declare the XML request as a global.  This is not part of the Database Handler class
 XMLRequest xmlRequest;

class DatabaseHandler  {

  //global class variables

  //String[]   URL={
    //    "http://www.nytimes.com/2008/10/23/business/economy/23rating.html?_r=1&partner=rssnyt&emc=rss&oref=slogin" , "http://www.nytimes.com/2008/10/23/nyregion/23fiction.html?partner=rssnyt&emc=rss" , "http://www.nytimes.com/2008/10/23/world/asia/23afghan.html?partner=rssnyt&emc=rss", "http://www.nytimes.com/2008/10/22/world/europe/22italy.html?partner=rssnyt&emc=rss" , "http://www.nytimes.com/2008/10/22/world/asia/22indiamoon.html?partner=rssnyt&emc=rss"       };
   
   /*
    String[]    Headline= {
        "Credit Rating Agency Heads Grilled by Lawmakers", "Urban Fiction Goes From Streets to Public Libraries", "Airstrike Kills 9 Afghan Soldiers", "Italy’s Crisis Has Premier Riding High" , "India Launches Unmanned Orbiter to Moon"       };
   String[]     Blurb = {
        "Members of Congress leveled sharp criticism at what they called egregious lapses at the credit-rating agencies.", "Many libraries are embracing a sometimes controversial genre of “street lit” in an effort to attract new readers.", "The United States-led coalition said that the attack may have been a case of mistaken identity on both sides." , "Italy’s prime minister, Silvio Berlusconi, is getting a boost to his political fortunes from the economic crisis." , "The mission is scheduled to last for two years, in which the craft will search the lunar surface for natural resources."       };
    String[]    City = {
        "Washington DC", "New York City", "Kabul" , "Rome" , "New Delhi"      };
     String[]   Country = {
        "United States","United States","Afghanistan", "Italy" , "India"      };
    Float[]    Lat = {
        38.87, 40.75, 34.51 , 41.89 , 28.63       };
     Float[] Long = {
        -77.03, -73.98, 69.19 , 12.48 , 77.22       };
        
  String[]  OverlookedHeadline= {"temp"};
  String[]  OverlookedBlurb={"temp"}; 
  String[]  OverlookedCity = { "Loading"      };  
  String[]  OverlookedCountry ={"please wait"}; 
  float[]  OverlookedLat ={-190.0}; 
  float[]  OverlookedLong={-190.0}; 

*/
  String[] CountryMissed;
  String[] URLMissed;


  String[]  Headline= {"temp"};
  String[]  Blurb={"temp"}; 
  String[]  City = { "Loading"      };  
  String[]  Country ={"please wait"}; 
  float[]  Lat ={-190.0}; 
  float[]  Long={-190.0}; 
 boolean[]  IsOverlooked={false}; 
  
 
  //Constructor
  DatabaseHandler () {   //This actually will receive the url of the database in the form of URL = new String[5] ;


      //some fake information for the countries missed.
      CountryMissed = new String[5];
      for(int u=0; u<5; u++)  {  //This is actually going to be the number of rows
         CountryMissed [u] =str(random(10));  //just giving it some content
       }
      
       
       
      //read in the  with the database info
      xmlRequest.makeRequest();
     
      //Now the program waits for the returning information to trigger netEvent
  }

void recordDB (String[] tempCity, String[] tempCountry, String[] tempHeadline, String[] tempBlurb, float[] tempLat, float[] tempLong, boolean[] tempIsOverlooked) {
  
  //take the variables you assigned and make them universally usable
    City[0] = tempCity[0];  //cover up the initial item
    Country[0] = tempCountry[0];  //cover up the initial item
    Headline[0] = tempHeadline[0];  //cover up the initial item
    Blurb[0] = tempBlurb[0];  //cover up the initial item
    Lat[0] = tempLat[0];  //cover up the initial item
    Long[0] = tempLong[0];  //cover up the initial item
    IsOverlooked[0] = tempIsOverlooked[0];  //cover up the initial item
    
 
    
    for (int i=1; i< tempCity.length; i++) {  //fill in the rest of the items
      City = append(City, tempCity[i]); 
     // println ("cities:" + City.length);
  }
        
    for (int i=1; i< tempCountry.length; i++) {  //fill in the rest of the items
      Country = append(Country, tempCountry[i]); 
      // println ("Countries:" + Country.length);
  }
       
    for (int i=1; i< tempHeadline.length; i++) {  //fill in the rest of the items
      Headline = append(Headline, tempHeadline[i]); 
       //println ("Headlines:" + Headline.length);
  }
  
     
    for (int i=1; i< tempBlurb.length; i++) {  //fill in the rest of the items
      Blurb = append(Blurb, tempBlurb[i]); 
       //println ("blurb:" + Blurb.length);
  }
      
    for (int i=1; i< tempLat.length; i++) {  //fill in the rest of the items
       
      Lat = append(Lat, tempLat[i]); 
       //println ("Lat:" + Lat.length);
  }
    
    for (int i=1; i< tempLong.length; i++) {  //fill in the rest of the items
      Long = append(Long, tempLong[i]); 
      // println ("Long:" + Long.length);
      
    }
    
     for (int i=1; i< tempIsOverlooked.length; i++) {  //fill in the rest of the items
      IsOverlooked = (boolean[])append(IsOverlooked, tempIsOverlooked[i]); 
      // println ("IsOverlooked:" + IsOverlooked.length);
      
    }
  
  fillArticles();
  
  }//close function
 
}//close class

//note, netEvent is not technically part of the DatabaseHandler Class.
void netEvent(XMLRequest xmlRequest) {
  
  println ("netEvent");
  
    //get the all the headlines
  String [] localCity = xmlRequest.getElementArray( "city" );
  //println(xmlRequest.getElementArray( "city" ));  // Print message
        
  String [] localCountry = xmlRequest.getElementArray( "country" );
  //println("Request completed!" + Headlinetest.length);  // Print message
      
  String [] localHeadline = xmlRequest.getElementArray( "headline" );
  //println("Request completed!" + Headlinetest.length);  // Print message
    
  String [] localBlurb = xmlRequest.getElementArray( "blurb" );
  //println("Request completed!" + Headlinetest.length);  // Print message
      
    float [] localLat = float(xmlRequest.getElementArray( "lat" ));
  //println("Request completed!" + Headlinetest.length);  // Print message
  
    float [] localLong = float(xmlRequest.getElementArray( "long" ));
  //println("Request completed!" + Headlinetest.length);  // Print message
  
    boolean [] localIsOverlooked = boolean(xmlRequest.getElementArray( "isoverlooked" ));
    
    
      //for (int i = 0; i < LocalIsOverlooked.length; i++ ) {
        
        //LocalIsOverlooked[i] = boolean(tempLocalIsOverlooked[i]);
        
          //println(localIsOverlooked[i]);
      //}
  
 DBInfo.recordDB(localCity, localCountry, localHeadline, localBlurb, localLat, localLong, localIsOverlooked);
  
  
  //testing purposes only

  
}


//also not part of the Database Handler class, this is global but placed here for ease of finding
void fillArticles(){
  
 
  
  //Create new articles out of the new information
  //put them in the visualization array - replace the first item and append the others
  
   //these keep track of where we are in the arrays of MapItemObjects when we're loading them up
  int NYTCounter = 0;  
  int OverlookedCounter = 0;
  
 
 for (int i=0; i < DBInfo.Headline.length; i++){
   
   if (DBInfo.IsOverlooked[i] == false) {
     
     // println ("DBInfo is false");
     
     if (NYTCounter == 0){  //if this is the first time we're hitting a NYTimes article
      //println ("And this is the first NYTimes Article");
   
       MapItem tempMapItem = new MapItem(DBInfo.Headline[0], DBInfo.Blurb[0], DBInfo.City[0], DBInfo.Country[0], DBInfo.Lat[0], DBInfo.Long[0], false, NYTCounter);
        visualization[0] = tempMapItem;
        
        NYTCounter++;
 
       }  //end if nytcounter==0
   
   else {
     
        MapItem tempMapItem = new MapItem(DBInfo.Headline[i], DBInfo.Blurb[i], DBInfo.City[i], DBInfo.Country[i], DBInfo.Lat[i], DBInfo.Long[i], false, NYTCounter);
    
        visualization = (MapItem[])append(visualization, tempMapItem);
        
        NYTCounter++;
        
      }//end else
 
     
   }//end if this is not an overlooked article
   
   else {    //if isOverlooked=true
   
   //println ("DBInfo is true");
   
     if (OverlookedCounter==0){  //if this is the first time we're hitting an Overlooked article
        
        //println ("And this is the first Overlooked Article");
   
       MapItem tempMapItem = new MapItem(DBInfo.Headline[i], DBInfo.Blurb[i], DBInfo.City[i], DBInfo.Country[i], DBInfo.Lat[i], DBInfo.Long[i], true, OverlookedCounter);
        overlookedVisualization[0] = tempMapItem;
        
        OverlookedCounter++;
 
       }  //end if nytcounter==0
   
     else {  //if overlookedcounter is not 0
     
        MapItem tempMapItem = new MapItem(DBInfo.Headline[i], DBInfo.Blurb[i], DBInfo.City[i], DBInfo.Country[i], DBInfo.Lat[i], DBInfo.Long[i], true, OverlookedCounter);
    
        overlookedVisualization = (MapItem[])append(overlookedVisualization, tempMapItem);
        
        OverlookedCounter++;
        
      }//end else
 
   
   }//end else
   
 } //end for loop
   
  
}//end function
