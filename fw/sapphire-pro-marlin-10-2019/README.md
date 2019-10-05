# Marlin 2.0.x 

### Версия марлин - 2.0.x bugfix, взята 03.10.2019
![sapphire-pro-0-marlin-boot](docs/hints/sapphire-pro-0-marlin-boot1.jpg?raw=true)
![sapphire-pro-0-marlin-status](docs/hints/sapphire-pro-2-marlin-status1.jpg?raw=true)

Собирать лучше всего с помощью Visual Studio Code + PlatformIO<br/>
[Инструкция по установке Visual Studio Code + PlatformIO](https://docs.platformio.org/en/latest/ide/vscode.html)<br/>

### Прошивка SapphirePro:
* После успешной сборки скопировать файл `.pio\build\mks_robin_nano\Robin_nano.bin` на sd карту
* Установить sd карту в принтер
* Включить/перезагрузить принтер
* Дождаться обновления

### Конфигурация прошивки
  Конфигурация|Файл|Строка
  ------------|----|------
  PID|Marlin\Configuration.h|483
  Шаг и ускорение|Marlin\Configuration.h|730
  Размер стола|Marlin\Configuration.h|1070
  Home offsets|Marlin\Configuration.h|1322
  M73 прогресс|Marlin\Configuration_adv.h|888
  Отображение статуса|Marlin\Configuration_adv.h|1143
  Linear Advanced|Marlin\Configuration_adv.h|1329
  Расширенная пауза|Marlin\Configuration_adv.h|1639

### Графика
[Конвертер графики](http://marlinfw.org/tools/u8glib/converter.html)<br/>
`Marlin\_Bootscreen.h` - `Marlin\Configuration.h:91 #define SHOW_CUSTOM_BOOTSCREEN`<br/>
`Marlin\_Statusscreen.h` - `Marlin\Configuration.h:94 #define CUSTOM_STATUS_SCREEN_IMAGE`<br/>
Так же для модификации смотрите директорию `pixmaps`<br/>

### Тюнинг PID
Нагреватель: `M303 E0 S200 C8`<br/>
Стол: `M303 E-1 C8 S90`<br/>

### Настройки ПО/слайсеров
  Конфигурация|Значение|Примечание
  ------------|----|------
  Скорость соединения с принтером|115200 бод|
  Размер стола|220х220 мм|Ни каких дополнительных смещений настраивать не надо
  Ретракт|8 мм|В заводских настройках указан 9мм
  Скорость ретракта|8 мм|

#### Пример настройки Repetier-Host
![sapphire-pro-bed-size-repetier](docs/hints/sapphire-pro-bed-size-repetier.png?raw=true "Размер стола в Repetier-Host")

# Железо SapphirePro

Дисплей - MKS TFT35 (3.5" (~9см)) 480*320<br/>

# Стоковые прошивки
`..\sapphire-pro-marlin-stock`
