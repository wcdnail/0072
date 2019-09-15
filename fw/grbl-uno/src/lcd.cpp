#ifdef _USE_LCD
#include <LiquidCrystal_I2C.h>

enum LCD_Config_Int {
  LCD_I2C_ADDR = 0x20,
  LCD_BACKLIGHT_PIN = 3,
  LCD_En_pin = 2,
  LCD_Rw_pin = 1,
  LCD_Rs_pin = 0,
  LCD_D4_pin = 4,
  LCD_D5_pin = 5,
  LCD_D6_pin = 6,
  LCD_D7_pin = 7,  
};

static LiquidCrystal_I2C lcd(LCD_I2C_ADDR, LCD_En_pin, LCD_Rw_pin, LCD_Rs_pin, LCD_D4_pin, LCD_D5_pin, LCD_D6_pin, LCD_D7_pin, LCD_BACKLIGHT_PIN, POSITIVE);

extern "C" void init_lcd()
{
  lcd.begin(16, 2);
  lcd.backlight();
  lcd.clear();
  lcd.home();
  lcd.setCursor(0, 0);
  lcd.print("CNC SHIELD");
  lcd.setCursor(0, 1);
  lcd.print("123");
}
#endif // _USE_LCD
