//globals
PImage spritesheet;
PImage Logo;
PImage bob;
ArrayList<Bob> bobs = new ArrayList<Bob>();
spritehandler Text;
spritehandler Bobs;
PImage[] p;
short index = 0;
float a = 0;
int offsetx;
float offsety;
short frame = 0;
short c;
byte logoindex = 0;
byte offsetbob = 10;
byte bobindexoffset = 0;
byte h = 23;
byte w = 12;
byte wbob = 20;
byte hbob = 20;
String ref = "0123456789abcdefghijklmnopqrstuvwxyz!.- ";
String s = "this is a cool intro!@";
float x;
float[] xi = new float[s.length()];
void setup()
{
    size(800,600);
    background(0);
    spritesheet = loadImage("spritesheet.png");
    Logo = spritesheet.get(30,15,34,8);
    bob = spritesheet.get(0,15,30,30);
    Text = new spritehandler(0F,chars(s,ref),spritesheet,byte(8),byte(15));
    p = Text.positionalset();
}
PVector[] bobpos(PImage Logo)
{
    ArrayList<PVector> pos = new ArrayList<PVector>();
    for (short i=0; i < Logo.pixels.length;i++)
    {
        if (Logo.pixels[i] != 0)
        {
            int x = i % Logo.width;
            int y = floor(i/Logo.width);
            pos.add(new PVector(x,y));
        }
    }
    return pos.toArray(new PVector[pos.size()]);
}
void draw()
{
    //index = short(frameCount % (s.length() +1));
    background(0,0,0);
    update_parentbob();
    //offsetx = width - 4 * frame;
    //for (short i = 0; i<s.length(); i++)
    //{
        //offsety += .15;
        //x = offsetx + i*w;
        //image(p[i],x,map(sin(a+offsety),-1,1,10,75),w, h);
    //}
    a += .05;
    frame += 1;
}
PGraphics mask_(int h,int w, float a,char offsety)
{
    PGraphics pg = createGraphics(w,h);
    pg.beginDraw();
    pg.loadPixels();
    for(int y =0; y<h; y++)
    {
        for(int x =0; x<w;x++)
        {
            pg.pixels[y*w+x] = color(y-map(sin(a),-1,1,0,Logo.height*hbob+offsety),0,map(sin(a),-1,1,0,Logo.height*hbob+offsety)-y);
            
        }
    }
    pg.updatePixels();
    pg.endDraw();
    return pg;
}
byte[] chars(String text, String ref)
{
    byte[] a = new byte[text.length()];
    for (short i = 0; i < text.length(); i++)
    {
        a[i] = byte(ref.indexOf(text.charAt(i)));
    }
    return a;
}
void update_parentbob()
{
  if (frame % 500 == 0)
  {
    logoindex = byte((logoindex+1)%2);
  }
    int offsety = width/3;
    float x = map(sin(a*.2),-1,1,100,width-100);
    float y = map(cos(a),-1,1,wbob*(Logo.height+1),height/3);
    PGraphics mask = mask_(int(offsety+(wbob*Logo.height)+wbob), width, a,char(offsety));
    PImage newmask = mask.get(int(height/2),int(y),30,30);
    newmask.mask(bob);
    image(newmask,x,y,wbob,hbob);
    if ((frame % 5 == 0) && (bobs.size() <= 89))
    {
        PVector bobpos = bobpos(Logo)[bobindexoffset];
        bobs.add(new Bob(x,y,bobpos.x*wbob,bobpos.y*hbob,bob,wbob,hbob,(width/2)-wbob*(Logo.width)/2,offsety));
        bobindexoffset += 1;
    }
    for (int i = 0; i<bobs.size();i++)
    {
        bobs.get(i).Update(mask);
        bobs.get(i).x2 = map(sin(a),-1,1,;
    }
}
class Bob
{
    float spd=3;
    PImage bob;
    byte time = 0;
    byte w;
    byte h;
    PVector pos;
    float a;
    float y2;
    byte opacity = byte(0xFF);
    float x2;
    PImage newmask;
    float offsetx;
    float offsety;
    Bob(float x1,float y1,float x2, float y2, PImage bob,byte w, byte h,float offsetx, float offsety)
    {
        this.pos = new PVector(x1, y1);
        //this.a = atan((y2-y1)/(x2-x1));
        this.w = w;
        this.h = h;
        this.y2 = y2;
        this.x2 = x2;
        this.bob = bob;
        this.offsetx = offsetx;
        this.offsety = offsety;
    }
    void Update(PGraphics mask)
    {
        newmask = mask.get(int(pos.x),int(pos.y),30,30);
        mask.loadPixels();
        newmask.mask(bob);
        image(newmask, pos.x, pos.y, w, h);
        pos.set((1-.05) * pos.x + .05 * (x2 +offsetx), (1-.05) * pos.y + .05 * (y2+offsety));
    }
    void Fadeout(float spd)
    {
        newmask.tint(255F,opacity-spd);
    }
}
class spritehandler //<>//
{
    byte[] pos;
    float yoffset;
    byte ht;
    PImage shortset;
    byte wdt;
    spritehandler(float yoffset, byte[] pos, PImage shortset, byte wdt, byte ht)
    {
        this.ht = ht;
        this.yoffset = yoffset;
        this.pos = pos;
        this.wdt = wdt;
        this.shortset = shortset;
    }
    PImage[] positionalset()
    {
        PImage[] t = new PImage[pos.length];
        int a = 0;
        for (short i = 0; i<pos.length; i++)
        {
            a = wdt*pos[i];
            t[i] = shortset.get(a, 0, wdt, ht);
        }
        return t;
    }
    //byte pixelsin()
    //{
      
      
    //}
}
//code by Thigurr/MFCKR Crew