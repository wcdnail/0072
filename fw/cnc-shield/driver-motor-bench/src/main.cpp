#include "BasicStepperDriver.h"
#include "lcd.h"

const char   AppTitle[] = "-= MOTO BENCH =-";
const char AppVersion[] = "-==== v1.0 ====-";

enum StepperMotorConsts {
  X_MOTOR = 0,
  Y_MOTOR,
  Z_MOTOR,
  MAX_MOTOR,
  STEPPER_ENABLE_PIN = 8,
  MOTOR_STEPS = 200,
  RPM = 25,
  MICROSTEPS = 16,
};

struct DriverConf
{
  short     dirPin;
  short    stepPin;
  short        RPM;
  short totalSteps;
};

static BasicStepperDriver *driver[MAX_MOTOR] = { 0 };
static DriverConf      driverConf[MAX_MOTOR] = {
  // X
  { /*     DIR pin */ 5,
    /*    STEP pin */ 2, 
    /*         RPM */ RPM, 
    /* Total steps */ 200, 
  },
  // Y
  { /*     DIR pin */ 6,
    /*    STEP pin */ 3, 
    /*         RPM */ RPM, 
    /* Total steps */ 200, 
  },
  // Z
  { /*     DIR pin */ 7,
    /*    STEP pin */ 4, 
    /*         RPM */ RPM, 
    /* Total steps */ 200, 
  },
};

void setup() 
{
  init_lcd();
  for (int8_t i=X_MOTOR; i<MAX_MOTOR; i++) {
    auto &cnf = driverConf[i];
    driver[i] = new BasicStepperDriver(cnf.totalSteps, cnf.dirPin, cnf.stepPin, STEPPER_ENABLE_PIN);
    driver[i]->begin(RPM, MICROSTEPS);
  }
  driver[X_MOTOR]->setEnableActiveState(LOW);
  driver[X_MOTOR]->enable();
}

void loop() 
{
  driver[X_MOTOR]->rotate(360);
  //delay(2000);
  //driver[X_MOTOR]->move(-MOTOR_STEPS*MICROSTEPS);
  //delay(2000);
}
