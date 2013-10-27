#include <Ethernet.h>
#include <SPI.h>
#include <ICMPPing.h>
#include <aJSON.h>

byte mac[] = { 0x90, 0xA2, 0xDA, 0x0E, 0xAF, 0x91 };
IPAddress ip(192,168,2,7);
IPAddress gateway(192,168,2,1);
IPAddress dnss(192,168,1,254);
// fire teh c@nn0ns
EthernetServer server(1337);

// get teh temp
double TempFromAnalogue(int RawADC) {
 double Temp;
 // fookin 4k7 m8
 Temp = log(((4812800/RawADC) - 4700));
 Temp = 1 / (0.001129148 + (0.000234125 + (0.0000000876741 * Temp * Temp ))* Temp );
 Temp = Temp - 273.15;
 return Temp;
}

// parsing GET location
char location[255];
int stringPos = 0;
boolean startedToRead = false;
boolean gotLocation = false;

// pinging teh sh1t
SOCKET pingSocket = 3;
char buffer[256];

//parsing TFL
EthernetClient tclient;
String constructedjson = "";
boolean reachedJSON = false;

//SMS & online
int SMSed = 0;

void setup()
{
  //fire teh laz0r
  Serial.begin(9600);
  Serial.println("firin' teh laz0r");
  pinMode(4,OUTPUT);
  digitalWrite(4,HIGH);
  delay(5000);
  //Ethernet shittttt
  if (Ethernet.begin(mac) == 0) {
    Serial.println("nein DHCP");
    while(true);
  }
  else {
    //fookin' hell!
    Serial.println("fucking hell we got an IP address!");
  }
  //Ethernet.begin(mac, ip, gateway, dnss);
  server.begin();
  printIpAddress();
}

void loop()
{
  EthernetClient client = server.available();
  if (client) {
    // who's on me rootkit????
    boolean blankLine = true;
    while (client.connected()) {
      // he's fookin' ready m8
      if (client.available()) {
        char c = client.read();
        if (!(gotLocation)) {
          if (c == '/' && !startedToRead) {
            startedToRead = true;
            return;
          }
          else if (startedToRead) {
            if (c != ' ') {
              location[stringPos] = c;

              stringPos++;
            }
            else {
              startedToRead = false;
              gotLocation = true;
            }
          }
        }
        // fookin' ready to reply?
        if (gotLocation) {
          // index of item in Table!
          char tableIndex = location[0];
          // move some shit and get rid of the integer and forwardslash
          memmove(&location[0] , &location[0+1], strlen(location) - 0);
          memmove(&location[0] , &location[0+1], strlen(location) - 0);
          
          char is_it_ip[3];
          strncpy(is_it_ip, location, 2);
          is_it_ip[2] = 0;
          // is it hot in here?
          if (strcmp(location, "temp") == 0) {   
            float temp = getTemperature();
            // start giving her the D
            client.println("HTTP/1.1 202 OK");
            client.println("Content-Type: application/json");
            client.println("Connection: close");
            client.println();
            client.print("{ \"data\": [ ");
            client.print(tableIndex);
            client.print(", \"");
            client.print(temp);
            client.print("\"");
            client.print("] }");
            memset(location,'\0',5);
            stringPos = 0;
            gotLocation = false;
            break;
          }
          else if (strcmp(is_it_ip, "ip") == 0) {
            // remove the shit from that bitch
            memmove(&location[0] , &location[0+1], strlen(location) - 0);
            memmove(&location[0] , &location[0+1], strlen(location) - 0);
            memmove(&location[0] , &location[0+1], strlen(location) - 0);
            
            // i fuckin love bytes
            boolean is_it_up =  eatTheBytes(location);
            // start giving her the D
            client.println("HTTP/1.1 200 OK");
            client.println("Content-Type: application/json");
            client.println("Connection: close");
            client.println();
            client.print("{ \"data\": [ ");
            client.print(tableIndex);
            client.print(", \"");
            client.print(is_it_up);
            client.print("\"");
            client.print("] }");
            memset(location,'\0',5);
            stringPos = 0;
            gotLocation = false;
            break;
          }
          else if (strcmp(location, "tfl/bikes") == 0) {
            //fooking TFL API at 2:28am
            int bikesAvailable = getTflBikes();
            
            // start giving her the D
            client.println("HTTP/1.1 200 OK");
            client.println("Content-Type: application/json");
            client.println("Connection: close");
            client.println();
            client.print("{ \"data\": [ ");
            client.print(tableIndex);
            client.print(", \"");
            client.print(bikesAvailable);
            client.print("\"");
            client.print("] }");
            memset(location,'\0',5);
            stringPos = 0;
            gotLocation = false;
            break;
          }
          else {
            client.println("HTTP/1.0 404 Not Found");
            client.println("Content-Type: application/json");
            client.println("Connection: close");
            client.println();
            client.println("{ \"data\": [ 0, \"Endpoint not found!\" ] }");
            memset(location,'\0',5);
            stringPos = 0;
            gotLocation = false;
            break;
          }
        }
      }
    }
    delay(1);
    client.stop();
  }
  checkOnlineServers();
}

