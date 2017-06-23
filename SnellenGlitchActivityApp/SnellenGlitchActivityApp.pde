
SnellenChart chart;
int lineIndex;

String inputCharacters;
String outputCharacters;

String inputString;
String outputString;
String userString;

boolean isExamMode;
boolean isEndMode;

Encoder encoder;

void setup() {
    //size(1280, 800);
    //size(1200, 600);
    fullScreen(2);

    inputString = "a black cat went past us and then another that looked just like it";
    inputString = "lost in transmission";

    inputCharacters = "abcdefghijklmnopqrstuvwxyz";
    outputCharacters = "BCDEHKNOPRSUVZ";
    encoder = new Encoder(inputCharacters, outputCharacters);

    /*
    outputString = encoder.encode(inputString);
    println(outputString);
    println(encoder.decode(outputString));
    */

    userString = "";
    
    isExamMode = true;
    isEndMode = false;

    chart = new SnellenChart(87, 0.8, width/4, height * 0.1, width/2, height * 0.8);
    lineIndex = -1;
}

void draw() {
    background(255);
    
    if (isExamMode) {
        noFill();
        stroke(192);
        strokeWeight(2);
        rect(width/4, height * 0.1, width/2, height * 0.8);
        
        fill(0);
        noStroke();
        
        if (lineIndex >= 0) {
            chart.drawLine(g, lineIndex);
        } else {
            chart.draw(g);
        }
    } else if (isEndMode) {
        PFont font = chart.getFontAt(lineIndex);
        textFont(font);
        String displayString = encoder.decode(userString);
        text(displayString, width/2 - textWidth(displayString)/2, height/2);
    } else {
        PFont font = chart.getFontAt(lineIndex);
        textFont(font);
        String displayString = encoder.encode(inputString);
        text(displayString, width/2 - textWidth(displayString)/2, height/2);
    }
}

void keyReleased() {
    if (key == ' ' || key >= 'a' && key <= 'z') {
        letterKeyReleased(key);
    }
  
    switch (keyCode) {
      case DOWN:
        lineIndex++;
        break;
      case UP:
        lineIndex--;
        break;
    }
    switch (key) {
        case '!':
            println("EXAM MODE");
            isExamMode = !isExamMode;
            userString = "";
            break;
        case '@':
            println("END MODE");
            isEndMode = !isEndMode;
            break;
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            lineIndex = key - '1';
            break;
        case '0':
            lineIndex = 9;
            break;
    }
}

void letterKeyReleased(char key) {
    if (key == ' ') {
        println("space", key);
        userString += key;
    } else {
        String c = "" + key;
        c = c.toUpperCase();
        if (outputCharacters.indexOf(c) < 0) {
            println("not found", c);
            userString += outputCharacters.charAt(floor(random(outputCharacters.length())));
        } else {
            println("ok", c);
            userString += c;
        }
    }
    println(userString);
    println(encoder.decode(userString));
}