
class Encoder {
  private String _inputCharacters;
  private String _outputCharacters;
  private HashMap<String, String> _encodeMap;
  private HashMap<String, String> _decodeMap;
  private int _numDigits;

  Encoder(String inputCharacters, String outputCharacters) {
    _inputCharacters = inputCharacters;
    _outputCharacters = outputCharacters;
    _numDigits = calculateNumDigits(inputCharacters.length(), outputCharacters.length());

    initializeMaps();
  }

  private int calculateNumDigits(int numInputs, int numOutputs) {
    for (int i = 1; i < 1000; i++) {
      if (numInputs < pow(numOutputs, i)) {
        return i;
      }
    }
    println("Too many input character possibilities.");
    return -1;
  }

  private void initializeMaps() {
    _encodeMap = new HashMap<String, String>();
    _decodeMap = new HashMap<String, String>();
    
    String zeroOutputChar = "" + _outputCharacters.charAt(0);
    int radix = _outputCharacters.length();
    
    for (int i = 0; i < _inputCharacters.length(); i++) {
      String inputChar = "" + _inputCharacters.charAt(i);
      ArrayList<Integer> remainder = new ArrayList<Integer>();

      int index = i;
      int count = 0;
      String result = "";
      if (index == 0) {
        result = zeroOutputChar;
      }
      while ( index != 0 ) {
        remainder.add( count, index % radix != 0 ? index % radix : 0 );
        index /= radix;
        try {
          result += "" + _outputCharacters.charAt(remainder.get( count ));
        } 
        catch( NumberFormatException e ) {
          e.printStackTrace();
        }
      }
      result = new StringBuffer( result ).reverse().toString();
      while (result.length() < _numDigits) {
        result = zeroOutputChar + result;
      }

      _encodeMap.put(inputChar, result);
      _decodeMap.put(result, inputChar);
    }
  }

  String encode(String input) {
    String output = "";
    for (int i = 0; i < input.length(); i++) {
      char c = input.charAt(i);
      if (c == ' ') {
        output += c;
      } else {
        output += _encodeMap.get("" + c);
      }
    }
    return output;
  }

  String decode(String input) {
    String output = "";
    int i = 0;
    while (i < input.length()) {
      char c = input.charAt(i);
      if (c == ' ') {
        output += c;
        i++;
      } else if (i + _numDigits <= input.length()) {
        String inputChars = input.substring(i, i + _numDigits);
        String outputChar = _decodeMap.get(inputChars);
        if (outputChar == null) {
          outputChar = "" + _inputCharacters.charAt(floor(random(_inputCharacters.length())));
          _decodeMap.put(inputChars, outputChar);
        }
        output += outputChar;
        i += _numDigits;
      } else {
        println("Unexpected input. " + c);
        i++;
      }
    }
    return output;
  }
}