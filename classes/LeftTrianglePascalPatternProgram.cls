public with sharing class LeftTrianglePascalPatternProgram 
{
    public LeftTrianglePascalPatternProgram(Integer n) 
    {
        Integer var =n;
        String p = ' ';
        for(Integer i=1; i<n+1; i++)
        {
          	for(Integer j=i;j<n;j++)
            {
                p = p +'_';
            }             
            for(Integer k=1;k<i+1;k++)
            {
                p = p + '*';
            }
        }
       	System.debug('');
        for(Integer i=n;i>0;i--)
        {
          	for(Integer j=i;j<n+1;j++)
            {
                p = p +'_';
            }         
            for(Integer k=1;k<i;k++)
            {
                p = p + '*';
            }
        }
        System.debug(p);
    }
}
