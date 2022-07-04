public with sharing class DowntriangleProgram
{
    public void DowntriangleProgram1()
    {
        Boolean b=true;
        for(Integer i=1;i<=5;i++)
        {
            string s='  ';
            for(Integer j=1;j<=9;j++)
            {
                if(i>=2 && i<=4)
                {
                    if(j>=1+i && j<=9-i)
                    { 
                        b=false;
                    }
                    else
                    {
                        b=true;
                    }
                }
                else
                {
                    b=true;
                }
                if(j>=i && j<=10-i && b)
                {
                    s = s + 'x';
                }
                else
                {
                    s = s + '_';   
                }
            }  
        system.debug(s);
        }
    }
    
    public void DowntriangleProgram2()
    {
        for(Integer i=1;i<6;i++)
        {
            String s = ' ';
            if(i==1)
            {
                for(Integer j=1;j<10;j++)
                {
                    s = s + '*';
                } 
            }
            else
            {
                for(Integer j=1;j<10;j++)
                {
                    if(i==j || j==(10-i))
                    {
                        s = s + '*';
                    }
                    else
                    {
                        s = s + '_';
                    }
                }
            }
        System.debug(s);
    	}
    }
}
