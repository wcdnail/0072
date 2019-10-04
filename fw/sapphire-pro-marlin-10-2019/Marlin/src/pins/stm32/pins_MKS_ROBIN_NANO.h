/**
 * Marlin 3D Printer Firmware
 * Copyright (c) 2019 MarlinFirmware [https://github.com/MarlinFirmware/Marlin]
 *
 * Based on Sprinter and grbl.
 * Copyright (c) 2011 Camiel Gubbels / Erik van der Zalm
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
#pragma once

/**
 * MKS Robin nano (STM32F130VET6) board pin assignments
 */

#ifndef __STM32F1__
  #error "Oops! Select an STM32F1 board in 'Tools > Board.'"
#elif HOTENDS > 2 || E_STEPPERS > 2
  #error "MKS Robin nano supports up to 2 hotends / E-steppers. Comment out this line to continue."
#endif

#define BOARD_INFO_NAME "MKS Robin Nano"

//
// Release PB4 (Y_ENABLE_PIN) from JTAG NRST role
//
#define DISABLE_DEBUG

//
// Note: MKS Robin board is using SPI2 interface.
//
#define SPI_MODULE 2

//
// PWM
//
//#define NUM_SERVOS        1

// Z- as servo, Z+ as Z- (may need to remove the C35 filter cap and short R45 resistor)
//#define SERVO0_PIN        PA11   // Pulled up PWM pin (3.3V or 0)may need to remove the C35 filter cap and short R45 resistor. 
//#define SERVO0_TIMER_NUM  1      // General or Adv. timer to use for the servo PWM.

// E1 STEP pin as servo, Z- as Z-
#define SERVO0_PIN        PA6    // E1 STP PA6 TIM(8,3,1?), E1 DIR PA1 TIM(2,5), E1 EN PA3 TIM(2,5) (TIM2,5 might be reserved)
//#define SERVO0_TIMER_NUM  3      // These pins are not 5v tolerant. Add 4.7k-10k pullup to 3.3v

//
// Limit Switches
//
#define X_STOP_PIN        PA15
#define Y_STOP_PIN        PA12
#define Z_MIN_PIN         PA11
#define Z_MAX_PIN         -1 // PC4

#ifndef FIL_RUNOUT_PIN
  #define FIL_RUNOUT_PIN   PA4   // MT_DET
#endif

//
// Steppers
//
#define X_ENABLE_PIN       PE4
#define X_STEP_PIN         PE3
#define X_DIR_PIN          PE2

#define Y_ENABLE_PIN       PE1
#define Y_STEP_PIN         PE0
#define Y_DIR_PIN          PB9

#define Z_ENABLE_PIN       PB8
#define Z_STEP_PIN         PB5
#define Z_DIR_PIN          PB4

#define E0_ENABLE_PIN      PB3
#define E0_STEP_PIN        PD6
#define E0_DIR_PIN         PD3

#define E1_ENABLE_PIN      PA3
#define E1_STEP_PIN        PA6
#define E1_DIR_PIN         PA1

//
// Temperature Sensors
//
#define TEMP_0_PIN         PC1   // TH1
#define TEMP_1_PIN         PC2   // TH2
#define TEMP_BED_PIN       PC0   // TB1

//
// Heaters / Fans
//
#define HEATER_0_PIN       PC3   // HEATER1
#if HOTENDS == 1
  #define FAN1_PIN         PB0
#else
  #define HEATER_1_PIN     PB0
#endif
#define HEATER_BED_PIN     PA0   // HOT BED

#define FAN_PIN            PB1   // FAN

//
// Thermocouples
//
//#define MAX6675_SS_PIN     PE5  // TC1 - CS1
//#define MAX6675_SS_PIN     PE6  // TC2 - CS2

//
// Misc. Functions
//
#define POWER_LOSS_PIN     PA2   // PW_DET
#define PS_ON_PIN          PA3   // PW_OFF

#define LED_PIN            PB2

//
// LCD / Controller
//
#define BEEPER_PIN         PC5
//
// Use the on-board card socket labeled TF_CARD_SOCKET
//
#define SS_PIN           PC11
#define SCK_PIN          PC12
#define MOSI_PIN         PD2
#define MISO_PIN         PC8
#define SD_DETECT_PIN    PD12
#define SDSS             SS_PIN
#define SDIO_SUPPORT

/**
 * Note: MKS Robin TFT screens use various TFT controllers.
 * If the screen stays white, disable 'LCD_RESET_PIN'
 * to let the bootloader init the screen.
 */
#if ENABLED(FSMC_GRAPHICAL_TFT)
  //#define FSMC_CS_PIN        PD7    // NE4
  //#define FSMC_RS_PIN        PD11   // A0

  //#define LCD_RESET_PIN      PC6
  #define NO_LCD_REINIT             // Suppress LCD re-initialization

  #define LCD_BACKLIGHT_PIN  PD13

  #if ENABLED(TOUCH_BUTTONS)
	#define BTN_ENC          PC13   // Not connected. TODO: Replace this hack to enable button code
    #define FSMC_CS_PIN      PD7    // NE4
    #define FSMC_RS_PIN      PD11   // A0
    #define TOUCH_CS_PIN     PA7
    #define TOUCH_SCK_PIN    PB13   // pin 52
    #define TOUCH_MOSI_PIN   PB15   //PB14  // pin 53
    #define TOUCH_MISO_PIN   PB14   //PB15  // pin 54
    //#define TOUCH_INT_PIN  PC6   // pin 63 (PenIRQ coming from ADS7843)

    #define LCD_USE_DMA_FSMC   // Use DMA transfers to send data to the TFT
    #define FSMC_DMA_DEV     DMA2
    #define FSMC_DMA_CHANNEL DMA_CH5
    #define BTN_EN1          -1    // Real pin is needed to enable encoder's push button
    #define BTN_EN2          -1    // functionality used by touch screen

    #define DOGLCD_MOSI      -1  // Prevent auto-define by Conditionals_post.h
    #define DOGLCD_SCK       -1
  #endif
#endif
