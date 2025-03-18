# Mastering STM32
### *by Carmine Noviello*

### Notes

#### Cortex subfamilies

- Cortex-A: **A**pplication - Linux, Android.

- Cortex-M: e**M**bedded.

- Cortex-R: **R**eal-Time - high performance, fault tolerance.

#### Bitband

```
// Define base address of bit-band
#define BITBAND_SRAM_BASE 0x20000000
// Define base address of alias band
#define ALIAS_SRAM_BASE 0x22000000
// Convert SRAM address to alias region
#define BITBAND_SRAM(a,b) ((ALIAS_SRAM_BASE + ((uint32_t)&(a)-BITBAND_SRAM_BASE)*32 + (b*4\
)))
// Define base address of peripheral bit-band
#define BITBAND_PERI_BASE 0x40000000
// Define base address of peripheral alias band
#define ALIAS_PERI_BASE 0x42000000
// Convert PERI address to alias region
#define BITBAND_PERI(a,b) ((ALIAS_PERI_BASE + ((uint32_t)a-BITBAND_PERI_BASE)*32 + (b*4)))

```
```
 #define GPIOA_PERH_ADDR 0x40020000
 #define ODR_ADDR_OFF
 0x14
 uint32_t *GPIOA_ODR = GPIOA_PERH_ADDR + ODR_ADDR_OFF;
 uint32_t *GPIOA_PIN5 = BITBAND_PERI(GPIOA_ODR, 5);
 *GPIOA_PIN5 = 0x1; // Turns GPIO HIGH

```

#### Exceptions and Interrupts

```
Number      Exception type     Priority      Function


1           Reset              -3            Reset
2           NMI                -2            Non-Maskable Interrupt
3           Hard Fault         -1            All classes of Fault, when the fault cannot activate
                                             because of priority or the Configurable Fault handler
                                             has been disabled.
4           Memory Management  Configurable  MPU mismatch, including access violation and no
                                             match. This is used even if the MPU is disabled
                                             or not present.
5           Bus Fault          Configurable  Pre-fetch fault, memory access fault, and other
                                             address/memory related faults.
6           Usage Fault        Configurable  Usage fault, such as Undefined instruction executed
                                             or illegal state transition attempt.
7-10        -                  -             RESERVED
11          SVCall             Configurable  System service call with SVC instruction.
12          Debug Monitor      Configurable  Debug monitor for software based debug.
13          -                  -             RESERVED
14          PendSV             Configurable  Pending request for system service.
15          SysTick            Configurable  System tick timer has fired.
16-[47/240] IRQ                Configurable  IRQ input
```
- Interrupt table: `startup/startup_stm32f103xb.s`

- Interrupt numbers: `Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f103xb.h`

#### STM32CubeMX

##### Chip view, pin colors

- *Green*: pin enabled (code to be generated).

- *Yellow*: pin is not configurable (power).

- *Orange*: the corresponding peripheral is not enabled (code for the pin, but not for the peripheral).

- *Khaki*: BOOT and RESET; not configurable.

- *Blue*: Possible alternatives, shown by Ctrl-click.

##### Generated Application Code

- `Inc/stm32f1xx_hal_conf.h`

- `Src/stm32f1xx_it.c` Generated ISRs; there is place for the user code.

- `startup/startup_stm32f103xb.s`
```
...
g_pfnVectors:

  .word _estack
  .word Reset_Handler
  .word NMI_Handler
  .word HardFault_Handler
...
  .word SysTick_Handler
...
```
- `Src/stm32f1xx_hal_msp.c` Setting ISRs; user code. IP settings according to user configuration.

#### GPIO

```
Available GPIO_InitTypeDef.Mode for a GPIO

Pin Mode                        Description

GPIO_MODE_INPUT                 Input Floating Mode
GPIO_MODE_OUTPUT_PP             Output Push Pull Mode
GPIO_MODE_OUTPUT_OD             Output Open Drain Mode
GPIO_MODE_AF_PP                 Alternate Function Push Pull Mode
GPIO_MODE_AF_OD                 Alternate Function Open Drain Mode
GPIO_MODE_ANALOG                Analog Mode
GPIO_MODE_IT_RISING             External Interrupt Mode with Rising edge trigger detection
GPIO_MODE_IT_FALLING            External Interrupt Mode with Falling edge trigger detection
GPIO_MODE_IT_RISING_FALLING     External Interrupt Mode with Rising/Falling edge trigger detection
GPIO_MODE_EVT_RISING            External Event Mode with Rising edge trigger detection
GPIO_MODE_EVT_FALLING           External Event Mode with Falling edge trigger detection
GPIO_MODE_EVT_RISING_FALLING    External Event Mode with Rising/Falling edge trigger detection

Available GPIO_InitTypeDef.Pull modes for a GPIO

GPIO_NOPULL                     No Pull-up or Pull-down activation
GPIO_PULLUP                     Pull-up activation
GPIO_PULLDOWN                   Pull-down activation
```

