public with sharing class ReversedPyramidStarPattern
{
    public ReversedPyramidStarPattern()
    {
        for(Integer i=1;i<=5;i++)
        {
            String y='  '; 
            Boolean b=true;
            for(Integer j=1;j<=9;j++) 
            {
                if(j>=i && j<=10-i && b)
                {
                    y = y + 'x';
                    b=false;
                }
                else
                {
                    y = y + '_';
                    b=true;
                }
            }
            system.debug(y);
        }
    }
}
