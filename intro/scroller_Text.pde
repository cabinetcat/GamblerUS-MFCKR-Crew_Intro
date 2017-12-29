class scroller_Text //<>// //<>// //<>//
{
    byte[] pos;
    PImage charset;
    scroller_Text(byte[] pos, PImage charset)
    {
        this.pos = pos;
        this.charset = charset;
    }
    PImage[] cset()
    {
        PImage[] t = new PImage[pos.length];
        char a = 0;
        for (char i = 0; i<pos.length; i++)
        {
            a = char(spc*pos[i]);
            t[i] = charset.get(a, 0, spc, letter_height);
        }
        return t;
    }
    void init()
    {
      
    }
    void Scroll()
    {
      
    }
}