#### Interrupts management

#### Timers

- Timers are asynchronous peripherals.

- A timer has 4 output channels and 4 CCR registers: CCR1, CCR2, CCR3, CCR4. The four channels share the timer counter and the ARR. Timer Output *Low* `if` counter < CCR `else` *High*; high-true mode (mode 2).
```
Mode                       Counter < CCR     Counter >= CCR

PWM mode 1 (Low  True)     Active            Inactive
PWM mode 2 (High True)     Inactive          Active
```
- Output polarity: program CCxP bit in the TIMx_CCER register
```
                    Active               Inactive

Active High         High Voltage         Low Voltage
Active Low          Low Voltage          High Voltage
```

##### ARR Update

- Synchronous, ARPE == 1; ARR updated on UEV event.

- Asynchronous, ARPE == 0; ARR updated immediately.

##### Interrupt

```
HAL_TIM_Base_Start()
```

##### Polling

```
HAL_TIM_Base_Start_IT()
```

##### DMA

```
HAL_TIM_Base_Start_DMA()
```
- DMA Requests
```
DMA requests (most of them are available only in general purpose and advanced timers)

Timer DMA request      Description

TIM_DMA_UPDATE         Update request (it is generated on the UEV event)
TIM_DMA_CC1            Capture/Compare 1 DMA request
TIM_DMA_CC2            Capture/Compare 2 DMA request
TIM_DMA_CC3            Capture/Compare 3 DMA request
TIM_DMA_CC4            Capture/Compare 4 DMA request
TIM_DMA_COM            Commutation request
TIM_DMA_TRIGGER        Trigger request
```

#### I2C

```
typedef struct {
I2C_TypeDef                *Instance;  /* I2C registers base address     */
I2C_InitTypeDef            Init;       /* I2C communication parameters   */
uint8_t                    *pBuffPtr;  /* Pointer to I2C transfer buffer */
uint16_t                   XferSize;   /* I2C transfer size              */
__IO uint16_t              XferCount;  /* I2C transfer counter           */
DMA_HandleTypeDef          *hdmatx;    /* I2C Tx DMA handle parameters   */
DMA_HandleTypeDef          *hdmarx;    /* I2C Rx DMA handle parameters   */
HAL_LockTypeDef            Lock;       /* I2C locking object             */
__IO HAL_I2C_StateTypeDef  State;      /* I2C communication state        */
__IO HAL_I2C_ModeTypeDef   Mode;       /* I2C communication mode         */
__IO uint32_t              ErrorCode;  /* I2C Error code                 */
} I2C_HandleTypeDef;

```
```
typedef struct {
uint32_t ClockSpeed;       /* Specifies the clock frequency */
uint32_t DutyCycle;        /* Specifies the I2C fast mode duty cycle. */
uint32_t OwnAddress1;      /* Specifies the first device own address. */
uint32_t OwnAddress2;      /* Specifies the second device own address if dual addressing mode is selected */
uint32_t AddressingMode;   /* Specifies if 7-bit or 10-bit addressing mode is selected. */
uint32_t DualAddressMode;  /* Specifies if dual addressing mode is selected. */
uint32_t GeneralCallMode;  /* Specifies if general call mode is selected. */
uint32_t NoStretchMode;    /* Specifies if nostretch mode is selected. */
} I2C_InitTypeDef;

```
`stm32f1xx_hal_def.h`:
```
typedef enum
{
  HAL_OK       = 0x00U,
  HAL_ERROR    = 0x01U,
  HAL_BUSY     = 0x02U,
  HAL_TIMEOUT  = 0x03U
} HAL_StatusTypeDef;

typedef enum
{
  HAL_UNLOCKED = 0x00U,
  HAL_LOCKED   = 0x01U
} HAL_LockTypeDef;
```
```
HAL_StatusTypeDef HAL_I2C_Init(I2C_HandleTypeDef *hi2c);
```
```
HAL_StatusTypeDef HAL_I2C_Master_Transmit(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout);
```
```
HAL_StatusTypeDef HAL_I2C_Master_Receive(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout);

```
```
HAL_StatusTypeDef HAL_I2C_Master_Transmit_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);

HAL_StatusTypeDef HAL_I2C_Master_Receive_IT(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);
```
```
Table 3: CubeHAL available callbacks when an I2C peripheral works in interrupt or DMA mode

Callback                        Calling ISR           Description


HAL_I2C_MasterTxCpltCallback()  I2Cx_EV_IRQHandler()  Signals that the transfer from master to
                                                      slave is completed (peripheral working in
                                                      master mode).

HAL_I2C_MasterRxCpltCallback()  I2Cx_EV_IRQHandler()  Signals that the transfer from slave to
                                                      master is completed (peripheral working
                                                      in master mode).

HAL_I2C_SlaveTxCpltCallback()   I2Cx_EV_IRQHandler()  Signals that the transfer from slave to
                                                      master is completed (peripheral working
                                                      in slave mode).

HAL_I2C_SlaveRxCpltCallback()   I2Cx_EV_IRQHandler()  Signals that the transfer from master to
                                                      slave is completed (peripheral working in
                                                      slave mode).

HAL_I2C_MemTxCpltCallback()     I2Cx_EV_IRQHandler()  Signals that the transfer from master to
                                                      an external memory is completed (this is
                                                      called only when HAL_I2C_Mem_xxx()
                                                      routines are used and the peripheral
                                                      works in master mode).

HAL_I2C_MemRxCpltCallback()     I2Cx_EV_IRQHandler()  Signals that the transfer from an external
                                                      memory to the master is completed (this
                                                      is called only when HAL_I2C_Mem_xxx()
                                                      routines are used and the peripheral
                                                      works in master mode).

HAL_I2C_AddrCallback()          I2Cx_EV_IRQHandler()  Signals that the master has placed the
                                                      peripheral slave address on the bus
                                                      (peripheral working in slave mode).

HAL_I2C_ListenCpltCallback()    I2Cx_EV_IRQHandler()  Signals that the listen mode is completed
                                                      (this happens when a STOP condition is
                                                      issued and the peripheral works in slave
                                                      mode - more about this later).

HAL_I2C_ErrorCallback()         I2Cx_ER_IRQHandler()  Signals that an error condition is
                                                      occurred (peripheral working both in
                                                      master and slave mode).

HAL_I2C_AbortCpltCallback()     I2Cx_ER_IRQHandler()  Signals that a STOP condition has been
                                                      raised and the I2C transaction has been
                                                      aborted (peripheral working both in
                                                      master and slave mode).
```
```
HAL_StatusTypeDef HAL_I2C_Master_Transmit_DMA(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);

HAL_StatusTypeDef HAL_I2C_Master_Receive_DMA(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size);
```

