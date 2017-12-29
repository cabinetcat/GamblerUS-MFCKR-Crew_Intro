PImage charset;
PImage Logo;
float offset;
byte spc = 8;
byte letter_height = 15;
scroller_Text Text;
PImage[] p;
char index = 0;
float y = 0;
char windowwidth = 852;
byte height = 23;
byte width = 12;
String s = "THIS@IS@THE@FIRST@INTRO@OF@THE@MFCKR@CREW[@@@@@@@@SCROLLER@ROUTINE@CODED@BY@THIGURR@OF@THE@MFCKR@CREW]]]]]]TESTING@123";
float x;
char[] a;
float[] xi = new float[s.length()];
void setup()
{
    size(852,235);
    background(0);
    Logo = loadImage("MFCKR_logo.bmp");
    charset = loadImage("intro-charset.png");
    Text = new scroller_Text(chars(s),charset);
    p = Text.cset();
    a = xarr();
}
char[] xarr()
{
  char[] a = new char[s.length()];
  for (char i = 0; i<s.length(); i++)
  {
    a[i] = char(i*width);
  }
  return a;
}
void draw()
{
  
//index = char(frameCount % (s.length() +1));
  background(0,0,0);
  for (char i = 0; i<s.length(); i++)
    {
        image(p[i],char(i*width)+ (852 - xi[i]), map(sin(y+offset),-1,1,0,75),width, height);
        offset += .13; 
        x += .02;
        xi[i] = x % (852 + (a[i]) +((s.length()-i)*8)-60);
    }
  y+= 16;
  
} //<>//
byte[] chars(String char_ref)
{
    char[] buffer = char_ref.toCharArray();
    byte[] a = new byte[char_ref.length()];
    for (char i = 0; i < char_ref.length(); i++)
    {
        a[i] = byte(buffer[i] - 48);
    }
    return a;
}