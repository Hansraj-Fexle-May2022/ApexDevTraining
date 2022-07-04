public with sharing class RightPascalTriangle
{
    public RightPascalTriangle()
    {
        integer k=0;
        for(Integer i=1;i<=10;i++)
        {
            if(i<=5)
            {
                k++;
            } 
            else
            { 
                k--;
            }
            String s='  ';
            for(Integer j=1;j<=5;j++)
            {
                if(j<=k)
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
}
