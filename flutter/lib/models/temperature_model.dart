class TemperatureModel {
  final Map<String, int> temps = {
    'hot': 1,
    'neutral': 0,
    'cold': -1
  };

  final Map<String, int> foodTemps = {
    'banana': 0, 
    'avocado': 0, 
    'water': -1, 
    'chicken': 1
  };

  get tempMappings => temps;

  get foodTempMappings => foodTemps;

  int checkOrderTemp(List<Object?> order) {
    for (Object? o in order) {
      
    }
  }




}