##### CubeMX LCD example

- `i2c-lcd.c`:
```
#include "i2c-lcd.h"
extern I2C_HandleTypeDef hi2c1;

#define SLAVE_ADDRESS_LCD 0x4E

// Control bits:
//            2    1    0
//           en  r/w   rs

void lcd_send_cmd(char cmd)
{
  char data_u, data_l;
  uint8_t data_t[4];
  data_u = (cmd&0xF0);
  data_l = ((cmd<<4)&0xF0);
  data_t[0] = data_u|0x0C;    // en=1, rs=0
  data_t[1] = data_u|0x08;    // en=0, rs=0
  data_t[2] = data_l|0x0C;    // en=1, rs=0
  data_t[3] = data_l|0x08;    // en=0, rs=0
  HAL_I2C_Master_Transmit(&hi2c1, SLAVE_ADDRESS_LCD, (uint8_t*)data_t, 4, 100);
}

void lcd_send_data(char data)
{
  char data_u, data_l;
  uint8_t data_t[4];
  data_u = (cmd&0xF0);
  data_l = ((cmd<<4)&0xF0);
  data_t[0] = data_u|0x0D;    // en=1, rs=1
  data_t[1] = data_u|0x09;    // en=0, rs=1
  data_t[2] = data_l|0x0D;    // en=1, rs=1
  data_t[3] = data_l|0x09;    // en=0, rs=1
  HAL_I2C_Master_Transmit(&hi2c1, SLAVE_ADDRESS_LCD, (uint8_t*)data_t, 4, 100);
}

void lcd_init(void)
{
  lcd_send_cmd(0x02);
  lcd_send_cmd(0x28);
  lcd_send_cmd(0x0C);
  lcd_send_cmd(0x80);
}

void lcd_send_string(char *str)
{
  while (*str) lcd_send_data(*str++);
}
```
- `main.c`:
```
...
  MX_I2C1_Init();

  lcd_init();
  lcd_send_string("HELLO WORLD!");

  while(1)
  {
    lcd_send_cmd(0x80);   // goto 1,1
    lcd_send_string("subscribe");
    lcd_send_cmd(0xC0);
    lcd_send_string("to this channel");
    HAL_Delay(2000);
    lcd_send_cmd(0x01);   // clear the display
    HAL_Delay(1000);
  }
```