void printIpAddress() {
  // fookin' ip instance int it m8?
  IPAddress ip = Ethernet.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);
}

float getTemperature() {
  // heat pinno
  int samples[100];
  uint8_t i;
  float average;
  for (i=0; i< 100; i++) {
   samples[i] = int(TempFromAnalogue(analogRead(0)));
   delay(10);
  }
  average = 0;
  for (i=0; i< 100; i++) {
     average += samples[i];
  }
  average /= 100;
  return average;
}

boolean eatTheBytes(char parsedIpAddr[]) {
  //start the chomping
  byte address[]={0,0,0,0};
  sscanf(parsedIpAddr, "%d.%d.%d.%d", &address[0], &address[1], &address[2], &address[3]);
  ICMPPing ping(pingSocket, 2);
  ICMPEchoReply echoReply = ping(address, 4);
  if (echoReply.status == SUCCESS) {
    // <3
    return true;
  }
  else {
    // FFS YOU PIECE OF SHIT WHY DID YOU FAIL....oh is the server down?
    return false;
  }
  return false;
}

void checkOnlineServers() {
  //fookin servers up m8?
  if (!(SMSed >= 5)) {
    if (!(eatTheBytes("78.110.163.98"))) {
      // do we win for "API creativity"?
      if (tclient.connect("api.clickatell.com", 80)) {
        tclient.println("GET http/sendmsg?user=HACKATHON26&password=fGqDeAm3w&api_id=3445633&to=447927268623&text=SERVER_ERR%20-%20Unable%20to%20reach%2078.110.163.98&msg_type=SMS_FLASH&FROM=SERVER_STATUS HTTP/1.1");
        tclient.println("HOST:api.clickatell.com");
        tclient.println();
        delay(200);
        tclient.stop();
        tclient.flush();
        SMSed++;
      }
    }
    if (!(eatTheBytes("198.144.189.139"))) {
      // FOOK SAKE WILL YOUR SERVER IS DOWN AGAIN
      if (tclient.connect("api.clickatell.com", 80)) {
        tclient.println("GET /http/sendmsg?user=HACKATHON26&password=fGqDeAm3w&api_id=3445633&to=447927268623&text=SERVER_ERR%20-%20Unable%20to%20reach%20198.144.189.139&msg_type=SMS_FLASH&FROM=SERVER_STATUS HTTP/1.1");
        tclient.println("HOST:api.clickatell.com");
        tclient.println();
        delay(200);
        tclient.stop();
        tclient.flush();
        SMSed++;
      }
    }
  }
}

int getTflBikes() {
  // Boris...MY MAN
  if (tclient.connect("definedcode.com", 1678)) {
    tclient.println("GET /502 HTTP/1.1");
    tclient.println("Host:definedcode.com");   
    tclient.println();
    while(tclient.connected() && !tclient.available()) delay(1); 
    while (tclient.available()) {
      char tc = tclient.read();
      constructedjson += tc;
      if(constructedjson.endsWith("\r\n")) {
        constructedjson="";
      }
    }
    tclient.stop();
    tclient.flush();
    char bikesAvailable[5];
    constructedjson.toCharArray(bikesAvailable, 5);
    return (int)atoi(bikesAvailable);
  }
}
