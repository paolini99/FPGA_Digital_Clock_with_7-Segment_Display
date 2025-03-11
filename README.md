# ⏰ Digital Clock with Seven-Segment Display

## Project Description  
This project implements a **digital clock** with a **seven-segment display**, operating in a **12-hour format**. The system manages **hours, minutes, and seconds**, with the ability to **manually adjust the time** and use an **independent stopwatch**.  

## 🔧 **Project Functionality**  

### ⏳ **Time Counting**
- The clock counts from **00:00:00 to 11:59:59**, automatically resetting.
- The time is displayed on **six seven-segment displays**:
  - **Hours (HEX4, HEX5)**
  - **Minutes (HEX2, HEX3)**
  - **Seconds (HEX0, HEX1)**
- The FPGA’s base clock (**50 MHz**) is reduced to **1 Hz** using a **clock divider**, allowing for real-time counting.
- The system uses **synchronized modular counters** to update seconds, minutes, and hours:
  - **Seconds**: resets after **60**.
  - **Minutes**: resets after **60**.
  - **Hours**: resets after **12**.

### 🎨 **Optimized Time Display**
- The leading **zero is removed** from the hours display when the value is below 10 (e.g., **"7:00"** instead of **"07:00"**).
- This is achieved through a **dedicated module** that turns off the most significant digit when needed.

### 🔧 **Manual Time Adjustment**
- Two buttons allow for **manual adjustment**:
  - **KEY[1]** → Increases the hours.
  - **KEY[2]** → Increases the minutes.
- The **KEY[0]** button performs a **global reset**, setting the clock back to **00:00:00**.
- A slow clock ensures smooth updates when adjusting the time.

## ⏱ **Extension: Stopwatch with Start, Stop, and Reset**
- The system includes an **independent stopwatch**, activated via a **selection switch**.
- Features:
  - **Measures time down to hundredths of a second**.
  - **Separate clock management** with a **100 Hz frequency** for precision.
- Controls:
  - **KEY[1]** → Starts or pauses the stopwatch.
  - **KEY[2]** → Stops the stopwatch.
  - **KEY[0]** → Resets the stopwatch to **00:00:00**.

## 🛠 **Technologies Used**
- **FPGA** for hardware-based time management.
- **Clock Divider** to generate the required frequency.
- **Synchronized modular counters** for hours, minutes, and seconds.
- **Multiplexer** to switch between clock and stopwatch display.

