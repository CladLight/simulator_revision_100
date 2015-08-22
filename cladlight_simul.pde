/*
 * CladLight (c) 2015
 *
 * Indicator lights simulation
 *
 * ATTiny 85
 *
 */

const int left = 0; // white-blue
const int right = 1; // white-orange
const int hazard = 4;

const int indicatorL = 2; // blue-white
const int indicatorR = 3; // orange-white

const int del = 500;

int select = -1;

void setup()
{
  pinMode(left, INPUT);
  pinMode(right, INPUT);
  pinMode(hazard, INPUT);
  pinMode(indicatorL, OUTPUT);
  pinMode(indicatorR, OUTPUT);
  
} // set up

void loop()
{
    switch(select)
    {
      case 0: // Left
      {
        if (!checkLeft())
          indicateLeft();
          
      } break;
      
      case 1: // right
      {
        if (!checkRight())
          indicateRight();
        
      } break;
      
      case 2: // hazard
      {
        hazards();
        
      } break;
      
      default:
      {
          if (digitalRead(right))
          {
            select = 1;
            
            indicateRight();
            
          } // indicate right
          
          if (digitalRead(left))
          {
            select = 0;
            
            indicateLeft();
        
          } // indicate left
          
          if (digitalRead(hazard))
          {
            select = 2;
            
            hazards();
            
          } // harzard
          
      } break;
      
    } // switch

} // loop

void indicateLeft()
{  
  digitalWrite(indicatorL, HIGH);
  
  delay(del);
  
  if (checkLeft())
  {
    digitalWrite(indicatorL, LOW);
    
    delay(1000);
    
    return;
  } // check left
  
  digitalWrite(indicatorL, LOW);
  
  delay(del);
  
} // indicate left

void indicateRight()
{
  digitalWrite(indicatorR, HIGH);
  
  delay(del);
  
  if (checkRight())
  {
    digitalWrite(indicatorR, LOW);
    
    delay(1000);
    
    return;
  } // check right
  
  digitalWrite(indicatorR, LOW);
  
  delay(del);
  
} // indicate Right

boolean checkLeft()
{
  boolean result = false;
  
  if (digitalRead(right))
  {
    select = 1;
    
    result = true;
    
  } // if right is there
  
  else if (digitalRead(left))
  {
    select = -1;

    result = true;
    
  } // cancel left
  
  return result;
  
} // check left

boolean checkRight()
{
  boolean result = false;
  
  if (digitalRead(left))
  {
    select = 0;
    
    result = true;
    
  } // if right is there
  
  else if (digitalRead(right))
  {          
    select = -1;
    
    result = true;
    
  } // cancel right
  
} // check right

void hazards()
{
  digitalWrite(indicatorR, HIGH);
  digitalWrite(indicatorL, HIGH);
  
  delay(del);
  
  digitalWrite(indicatorR, LOW);
  digitalWrite(indicatorL, LOW);
  
  delay(del);
  
} // hazard
