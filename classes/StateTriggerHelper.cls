/**
	Description 	:   This is the Helper class  for State__c object to populate
                        the  JSON as well as Count of districs .
	Created BY 	    :   HANS RAJ JANGID
	Created Date 	:   10-07-2022
	Revision Logs 	:   V_1.0 - Created
			            V_1.1 - Dev Name : HANS RAJ JANGID
			                    Date     : 17-08-2022
**/
public with sharing class StateTriggerHelper {
    public class States {
        public Integer Total_Number_Of_Districts{get; set;}
        public string stateName{get; set;}
    }

    public class Country {
        public Integer Total_Number_Of_States{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
        public String countryName{get; set;}
        public List<States> states{get; set;}
    }

    public static void StateCountOnCountry(List<State__c> newStateList, Map<Id,State__c> oldStateMap) {
        Country wrapperOfCountry;
        States wrapperOfState;
        List<Country__c> totalStateInCountry = new List<Country__c>();
        Set<id> setCountryId = new Set<id>();
        List<Integer> lisCountCountryState = new List<Integer>();

        List<Country__c> listCountry = new List<Country__c>();
        //for update,delete and insert case
        for( State__c newState : (newStateList != null ? newStateList : oldStateMap.values())){
            if(newStateList == null ||oldStateMap == null || oldStateMap.get(newState.Id).Country_Name__c 
            != newState.Country_Name__c ){
                setCountryId.add(newState.Country_Name__c);
                if(oldStateMap != null && oldStateMap.get(newState.Id).Country_Name__c != newState.Country_Name__c  ){
                    setCountryId.add(oldStateMap.get(newState.Id).Country_Name__c);
                } 
            }
        } 
        List<AggregateResult> listAggStateCountry = [SELECT COUNT(id) ctid ,Country_Name__c Conid FROM State__c  WHERE
                                                     Country_Name__c =: setCountryId GROUP BY Country_Name__c];
        if(listAggStateCountry.size()>0){
            for(AggregateResult ar :listAggStateCountry){
                Id countryId = (Id)ar.get('Conid');
                Integer countState = (Integer)ar.get('ctid');
                Country__c con = new Country__c(Id = countryId);
                con.Total_Number_of_States__c = countState;
                listCountry.add(con);
            }
        }
        //Json population on country
        for(AggregateResult agr : listAggStateCountry) {
            lisCountCountryState.add((Integer)agr.get('ctid'));
        }
		List<State__c> stateList=  [SELECT Id, Name, Total_Number_of_Districts__c FROM State__c WHERE 
                                    Country_Name__c In :setCountryId];
        Integer a = 0;
        for(Country__c country : [SELECT Id, Name, Total_Number_of_States__c, Total_Number_of_Districts__c
                                  FROM Country__c WHERE Id In :setCountryId]) {
            country.Total_Number_of_States__c = lisCountCountryState[a];
            a=a+1 ; 
            wrapperOfCountry = new Country();
            wrapperOfCountry.countryName = country.Name;
            wrapperOfCountry.states = new List<states>();
            wrapperOfCountry.Total_Number_Of_States = (Integer)country.Total_Number_of_States__c;
            wrapperOfCountry.Total_Number_Of_Districts = (Integer)country.Total_Number_of_Districts__c;
            for(State__c state :stateList) {
                wrapperOfState = new States();
                wrapperOfState.stateName = state.Name;
                wrapperOfState.Total_Number_Of_Districts = (Integer)state.Total_Number_of_Districts__c;
                wrapperOfCountry.states.add(wrapperOfState);
            }
            String jsonCountryData = JSON.serialize(wrapperOfCountry);
            System.debug('Country JSON: ' + jsonCountryData);
            country.Country_JSON_Data__c = jsonCountryData;
            listCountry.add(country);
        }
        if(listCountry.size()>0){
            update listCountry;
        }
    }
}