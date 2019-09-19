#include <LiquidCrystal_I2C.h>
#include <ClickEncoder.h>

enum LCD_Config {
  LCD_I2C_ADDR = 0x20,
  LCD_BACKLIGHT_PIN = 3,
  LCD_En_pin = 2,
  LCD_Rw_pin = 1,
  LCD_Rs_pin = 0,
  LCD_D4_pin = 4,
  LCD_D5_pin = 5,
  LCD_D6_pin = 6,
  LCD_D7_pin = 7,
  ENC_PIN1 = A0,
  ENC_PIN2 = A1,
  ENC_BPIN = A2,
};

static LiquidCrystal_I2C lcd(LCD_I2C_ADDR, LCD_En_pin, LCD_Rw_pin, LCD_Rs_pin, LCD_D4_pin, LCD_D5_pin, LCD_D6_pin, LCD_D7_pin, LCD_BACKLIGHT_PIN, POSITIVE);
static ClickEncoder      enc(ENC_PIN1, ENC_PIN2, ENC_BPIN);

extern const char   AppTitle[];
extern const char AppVersion[];

extern "C" 
{
    void init_lcd()
    {
        lcd.begin(16, 2);
        lcd.backlight();
        lcd.clear();
        lcd.home();
        lcd.setCursor(0, 0);
        lcd.print(AppTitle);
        lcd.setCursor(0, 1);
        lcd.print(AppVersion);
    }

#if _EXTRA_DEBUG
    static void search_i2c_address() 
    {
        Serial.begin (115200);
        Serial.println ();
        Serial.println ("I2C scanner. Scanning ...");
        byte count = 0;
        Wire.begin();
        for (byte i = 1; i < 120; i++) {
            Wire.beginTransmission (i);
            if (Wire.endTransmission () == 0) {
            Serial.print ("Found address: ");
            Serial.print (i, DEC);
            Serial.print (" (0x");
            Serial.print (i, HEX);
            Serial.println (")");
            count++;
            delay(1);
            }
        }
        Serial.println ("Done.");
        Serial.print ("Found ");
        Serial.print (count, DEC);
        Serial.println (" device(s).");
    }
#endif // _EXTRA_DEBUG
}
