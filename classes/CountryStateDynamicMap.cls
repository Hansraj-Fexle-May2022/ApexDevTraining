public with sharing class CountryStateDynamicMap {
    Map<String, Map<String, List<String>>> mapCountryTillDistricts = new Map<String, Map<String, List<String>>>();
	public CountryStateDynamicMap(String keyword) {
        List<District__c> listOfDistrict =  [SELECT Name, State_Name__r.Name ,
                                             State_Name__r.Country_Name__r.Name FROM District__c];
        //System.debug(listOfDistrict);                   
        for(District__c dis : listOfDistrict) {
            if(!mapCountryTillDistricts.containsKey(dis.State_Name__r.Country_Name__r.Name)){
                mapCountryTillDistricts.put(dis.State_Name__r.Country_Name__r.Name, new Map<String,List<String>>());
            }
            Map<String,List<String>> MapOfState = mapCountryTillDistricts.get(dis.State_Name__r.Country_Name__r.Name);
            if(!MapOfState.containsKey(dis.State_Name__r.Name)){
                MapOfState.put(dis.State_Name__r.Name, new List<String>());
            }
            MapOfState.get(dis.State_Name__r.Name).add(dis.Name);
        }
        // System.debug(mapCountryTillDistricts.get('India'));
        //1.finding combination of Country, state and districts where it starts with 'A'
        System.debug('Comibinations of Countries, States and Districts which starts with A : ');
        for(String getCountry :  mapCountryTillDistricts.keyset()) {
            if(getCountry.startsWithIgnoreCase('A')) {
                System.debug('Country - '+getCountry);
                for(String getState : mapCountryTillDistricts.get(getCountry).keySet()) {
                    if(getState.startsWIthIgnoreCase('A')) {
                        System.debug('State - '+getState);
                        for(String getDistrict : mapCountryTillDistricts.get(getCountry).get(getState)) {
                            if(getDistrict.startsWIthIgnoreCase('A')) {
                                System.debug('District - '+getDistrict);
                            }
                        }
                    }  
                }
            }
        }
        // 2. Find such a District which length is more or equal to some number.
        System.debug('District which length is more or equal to 6 : ');
        for(String getCountry : mapCountryTillDistricts.keySet()) {
            for(String getState : mapCountryTillDistricts.get(getCountry).keySet()) {
                for(String getDistrict : mapCountryTillDistricts.get(getCountry).get(getState)) {
                    if(getDistrict.length() <= 6) {
                        System.debug('District : '+getDistrict);
                    }
                }
            }
        }
    }     
    //JSON  wrapper classes
    public List<Country> countryList{get; set;}
    public class Districts {
        public String districtName{get; set;}
    }        
    public class States{
        public string stateName{get; set;}
        public List<Districts> districts{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
    }
    Integer Stdata ;
    public class Country{
        public String countryName{get; set;}
        public List<States> states{get; set;}
        public Integer Total_Number_Of_States{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
    }
    //JSON DATA
    public void JSONOfCountry(String countryName) {
        Country wrapperOfCountry = new Country();
        wrapperOfCountry.countryName = countryName;
        wrapperOfCountry.states = new List<States>();        
        List<AggregateResult> listAggState = [Select COUNT(Name) Total_Number_Of_States from State__c 
                                              Where Country_Name__r.Name LIKE :countryName Group By 
					                          Country_Name__r.Name];  
        wrapperOfCountry.Total_Number_Of_States =  (Integer)listAggState[0].get('Total_Number_Of_States');
        List<AggregateResult> listAggDistrict = [Select COUNT(Name)Total_Number_Of_Districts from District__c
                                                 Where State_Name__r.Country_Name__r.Name LIKE :
                                                 countryName GROUP BY State_Name__r.Country_Name__r.Name] ;
        wrapperOfCountry.Total_Number_Of_Districts =  (Integer)listAggDistrict[0].get('Total_Number_Of_Districts');
        for(String stat :mapCountryTillDistricts.get(countryName).keyset()){
            States wrapperOfState = new States(); 
            wrapperOfState.stateName = stat;
            wrapperOfState.districts = new list<Districts>();
            List<AggregateResult> listAggDistrictWithState = [Select COUNT(Name) Total_Number_Of_Districts from 
	    						      District__c WHERE State_Name__r.Country_Name__r.Name LIKE:
                                                              countryName GROUP BY State_Name__r.Name];                
            wrapperOfState.Total_Number_Of_Districts = (Integer)listAggDistrictWithState[0].
	    					       get('Total_Number_Of_Districts');
            stdata =   wrapperOfState.Total_Number_Of_Districts ;
            for(String dist :mapCountryTillDistricts.get(countryName).get(stat)) {
                Districts wrapperOfDistrict = new Districts();
                wrapperOfDistrict.districtName = dist;    
                wrapperOfState.districts.add(wrapperOfDistrict);
            }
            wrapperOfCountry.states.add(wrapperOfState);
        }
        String stringOfJSON = JSON.serialize(wrapperOfCountry);
	    List<Country__c> countryData = [SELECT Id, Name, Country_JSON_Data__c, Total_Number_of_Districts__c,
                                    	    Total_Number_of_States__c FROM Country__c WHERE Name = :countryName ];
        if(!countryData.isEmpty()) {
            countryData[0].Country_Json_Data__c = stringOfJSON;
            countryData[0].Total_Number_of_States__c = wrapperOfCountry.Total_Number_Of_States;
            countryData[0].Total_Number_of_Districts__c = wrapperOfCountry.Total_Number_Of_Districts;
            update countryData;
        } 
        System.debug('JSON DATA :' +stringOfJSON);  
    }
}
