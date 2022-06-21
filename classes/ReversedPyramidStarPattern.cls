public with sharing class ReversedPyramidStarPattern{
    public ReversedPyramidStarPattern(){
        for(integer i=1;i<=5;i++){
        string s='  '; 
        boolean k=true;
            for(integer j=1;j<=9;j++) {
                if(j>=i && j<=10-i && k){
                    s = s + 'x';
                    k=false;
                }
                else{
                    s = s + '_';
                    k=true;
                }
            }
            system.debug(s);
        }
    }
}