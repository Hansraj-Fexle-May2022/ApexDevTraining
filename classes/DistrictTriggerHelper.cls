/**
	Description 	:   This is the Helper class  for District__c object to populate
                        the  JSON as well as Count of districs and states.
	Created BY 	    :   HANS RAJ JANGID
	Created Date 	:   10-07-2022
	Revision Logs 	:   V_1.0 - Created
			            V_1.1 - Dev Name : HANS RAJ JANGID
			                    Date     : 17-08-2022
**/
public class DistrictTriggerHelper {
    public class Districts {
        public String districtName{get; set;}
    }
    
    public class States {
        public Integer Total_Number_Of_Districts{get; set;}
        public String stateName{get; set;}   
        public List<Districts> districts{get; set;}
    }

    public static void districtCountOnState(List<District__c> newDistrictList, Map <id,District__c> oldDistrictMap) {
        List<Integer> countDistrictCountry = new List<Integer>();
        List<Integer> listcountStateDistrict = new List<Integer>();
        States wrapperOfState;
        Districts wrapperOfDistrict;
        //new sets for storing the State id
        Set<Id> setStateId = new Set<Id>();
        //new sets for storing the Country id
        Set<Id> setCountryId = new Set<Id>();
        //new list for adding total disticts in state & country
        List<State__c> totalDistrictsInState = new List<State__c>();
        List<Country__c> totalDistrictsInCountry = new List<Country__c>();
        List<State__c> listState = new List<State__c>();
        List<Country__c> listCountry = new List<Country__c>();
         //for update,delete and insert case
         for( District__c newDistrict : (newDistrictList != null ? newDistrictList : oldDistrictMap.values())){
            if(newDistrictList == null ||oldDistrictMap == null || oldDistrictMap.get(newDistrict.Id).State_Name__c 
               != newDistrict.State_Name__c ){
                setStateId.add(newDistrict.State_Name__c);
                if(oldDistrictMap != null && oldDistrictMap.get(newDistrict.Id).State_Name__c 
		   != newDistrict.State_Name__c  ){
                    setStateId.add(oldDistrictMap.get(newDistrict.Id).State_Name__c);
                }  
            }
        } 
        //Aggrigating Count of District  
        List<AggregateResult> listAggDistrictState = [SELECT COUNT(id) countId ,State_Name__c sid FROM District__c WHERE
                                                      State_Name__c =: setStateId GROUP BY State_Name__c];
        List<AggregateResult> listAggDistrictCountry = [SELECT COUNT(id) ctid ,Country__c Conid FROM District__c  WHERE
                                                        Country__c =: setCountryId GROUP BY Country__c];
        if(listAggDistrictState.size()>0){
            for(AggregateResult ar :listAggDistrictState){
                Id stateId = (Id)ar.get('sid');
                Integer countDistrict = (Integer)ar.get('countId');

                State__c st = new State__c(Id = stateId);
                st.Total_Number_of_Districts__c = countDistrict;
                listState.add(st);
            }
        }
        system.debug('listState' + listState);
        if(listAggDistrictCountry.size()>0){
            for(AggregateResult ar :listAggDistrictCountry){
                Id countryId = (Id)ar.get('Conid');
                Integer countDistrictOfCountry = (Integer)ar.get('ctid');
                Country__c con = new Country__c(Id = countryId);
                con.Total_Number_of_Districts__c = countDistrictOfCountry;
                listCountry.add(con);
            }
        }
        //JSON
        for(AggregateResult agr : listAggDistrictState) {
            listcountStateDistrict.add((Integer)agr.get('countId'));
        }
        Integer a = 0;
        List<District__c> disList = [SELECT Id, Name FROM District__c WHERE State_Name__c IN :setStateId];
        System.debug('disList : ' + disList);
        for(State__c state : [SELECT Id, Name, Total_Number_of_Districts__c FROM State__c WHERE 
                              Id IN :setStateId]) {
            state.Total_Number_of_Districts__c = listcountStateDistrict[a];
            a=a+1 ; 
            wrapperOfState = new States();
            wrapperOfState.stateName = state.Name;
            wrapperOfState.districts = new List<Districts>();
            for(District__c district : disList) {
                wrapperOfDistrict = new Districts();
                wrapperOfDistrict.districtName = district.Name;
                wrapperOfState.districts.add(wrapperOfDistrict);
            }
            wrapperOfState.Total_Number_of_Districts = (Integer)state.Total_Number_of_Districts__c;
            String stateJSONData = JSON.serialize(wrapperOfState);
            state.State_JSON_Data__c = stateJSONData;
            listState.add(state);
        }
        system.debug('listState' + listState);
        if(listState.size()>0){
            update listState;
        }
        if(listCountry.size() != null) {
            Update listCountry;
        }
    }
}
