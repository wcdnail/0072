# Marlin 2.0.x 

### Версия марлин - 2.0.x bugfix, взята 03.10.2019

Собирать лучше всего с помощью Visual Studio Code + PlatformIO<br/>
[Инструкция по установке Visual Studio Code + PlatformIO](https://docs.platformio.org/en/latest/ide/vscode.html)<br/>

### Прошивка SapphirePro:
* Скопировать файл `.pio\build\mks_robin_nano\Robin_nano.bin` на sd карту
* Установить sd карту в принтер
* Включить/перезагрузить принтер

### Конфигурация прошивки
  Конфигурация|Файл|Строка
  ------------|----|------
  PID|`Marlin\Configuration.h`|483
  Шаг и ускорение|`Marlin\Configuration.h`|730
  Размер стола|`Marlin\Configuration.h`|1070
  M73 прогресс|`Marlin\Configuration_adv.h`|888
  Отображение статуса|`Marlin\Configuration_adv.h`|1143
  Linear Advanced|`Marlin\Configuration_adv.h`|1329
  Расширенная пауза|`Marlin\Configuration_adv.h`|1639

### Графика
[Конвертер графики](http://marlinfw.org/tools/u8glib/converter.html)<br/>
`Marlin\_Bootscreen.h` - `Marlin\Configuration.h:91 #define SHOW_CUSTOM_BOOTSCREEN`<br/>
`Marlin\_Statusscreen.h` - `Marlin\Configuration.h:94 #define CUSTOM_STATUS_SCREEN_IMAGE`<br/>
Так же для модификации смотрите директорию `pixmaps`<br/>

# Железо SapphirePro

Дисплей - MKS TFT35 (3.5" (~9см)) 480*320<br/>

# Стоковые прошивки
`..\sapphire-pro-marlin-stock`
