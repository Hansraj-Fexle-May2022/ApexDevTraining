public with sharing class AlphabetAPatternProgram {
    public AlphabetAPatternProgram(){
        integer p=2,q=2;
        boolean m = true;
        for(integer i=1;i<=6;i++)
        {
        string s='  ';
            if(i==2){p--; q++;}
            for(integer j=1;j<=3;j++)
            {
                if((i==2||i>=4) && j==2)
               	{ 
                    m=false;
                }
                else
        		{ 
                    m=true;
                }
                if(j>=p && j<=q && m )
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